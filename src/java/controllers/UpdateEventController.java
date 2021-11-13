/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.LocationDAO;
import dtos.CategoryDTO;
import dtos.EventDTO;
import dtos.LocationDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.FileHelper;
import utils.GetParam;
import utils.Helper;

/**
 *
 * @author thien
 */
@WebServlet(name = "UpdateEventController", urlPatterns = {"/UpdateEventController"})
public class UpdateEventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        EventDAO eventDAO = new EventDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        LocationDAO locationDAO = new LocationDAO();

        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);
        if (eventID == null) {
            return false;
        }

        EventDTO event = eventDAO.getEventByID(eventID);

        //check available to edit
        if (event.getStatusID() != 300) {
            request.setAttribute("error", "You can not edit this event anymore");
            return false;
        }

        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();

        request.setAttribute("event", event);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("locationList", locationList);
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
        try {
            if (getHandler(request, response)) {
                request.getRequestDispatcher(Routers.UPDATE_EVENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.EVENT_MANAGEMENT_CONTROLLER).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

    protected boolean updateEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //get parameter
        Integer eventID = GetParam.getIntParams(request, "txtEventID", "Event ID", 10, Integer.MAX_VALUE, null);
        String eventName = GetParam.getStringParam(request, "txtEventName", "Event name", 10, 1000, null);
        Integer categoryID = GetParam.getIntParams(request, "txtCategoryID", "Category", 1, 500, null);
        Integer locationID = GetParam.getIntParams(request, "txtLocationID", "Location", 1, 500, null);
        Date registerEndDate = GetParam.getDateFromNowToFuture(request, "txtRegisterEndDate", "Registration end date", null);
        Date startDate = GetParam.getDateFromNowToFuture(request, "txtStartDate", "Start Date", null);
        Date endDate = GetParam.getDateFromNowToFuture(request, "txtEndDate", "End date", null);
        String imageURL = GetParam.getFileParam(request, "txtImageURL", "Image", 1024 * 1024, FileHelper.imageExtension);
        String content = GetParam.getStringParam(request, "txtContent", "Content", 0, Integer.MAX_VALUE, null);
        Integer ticketFee = GetParam.getIntParams(request, "txtTicketFee", "Ticket fee", 0, 10000000, 0);
        Integer slot = GetParam.getIntParams(request, "txtSlot", "Slot", 0, 5000, null);
        //validate paramter
        if (eventID == null || eventName == null || categoryID == null || locationID == null || registerEndDate == null
                || startDate == null || endDate == null || content == null || slot == null) {
            return false;
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        if (categoryDAO.getCategoryByID(categoryID) == null) {
            request.setAttribute("errorMessage", "This category with given ID does not exist");
            return false;
        }

        LocationDAO locationDAO = new LocationDAO();
        if (locationDAO.getLocationByID(locationID) == null) {
            request.setAttribute("errorMessage", "This location with given ID does not exist");
        }

        if (registerEndDate.after(startDate)) {
            request.setAttribute("errorMessage", "Registration end date can not be after event start date");
            return false;
        }

        if (startDate.after(endDate)) {
            request.setAttribute("errorMessage", "Event start date can not be after event end date");
            return false;
        }

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            request.setAttribute("errorMessage", "Event with the given ID can not be found");
            return false;
        }

        if (event.getStatusID() != 300) {
            request.setAttribute("errorMessage", "This event can not be updated anymore");
            return false;
        }

        EventRegisterDAO registerDAO = new EventRegisterDAO();
        if (registerDAO.getRegisterNumByEventID(eventID) > slot) {
            request.setAttribute("errorMessage", "Current number of registration is greater than your input slot");
            return false;
        }

        if (imageURL == null) {
            imageURL = event.getImageURL();
        } else {
            File oldImageURL = new File(event.getImageURL());
            if (!oldImageURL.delete()) {
                //delete the current image
                request.setAttribute("errorMessage", "Failed to delete the current event image");
                return false;
            }
        }

        SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        event = new EventDTO(eventID, eventName, locationID, categoryID, frm.format(registerEndDate), frm.format(startDate), frm.format(endDate), slot, imageURL, content, ticketFee);
        boolean result = eventDAO.UpdateEvent(event);
        if (!result) {
            request.setAttribute("errorMessage", "Some thing went wrong, please try again later!!");
            return false;
        }

        //send email
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean result = false;
        try {
            //get parameter
            String btAction = GetParam.getStringParam(request, "btAction", "Action", 0, 50, null);
            //check valid parameter
            if (btAction != null) {
                //perform action
                result = updateEvent(request, response);
                //return result
                if (result) {
                    response.sendRedirect(Routers.EVENT_MANAGEMENT_CONTROLLER);
                } else {
                    request.getRequestDispatcher(Routers.UPDATE_EVENT_PAGE).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (IOException | SQLException | NamingException | ServletException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
