/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CatetoryDAO;
import daos.ClubDAO;
import daos.EventDAO;
import daos.EventStatusDAO;
import daos.LocationDAO;
import dtos.CatetoryDTO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.EventStatusDTO;
import dtos.LocationDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
@WebServlet(name = "ViewEventController", urlPatterns = {"/ViewEventController"})
public class ViewEventController extends HttpServlet {

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

        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 10, 5000, null);

        if (eventID == null) {
            return false;
        }

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            request.setAttribute("errorMessage", "Event does not exist");
            return false;
        }

        EventStatusDAO statusDAO = new EventStatusDAO();
        EventStatusDTO status = statusDAO.getStatusByID(event.getStatusID());

        CatetoryDAO catetoryDAO = new CatetoryDAO();
        CatetoryDTO catetory = catetoryDAO.getCatetoryByID(event.getCatetoryID());

        LocationDAO locationDAO = new LocationDAO();
        LocationDTO location = locationDAO.getLocationByID(event.getLocationID());

        ClubDAO clubDAO = new ClubDAO();
        ClubDTO club = clubDAO.getClubByID(event.getClubID());

        request.setAttribute("event", event);
        request.setAttribute("catetoryName", catetory.getCatetoryName());
        request.setAttribute("locationName", location.getLocationName());
        request.setAttribute("statusDescription", status.getStatusDescription());
        request.setAttribute("clubName", club.getClubName());
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
                request.getRequestDispatcher(Routers.VIEW_EVENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
