/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.UserDAO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.UserDTO;
import java.io.IOException;
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
@WebServlet(name = "ViewRegisteredUserController", urlPatterns = {"/ViewRegisteredUserController"})
public class ViewRegisteredUserController extends HttpServlet {

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

        HttpSession session = request.getSession();
        String email = (String) request.getAttribute("email");

        if (email == null || eventID == null) {
            return false;
        }

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("errorMessage", "Please log in first");
        }

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            request.setAttribute("errorMessage", "The event does not exist");
            return false;
        }

        EventRegisterDAO eventRegisterDAO = new EventRegisterDAO();
        ArrayList<EventRegisterDTO> eventRegisterList = eventRegisterDAO.getRegisterList(eventID);
        if (eventRegisterList == null) {
            request.setAttribute("errorMessage", "There is no registration at the moment, please check again later!!!");
        }
        request.setAttribute("eventRegisterList", eventRegisterList);
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
            if(processRequest(request, response)){
                request.getRequestDispatcher("viewRegistrationPage").forward(request, response);
            }
            request.getRequestDispatcher(Routers.VIEW_MANAGEMENT_PAGE).forward(request, response);
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
