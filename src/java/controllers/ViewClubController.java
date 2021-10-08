/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.ClubDAO;
import daos.UserDAO;
import dtos.ClubDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "ViewClubController", urlPatterns = {"/ViewClubController"})
public class ViewClubController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        String clubName = GetParam.getStringParam(request, "clubName", "Club name", 0, 50, null);
        String clubDescription = GetParam.getStringParam(request, "clubDescription", "Club description", 0, 1000, null);
        String phoneNumber = GetParam.getPhoneParams(request, "phoneNumber", "Club phone number");
        String clubEmail = GetParam.getEmailParams(request, "clubEmail", "Club email");

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (clubName == null || clubDescription == null || phoneNumber == null
                || clubEmail == null || userEmail == null) {
            return false;
        }

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByEmail(userEmail);
        if (user == null) {
            request.setAttribute("errorMessage", "Please log in first");
            return false;
        }

        ClubDAO clubDAO = new ClubDAO();
        ClubDTO club = clubDAO.getClubByEmail(userEmail);
        if (club == null) {
            request.setAttribute("errorMessage", "There is no available club right now. Please comeback later!");
            return false;
        }

        return clubDAO.updateClubInformation(new ClubDTO(clubName, clubDescription, clubEmail, phoneNumber), userEmail);
    }

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = (HttpSession) request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            return false;
        }

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("errorMessage", "Please log in first");
            return false;
        }

        ClubDAO clubDAO = new ClubDAO();
        ClubDTO club = clubDAO.getClubByEmail(email);
        if (club == null) {
            request.setAttribute("errorMessage", "There is no available club right now. Please comeback later!");
            return false;
        }

        request.setAttribute("club", club);
        return true;
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
            if (getHandler(request, response)) {
                request.getRequestDispatcher(Routers.VIEW_CLUB_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.HOME_PAGE).forward(request, response);
            }
        } catch (Exception ex) {
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
            if (postHandler(request, response)) {
                response.sendRedirect(Routers.VIEW_CLUB_PAGE);
            }
            request.getRequestDispatcher(Routers.VIEW_CLUB_PAGE).forward(request, response);
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
