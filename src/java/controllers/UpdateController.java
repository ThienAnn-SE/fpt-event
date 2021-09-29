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
        String name = GetParam.getStringParam(request, "txtUserName", "Name", 0, 50, null);
        int gender = GetParam.getIntParams(request, "gender", "Gender", 0, 1, 1);
        Date dayOfBirth = GetParam.getDateParams(request, "txtDate", "Day of birth", null);
        String phoneNumber = GetParam.getPhoneParams(request, "txtPhoneNumber", "Phone number");

        //field validation
        if (name == null || phoneNumber == null) {
            return false;
        }


        //date of birth validation
        if(dayOfBirth == null){
            request.setAttribute("txtDateError", "Day of birth is required");
            return false;
        }
        
        if (dayOfBirth.after(Helper.getCurrentDate()) || dayOfBirth.before(Helper.convertStringToDate("1920-01-01"))) {
            request.setAttribute("txtDateError", "Invalid date of birth");
            return false;
        }
        String email = (String) request.getAttribute("email");

        //initialize resource
        UserDAO dao = new UserDAO();
        boolean result;

        try {
            //execute update to database
            String dob = Helper.convertDateToString(dayOfBirth);
            result = dao.updateUser(email, name, dob, gender, phoneNumber);

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
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        UserDAO dao = new UserDAO();
        try {
            if (email == null || dao.getUserByEmail(email) == null) {
                request.getRequestDispatcher(Routers.USER_INFO_PAGE).forward(request, response);
            }
            request.setAttribute("email", email);
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
        if (postHandler(request, response)) {
            response.sendRedirect(Routers.VIEW_USER_CONTROLLER + "?message=Update successfully");
        } else {
            request.getRequestDispatcher(Routers.USER_INFO_PAGE).forward(request, response);
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
