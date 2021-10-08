/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.ClubDAO;
import daos.EventDAO;
import daos.UserDAO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "EventManagementController", urlPatterns = {"/EventManagementController"})
public class EventManagementController extends HttpServlet {

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
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, 500, null);
        Integer page = GetParam.getIntParams(request, "page", "Page", 1, 50, 1);
        if (eventID == null) {
            return false;
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        if (email == null) {
            request.setAttribute("errorMessage", "There is an erorr happen. Please reload the website");
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
            request.setAttribute("errorMessage", "This club does not exist or you do not have permission");
            return false;
        }

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList = eventDAO.getEventByClub(page, club.getClubID());
        request.setAttribute("eventList", eventList);
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
            if (processRequest(request, response)) {
                request.getRequestDispatcher(Routers.VIEW_REGISTRATION_PAGE).forward(request, response);
            }
            request.getRequestDispatcher(Routers.EVENT_MANAGEMENT_PAGE).forward(request, response);
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
