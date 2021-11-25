/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.EventDAO;
import daos.EventFeedbackDAO;
import daos.EventRegisterDAO;
import daos.UserDAO;
import dtos.EventDTO;
import dtos.EventFeedbackDTO;
import dtos.EventRegisterDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
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
@WebServlet(name = "FeedbackController", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected void postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");

        EventRegisterDAO registerDAO = new EventRegisterDAO();
        UserDAO userDAO = new UserDAO();

        Integer registerID = GetParam.getIntParams(request, "registerID", "EventID", 10, Integer.MAX_VALUE, null);
        Integer vote = GetParam.getIntParams(request, "rate", "Rate", 1, 5, null);
        String feedback = GetParam.getStringParam(request, "feedback", "Feedback", 10, 100, null);

        if (registerID == null || vote == null || feedback == null) {
            request.setAttribute("eventID", registerDAO.getRegistrationByID(registerID).getEventID());
            throw new IllegalArgumentException();
        }

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        if (userDAO.getUserByEmail(userEmail) == null) {
            throw new SQLException("User does not exist!");
        }

        EventRegisterDTO registration = registerDAO.getRegistrationByID(registerID);
        if (registration == null) {
            throw new SQLException("You did not register this event!");
        }

        EventFeedbackDAO feedbackDAO = new EventFeedbackDAO();
        if (!feedbackDAO.addNewFeedback(new EventFeedbackDTO(registerID, vote, feedback))) {
            throw new SQLException("Internal error!");
        }
        response.sendRedirect(Routers.VIEW_USER_CONTROLLER + "?rating=success");
    }

    /**
     * Processes requests for HTTP <code>GET</code> methods when user want to
     * view an event feedback.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected void viewFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        //get paramter
        Integer eventID = GetParam.getIntParams(request, "eventID", "EventID", 0, Integer.MAX_VALUE, null);
        //validate
        if (eventID == null) {
            throw new ServletException("parameter does not exist!");
        }
        //initialize resource
        EventFeedbackDAO feedbackDAO = new EventFeedbackDAO();
        //get feedback list
        ArrayList<EventFeedbackDTO> feedbackList = feedbackDAO.getEventFeedbackList(eventID);
        //on success
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher(Routers.VIEW_FEEDBACK_PAGE).forward(request, response);
    }

    /**
     * Processes requests for HTTP <code>GET</code> methods when user want to
     * rating for an event.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected void ratingEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        //initialized resource
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        EventDAO eventDAO = new EventDAO();
        EventFeedbackDAO feedbackDAO = new EventFeedbackDAO();
        HttpSession session = request.getSession();

        //get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);

        //validate
        if (eventID == null) {
            throw new ServletException("Parameter does not exist!");
        }

        //get event by event ID
        EventDTO event = eventDAO.getEventByID(eventID);
        //validate
        if (event == null) {
            throw new SQLException("Event does not exist");
        }

        //get user email
        String userEmail = (String) session.getAttribute("email");

        //get user registration ID
        int registerID = registerDAO.getRegisterID(eventID, userEmail);

        //validate
        if (registerID == 0) {
            throw new SQLException("User does not attend this event!");
        }

        if (feedbackDAO.isFeedbacked(registerID)) {
            response.sendRedirect(Routers.VIEW_USER_CONTROLLER + "?feedback=fail");
        } else {
            //set request attribute
            request.setAttribute("eventName", event.getEventName());
            request.setAttribute("registerID", registerID);
            request.getRequestDispatcher(Routers.USER_FEEDBACK_PAGE).forward(request, response);
        }
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
            //get action
            String action = GetParam.getStringParam(request, "action", "Action", 0, 10, null);
            //validate
            if (action == null) {
                throw new ServletException("Parameter does not exist!");
            }
            //do action
            if (action.equalsIgnoreCase("rate")) {
                ratingEvent(request, response);
            } else if (action.equalsIgnoreCase("view")) {
                viewFeedback(request, response);
            }

        } catch (SQLException | NamingException ex) {
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
            postHandler(request, response);
        } catch (IllegalArgumentException ex) {
            int eventID = (int) request.getAttribute("eventID");
            response.sendRedirect(Routers.FEEDBACK_CONTROLLER + "?feedback=fail&action=rate&eventID=" + eventID);
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
