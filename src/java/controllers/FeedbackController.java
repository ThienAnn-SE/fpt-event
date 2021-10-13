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
import dtos.EventFeedbackDTO;
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
import javax.servlet.http.HttpSession;
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "FeedbackController", urlPatterns = {"/FeedbackController"})
public class FeedbackController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        Integer eventID = GetParam.getIntParams(request, "eventID", "EventID", 10, 5000, null);
        Integer vote = GetParam.getIntParams(request, "rate", "Rate", 1, 5, null);
        String feedback = GetParam.getStringParam(request, "feedback", "Feedback", 10, 100, null);

        if (eventID == null || vote == null || feedback == null) {
            return false;
        }

        EventDAO eventDAO = new EventDAO();
        if (eventDAO.getEventByID(eventID) == null) {
            request.setAttribute("errorMessage", "The event does not exist");
            return false;
        }

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        UserDAO userDAO = new UserDAO();
        if (userDAO.getUserByEmail(userEmail) != null) {
            request.setAttribute("errorMessage", "The user does not exist");
        }

        EventRegisterDAO registerDAO = new EventRegisterDAO();
        int registerID = registerDAO.getRegisterID(eventID, userEmail);
        if (registerID == 0) {
            request.setAttribute("errorMessage", "The user did not register this event");
        }

        EventFeedbackDAO feedbackDAO = new EventFeedbackDAO();
        return feedbackDAO.addNewFeedback(new EventFeedbackDTO(eventID, vote, feedback));
    }

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void getHanlder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        getHanlder(request, response);
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
                
            } else {

            }
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
