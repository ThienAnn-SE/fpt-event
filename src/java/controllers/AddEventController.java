/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.ClubDAO;
import daos.EventDAO;
import daos.LocationDAO;
import dtos.CategoryDTO;
import dtos.ClubDTO;
import dtos.LocationDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.FileHelper;
import utils.GetParam;
import utils.Helper;

/**
 *
 * @author thien
 */
@WebServlet(name = "AddEventController", urlPatterns = {"/event-add"})
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        //intialize resourse
        CategoryDAO categoryDAO = new CategoryDAO();
        ClubDAO clubDAO = new ClubDAO();
        LocationDAO locationDAO = new LocationDAO();

        //get category list
        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
        if (categoryList == null) {
            request.setAttribute("categoryError", "Category list is empty");
            return false;
        }
        //get host club
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        ClubDTO club = clubDAO.getClubByEmail(email);
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
        request.setAttribute("clubID", club.getClubID());
        request.setAttribute("categoryList", categoryList);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //initialized resource
        EventDAO eventDAO = new EventDAO();
        //get and validate params
        String eventName = GetParam.getStringParam(request, "eventName", "Event name", 10, 100, null);
        Integer clubID = GetParam.getIntParams(request, "clubID", "Club ID", 1, 500, null);
        Integer locationID = GetParam.getIntParams(request, "locationID", "Location", 1, 500, null);
        Integer categoryID = GetParam.getIntParams(request, "categoryID", "Category", 1, 500, null);
        Date createDate = Helper.getCurrentDate();
        Date registerEndDate = GetParam.getDateFromNowToFuture(request, "registerEndDate", "Registration end date", null);
        Date startDate = GetParam.getDateTimeFromNowToFuture(request, "startDate", "Start date", null);
        Date endDate = GetParam.getDateTimeFromNowToFuture(request, "endDate", "End date", null);
        Integer slot = GetParam.getIntParams(request, "slot", "Slot", 0, 5000, null);
        String imageURL = GetParam.getFileParam(request, "imageURL", "Image", 1024 * 1024, FileHelper.imageExtension);
        String content = GetParam.getStringParam(request, "content", "Content", 0, Integer.MAX_VALUE, null);
        Integer ticketFee = GetParam.getIntParams(request, "ticketFee", "Fee", 0, 10000000, 0);
        //
        if (eventName == null || clubID == null || locationID == null || categoryID == null || registerEndDate == null
                || startDate == null || endDate == null || slot == null || content == null || imageURL == null) {
            return false;
        }
        if (registerEndDate.after(startDate)) {
            request.setAttribute("endDateError", "Registration end date must before event start date");
            return false;
        }

        if (startDate.after(endDate)) {
            request.setAttribute("registerEndDateError", "Event end date must after event start date");
            return false;
        }

        //check event name is vailable
        if (eventDAO.checkExistedEventByEventName(eventName) != null) {
            request.setAttribute("eventNameError", "Event name is already taken");
            return false;
        }
        //check available time and location
        SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (eventDAO.checkAvailabeTimeAndPlace(frm.format(startDate), frm.format(endDate), locationID)) {
            request.setAttribute("locationIDError", "The location at that time is unavailable, please change the time or try another location");
            return false;
        }
        //add event
        return eventDAO.addEvent(eventName, clubID, locationID, categoryID, createDate, startDate, endDate, registerEndDate, slot, imageURL, content, ticketFee);
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
                request.getRequestDispatcher(Routers.EVENT_MANAGEMENT_CONTROLLER).forward(request, response);
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
                response.sendRedirect(Routers.EVENT_MANAGEMENT_CONTROLLER + "?add=success");
            } else {
                request.setAttribute("result", "fail");
                doGet(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errrorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
