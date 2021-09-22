/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import dtos.GoogleDTO;
import daos.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.GetParam;
import utils.GoogleHelpers;

/**
 *
 * @author thien
 */
@WebServlet(name = "GoogleLoginController", urlPatterns = {"/GoogleLoginController"})
public class GoogleLoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = GetParam.getStringParam(request, "code", "Code", 0, Integer.MAX_VALUE, "null");
        if (code == null) {
            request.setAttribute("error", "Please login first!");
            return false;
        }
        String accessToken = GoogleHelpers.getToken(code);
        GoogleDTO googleDao = GoogleHelpers.getUserInfo(accessToken);
        String email = googleDao.getEmail();

        if (!email.contains("@fpt.edu.vn")) {
            request.setAttribute("error", "Please using FPT email");
            return false;
        }
        request.setAttribute("email", googleDao.getEmail());
        request.setAttribute("name", googleDao.getName());
        request.setAttribute("avatar", googleDao.getPicture());
        return true;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!processRequest(request, response)) {
            request.getRequestDispatcher(Routers.LOGIN_PAGE).forward(request, response);
        } else {
            UserDAO dao = new UserDAO();
            try {
                if (dao.isExisted(request.getParameter((String) request.getAttribute("email")))) {
                    HttpSession session = request.getSession();
                    session.setAttribute("name", request.getAttribute("name"));
                    session.setAttribute("avatar", request.getAttribute("avatar"));
                    response.sendRedirect(Routers.INDEX_PAGE);
                } else {
                    request.getRequestDispatcher(Routers.REGISTER_CONTROLLER).forward(request, response);
                }
            } catch (SQLException | NamingException ex) {
                log(ex.getMessage());
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
