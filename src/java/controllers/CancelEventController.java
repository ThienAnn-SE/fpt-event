/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.EventDAO;
import dtos.EventDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
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
@WebServlet(name = "CancelEventController", urlPatterns = {"/CancelEventController"})
public class CancelEventController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void getHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);

        if (eventID == null) {
            throw new ServletException("Missing parameter");
        }

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);

        if (event == null) {
            request.setAttribute("errorMessage", "Event does not exist");
            throw new SQLException("Can not find the record");
        }

        request.setAttribute("event", event);
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
            getHandler(request, response);
            request.getRequestDispatcher(Routers.CANCEL_EVENT_PAGE).forward(request, response);
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
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws SQLException
     * @throws NamingException
     */
    protected boolean cancelEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);
        String reason = GetParam.getStringParam(request, "reason", "Reason", 0, Integer.MAX_VALUE, null);
        //check parameter
        if (eventID == null || reason == null) {
            return false;
        }
        //initialize resource
        EventDAO eventDAO = new EventDAO();
        //return result
        if (!eventDAO.changeEventStatus(eventID, 400)) {
            throw new SQLException("Some thing wrong happen when update event status for canceling event");
        }
        
        //send Email
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
        try {
            if(cancelEvent(request, response)){
                response.sendRedirect(Routers.EVENT_MANAGEMENT_CONTROLLER);
            }else{
                request.getRequestDispatcher(Routers.CANCEL_EVENT_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
