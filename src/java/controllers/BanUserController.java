/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.BanRequestDAO;
import daos.EventDAO;
import dtos.EventDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "BanUserController", urlPatterns = {"/user-ban"})
public class BanUserController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        EventDAO eventDAO = new EventDAO();
        BanRequestDAO banDAO = new BanRequestDAO();

        Integer eventID = GetParam.getIntParams(request, "eventID", "EventID", 0, Integer.MAX_VALUE, null);
        String email = GetParam.getEmailParams(request, "email", "Email");

        if (eventID == null || email == null) {
            throw new ServletException("Can not find paramter!");
        }

        if (!email.contains("@fpt.edu.vn")) {
            throw new IllegalArgumentException("Wrong email format, please use FPT email!");
        }

        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            throw new SQLException("Event does not exist!");
        }

        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));

        if (!banDAO.isReported(event.getClubID(), email)) {
            if (!banDAO.addNewRequest(event.getClubID(), email, now)) {
                throw new SQLException("Internal error!");
            }
            return true;
        } else {
            return false;
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
            int eventID = GetParam.getIntParams(request, "eventID", "EventID", 0, Integer.MAX_VALUE, null);
            if (postHandler(request, response)) {
                response.sendRedirect(Routers.VIEW_REGISTERED_USER_CONTROLLER + "?report=success&eventID=" + eventID);
            } else {
                response.sendRedirect(Routers.VIEW_REGISTERED_USER_CONTROLLER + "?report=fail&eventID=" + eventID);
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
