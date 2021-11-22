/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.BanRequestDAO;
import daos.ClubDAO;
import daos.UserDAO;
import dtos.BanRequestDTO;
import dtos.ClubDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "AdminFormController", urlPatterns = {"/AdminFormController"})
public class AdminFormController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void getHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        UserDAO userDAO = new UserDAO();
        ArrayList<UserDTO> userBanList = userDAO.getUserBanList();

        ClubDAO clubDAO = new ClubDAO();
        ArrayList<ClubDTO> clubList = clubDAO.getAllClubs();

        //get Ban request list
        BanRequestDAO banRequestDAO = new BanRequestDAO();
        ArrayList<BanRequestDTO> banRequestList = banRequestDAO.getBanRequestList();

        request.setAttribute("banRequestList", banRequestList);
        request.setAttribute("userBanList", userBanList);
        request.setAttribute("clubList", clubList);
    }

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String email = GetParam.getStringParam(request, "email", "Email", 0, 50, null);
        String btAction = GetParam.getStringParam(request, "btAction", "Action", 0, 30, null);
        String reason = GetParam.getStringParam(request, "reason", "Reason", 0, 100, null);

        if (email == null || btAction == null || reason == null) {
            return false;
        }

        boolean isSuccess;
        UserDAO userDAO = new UserDAO();
        if (btAction.equalsIgnoreCase("ban")) {
            isSuccess = userDAO.changeUserStatus(email, 450);
        } else {
            isSuccess = userDAO.changeUserStatus(email, 400);
        }

        if (isSuccess) {
            request.setAttribute("successMessage", "Your action is success!!");
        } else {
            request.setAttribute("errorMessage", "Your action is fail, please check again!!!");
        }
        return isSuccess;
    }

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
        try {
            getHandler(request, response);
            request.getRequestDispatcher(Routers.ADMIN_FORM_PAGE).forward(request, response);
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
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
        try {
            postHandler(request, response);
            request.getRequestDispatcher(Routers.ADMIN_FORM_PAGE).forward(request, response);
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
