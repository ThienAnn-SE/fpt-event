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
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.GetParam;
import utils.Helper;
import utils.PaymentServices;

/**
 *
 * @author thien
 */
@WebServlet(name = "RegisterEventController", urlPatterns = {"/RegisterEventController"})
public class RegisterEventController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws Exception if a error occurs
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //get Parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, 5000, null);
        String email = GetParam.getStringParam(request, "email", "Email", 0, 50, null);

        //check parameter
        if (eventID == null || email == null) {
            return false;
        }

        //get current date
        String registerDate = new SimpleDateFormat("yyyy-MM-dd").format(System.currentTimeMillis());

        //initialize resouce
        EventRegisterDAO registerDAO = new EventRegisterDAO();

        //add registration
        return registerDAO.addNewEventRegistration(new EventRegisterDTO(eventID, email, registerDate));
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws Exception if a error occurs
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        //Initialized resources
        UserDAO userDAO = new UserDAO();
        EventDAO eventDAO = new EventDAO();

        //Get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 10, Integer.MAX_VALUE, null);

        if (eventID == null) {
            return false;
        }
        //check existed event by ID
        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            request.setAttribute("errorMessage", "Event is not existed");
            return false;
        }

        //check avaialable remaining event slot to register
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        int registerNum = registerDAO.getRegisterNumByEventID(eventID);

        if (registerNum >= event.getSlot()) {
            request.setAttribute("errorMessage", "Event is full");
            return false;
        }

        //get user email
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        UserDTO user = userDAO.getUserByEmail(email);

        //check isBanned/new/invalid?
        if (user.getStatus() != 500) {
            request.setAttribute("errorMessage", "You are not allow to register");
            return false;
        }
        //on success
        request.setAttribute("user", user);
        request.setAttribute("event", event);
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
                request.getRequestDispatcher(Routers.REVIEW_PAYMENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.SEARCH_EVENT_PAGE + "?" + request.getQueryString()).forward(request, response);
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

            String btAction = GetParam.getStringParam(request, "btAction", "Action", 1, 50, null);

            if (btAction.equalsIgnoreCase("pay")) {
                //
                request.getRequestDispatcher(Routers.EXECUTE_PAYMENT_CONTROLLER).forward(request, response);
            } else {
                if (postHandler(request, response)) {
                    request.getRequestDispatcher(Routers.SEARCH_EVENT_CONTROLLER).forward(request, response);
                } else {
                    request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                }
            }

        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
