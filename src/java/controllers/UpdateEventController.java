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
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.FileHelper;
import utils.GetParam;

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

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @throws NamingException
     * @throws SQLException
     */
    private void updateEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        EventDAO eventDAO = new EventDAO();

        //get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 10, Integer.MAX_VALUE, null);

        if (eventID == null) {
            throw new ServletException("Missing parameter!");
        }

        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            throw new SQLException("Event with the given ID can not be found");
        }

        if (event.getStatusID() != 300) {
            throw new IllegalArgumentException("This event can not be updated anymore");
        }

        String eventName = GetParam.getStringParam(request, "eventName", "Event name", 10, 1000, event.getEventName());
        Integer categoryID = GetParam.getIntParams(request, "categoryID", "Category", 1, 500, event.getCategoryID());
        Integer locationID = GetParam.getIntParams(request, "locationID", "Location", 1, 500, event.getLocationID());
        Date registerEndDate = GetParam.getDateFromNowToFuture(request, "registerEndDate", "Registration end date", null);
        Date startDate = GetParam.getDateFromNowToFuture(request, "startDate", "Start Date", null);
        Date endDate = GetParam.getDateFromNowToFuture(request, "endDate", "End date", null);
        String imageURL = GetParam.getFileParam(request, "txtImageURL", "Image", 1024 * 1024, FileHelper.imageExtension);
        String content = GetParam.getStringParam(request, "txtContent", "Content", 0, Integer.MAX_VALUE, event.getContent());
        Integer ticketFee = GetParam.getIntParams(request, "ticketFee", "Ticket fee", 0, 10000000, event.getTicketFee());
        Integer slot = GetParam.getIntParams(request, "slot", "Slot", 0, 5000, event.getSlot());

        //validate paramter
        if (registerEndDate == null || startDate == null || endDate == null) {
            throw new IllegalArgumentException();
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        if (categoryDAO.getCategoryByID(categoryID) == null) {
            throw new SQLException("This category with given ID does not exist");
        }

        LocationDAO locationDAO = new LocationDAO();
        if (locationDAO.getLocationByID(locationID) == null) {
            throw new SQLException("This location with given ID does not exist");
        }

        if (registerEndDate.after(startDate)) {
            throw new IllegalArgumentException("Registration end date can not be after event start date");
        }

        if (startDate.after(endDate)) {
            throw new IllegalArgumentException("Event start date can not be after event end date");
        }

        EventRegisterDAO registerDAO = new EventRegisterDAO();
        if (registerDAO.getRegisterNumByEventID(eventID) > slot) {
            throw new IllegalArgumentException("Current number of registration is greater than your input slot");
        }

        if (imageURL == null) {
            imageURL = event.getImageURL();
        } else {
            File oldImageURL = new File(event.getImageURL());
            if (!oldImageURL.delete()) {
                //delete the current image
                throw new ServletException("Failed to delete the current event image");
            }
        }

        SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        event = new EventDTO(eventID, eventName, locationID, categoryID, frm.format(registerEndDate), frm.format(startDate), frm.format(endDate), slot, imageURL, content, ticketFee);
        if (!eventDAO.UpdateEvent(event)) {
            throw new SQLException("Internal error!");
        }

        //send email
        response.sendRedirect(Routers.EVENT_MANAGEMENT_CONTROLLER + "?update=success");
    }

    /**
     *
     * @param request
     * @param response
     * @throws SecurityException
     * @throws IOException
     * @throws NamingException
     * @throws SQLException
     */
    private void cancelEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);
        if (eventID == null) {
            throw new ServletException("Missing parameter!");
        }

        EventDAO eventDAO = new EventDAO();

        if (eventDAO.getEventByID(eventID) == null) {
            throw new SQLException("Event does not exist!");
        }

        if (!eventDAO.changeEventStatus(eventID, 400)) {
            throw new SQLException("Internal error!");
        }

        response.sendRedirect(Routers.EVENT_MANAGEMENT_CONTROLLER + "?cancel=success");
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
        try {
            //get parameter
            String action = GetParam.getStringParam(request, "action", "Action", 0, 10, null);
            //check valid parameter
            if (action != null) {
                //perform action
                if (action.equalsIgnoreCase("update")) {
                    updateEvent(request, response);
                }
                if (action.equalsIgnoreCase("cancel")) {
                    cancelEvent(request, response);
                }
            } else {
                throw new ServletException("Missing paramter!");
            }
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            doGet(request, response);
        } catch (IOException | SQLException | NamingException | ServletException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
