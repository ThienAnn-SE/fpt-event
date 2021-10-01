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
import daos.LocationDAO;
import dtos.CatetoryDTO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.LocationDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.GetParam;
import utils.Helper;

/**
 *
 * @author thien
 */
@WebServlet(name = "AddEventController", urlPatterns = {"/AddEventController"})
public class AddEventController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws Exception if a error occurs
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        //intialize resourse
        CatetoryDAO catetoryDAO = new CatetoryDAO();
        ClubDAO clubDAO = new ClubDAO();
        LocationDAO locationDAO = new LocationDAO();

        //get catetory list
        ArrayList<CatetoryDTO> catetoryList = catetoryDAO.getAllCatetories();
        if (catetoryList == null) {
            request.setAttribute("catetoryError", "Catetory list is empty");
            return false;
        }
        //get host club
        ClubDTO club = clubDAO.getClubByEmail((String) request.getAttribute("email"));
        if (club == null) {
            request.setAttribute("clubError", "Can not find the club");
            return false;
        }
        //get location list
        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();
        if (locationList == null) {
            request.setAttribute("locationError", "Location list is empty");
            return false;
        }

        //on success validation
        request.setAttribute("catetoryList", catetoryList);
        request.setAttribute("club", club);
        request.setAttribute("locationList", locationList);
        return true;
    }

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
        //initialized resource
        EventDAO eventDAO = new EventDAO();

        //get and validate params
        String eventName = GetParam.getStringParam(request, "txtEventName", "Event name", 10, 50, null);
        Integer clubID = GetParam.getIntParams(request, "txtClubID", "Club ID", 1, 500, null);
        Integer locationID = GetParam.getIntParams(request, "txtLocationID", "Location", 1, 500, null);
        Integer catetoryID = GetParam.getIntParams(request, "txtCatetoryID", "Catetory", 1, 500, null);
        Date createDate = Helper.getCurrentDate();
        Date startDate = GetParam.getDateFromNowToFuture(request, "txtStartDate", "Start date", null);
        Date endDate = GetParam.getDateFromNowToFuture(request, "txtEndDate", "End date", null);
        String content = GetParam.getStringParam(request, "txtContent", "Content", 0, Integer.MAX_VALUE, null);
        int fee = GetParam.getIntParams(request, "txtFee", "Fee", 0, 1, 0);
        //
        if (eventName == null || clubID == null || locationID == null || catetoryID == null
                || startDate == null || endDate == null || content == null) {
            return false;
        }

        if (startDate.after(endDate)) {
            request.setAttribute("errorMessage", "End date must after start date");
            return false;
        }

        //check event name is vailable
        if (!eventDAO.checkExistedEventByEventName(eventName)) {
            request.setAttribute("txtEventNameError", "Event name is already taken");
            return false;
        }
        //check available day

        //check available location
        //add event
        return eventDAO.addEvent(eventName, clubID, locationID, catetoryID, createDate, startDate, endDate, content, fee);
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
                request.getRequestDispatcher(Routers.ADD_EVENT_PAGE).forward(request, response);
            } else {

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
                response.sendRedirect(""+"?message=Add event successfully");
            } else {
                request.getRequestDispatcher("").forward(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errrorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
