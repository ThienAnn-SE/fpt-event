/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import dtos.GoogleDTO;
import daos.UserDAO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AutoMailerHelper;
import utils.GetParam;
import utils.GoogleHelpers;

/**
 *
 * @author thien
 */
@WebServlet(name = "GoogleLoginController", urlPatterns = {"/login"})
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
            request.setAttribute("loginError", "Please login first!");
            return false;
        }
        String accessToken = GoogleHelpers.getToken(code);
        GoogleDTO googleDao = GoogleHelpers.getUserInfo(accessToken);
        String email = googleDao.getEmail();

        if (!email.contains("@fpt.edu.vn")) {
            request.setAttribute("loginError", "Please using FPT email for login!");
            return false;
        }
        request.setAttribute("email", email);
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
            request.getRequestDispatcher(Routers.HOME_PAGE_CONTROLLER).forward(request, response);
        } else {
            UserDAO dao = new UserDAO();
            String email = (String) request.getAttribute("email");
            HttpSession session = request.getSession();
            try {
                UserDTO user = dao.getUserByEmail(email);
                if (user != null) {
                    session.setAttribute("name", user.getName());
                    session.setAttribute("role", user.getRole());
                } else {
                    if (firstLoginRegister(email)) {
                        user = dao.getUserByEmail(email);
                        session.setAttribute("role", user.getRole());
                    } else {
                        request.setAttribute("error", "Internal error");
                        request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                    }
                }

                //on success
                session.setAttribute("email", email);
                session.setAttribute("avatar", request.getAttribute("avatar"));
                if (user.getRole() == 10) {
                    response.sendRedirect(Routers.ADMIN_DASHBOARD_CONTROLLER);
                } else {
                    response.sendRedirect(Routers.HOME_PAGE_CONTROLLER + "?action=Login successfully");
                }
            } catch (SQLException | NamingException | MessagingException ex) {
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

    private boolean firstLoginRegister(String email) throws MessagingException {
        UserDAO dao = new UserDAO();
        try {
            if (dao.addUser(new UserDTO(email, 1, 300))) {
                AutoMailerHelper sendMail = new AutoMailerHelper();
                sendMail.sendAccountRegistrationMail(email);
                return true;
            }
            return false;
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            return false;
        }
    }
}
