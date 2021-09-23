/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.UserDAO;
import dtos.UserDTO;
import java.io.IOException;
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
import javax.servlet.http.HttpSession;
import utils.GetParam;
import utils.Helper;

/**
 *
 * @author thien
 */
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {

    /**
     * Processes requests for <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws Exception if a error occurs
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        UserDAO dao = new UserDAO();

        //
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("name");
        if (userName == null) {
            return false;
        }
        UserDTO existedUser = dao.getUserByName(userName);
        if (existedUser == null) {
            request.setAttribute("errorMessage", "User with this given name was not found");
            return false;
        }
        request.setAttribute("user", existedUser);
        return true;
    }

    /**
     * Processes requests for <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get param field from request and validation
        String email = GetParam.getStringParam(request, "txtEmail", "Email", 0, 0, null);
        String name = GetParam.getStringParam(request, "txtUserName", "Name", 0, 50, null);
        int gender = GetParam.getIntParams(request, "gender", "Gender", 0, 1, 1);
        Date dateOfBirth = GetParam.getDateParams(request, "txtDate", "Date of birth", null);
        String phoneNumber = GetParam.getPhoneParams(request, "txtPhoneNumber", "Phone number");

        //field validation
        if (name == null || phoneNumber == null) {
            return false;
        }

        //date of birth validation
        if (dateOfBirth.after(Helper.getCurrentDate()) || dateOfBirth.before(Helper.convertStringToDate("1920-01-01"))) {
            request.setAttribute("txtDateError", "Invalid date of birth");
            return false;
        }

        //initialize resource
        UserDAO dao = new UserDAO();
        boolean result;

        try {
            //execute update to database
            result = dao.updateUser(email, name, dateOfBirth, gender, phoneNumber);

            //check update result
            if (!result) {
                request.setAttribute("errorMessage", "Internal error!");
            }
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            return false;
        }
        return result;
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
        try {
            if (this.getHandler(request, response)) {
                request.getRequestDispatcher(Routers.UPDATE_PAGE).forward(request, response);
            }
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);

        } catch (Exception ex) {
            log(ex.getMessage());
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
        //get email field for checking existence of user in database
        String email = GetParam.getEmailParams(request, "txtEmail", "Email");
        UserDAO dao = new UserDAO();
        try {
            if (!dao.isExisted(email) || email == null) {
                request.getRequestDispatcher(Routers.UPDATE_CONTROLLER).forward(request, response);
            }
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
        }
        if (postHandler(request, response)) {
            response.sendRedirect(Routers.UPDATE_PAGE + "?message=Update successfully");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
