/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.UserDAO;
import dtos.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws IOException if an error occurs
     */
    protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String email = GetParam.getEmailParams(request, "email", "Email");
        String name = GetParam.getStringParam(request, "name", "Name", 0, 50, null);
        Date dayOfBirth = GetParam.getDateParams(request, "dayOfBirth", "Day of birth", null);
        boolean gender = (GetParam.getIntParams(request, "gender", "Gender", 0, 1, 1) == 1);
        String phoneNumber = GetParam.getPhoneParams(request, "phoneNumber", null);

        if (name == null || dayOfBirth == null || phoneNumber == null) {
            return false;
        }

        User user = new User(email, name, dayOfBirth, gender, phoneNumber, 0, 400);
        UserDAO dao = new UserDAO();
        dao.addUser(user);
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
        request.getRequestDispatcher(Routers.INDEX_PAGE).forward(request, response);
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
            if (processRequest(request, response)) {
                response.sendRedirect(Routers.INDEX_PAGE);
            } else {
                request.getRequestDispatcher(Routers.REGISTER_PAGE).forward(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
