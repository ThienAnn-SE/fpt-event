/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.paypal.base.rest.PayPalRESTException;
import constant.Routers;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.PaymentDAO;
import daos.UserDAO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.PaymentDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AutoMailerHelper;
import utils.GetParam;
import utils.PaymentServices;

/**
 *
 * @author thien
 */
@WebServlet(name = "RegisterEventController", urlPatterns = {"/RegisterEventController"})
public class RegisterEventController extends HttpServlet {

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
        //Initialized resources
        UserDAO userDAO = new UserDAO();
        EventDAO eventDAO = new EventDAO();
        HttpSession session = request.getSession();

        //Get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 10, Integer.MAX_VALUE, null);
        String email = (String) session.getAttribute("email");

        //validate id
        if (eventID == null) {
            return false;
        }

        //check existed event by ID
        EventDTO event = eventDAO.getEventByID(eventID);
        if (event == null) {
            request.setAttribute("errorMessage", "Event is not existed");
            return false;
        }

        //check user registration
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        if (registerDAO.getRegisterID(eventID, email) > 0) {
            request.setAttribute("errorMessage", "You already register this event");
            return false;
        }

        //loi o day
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
        Date date = new Date(System.currentTimeMillis());
        date = format.parse(format.format(date));
        //check end of registration date
        if (date.after(format.parse(event.getRegisterEndDate()))) {
            request.setAttribute("errorMessage", "End of registration date, you can not register this event anymore");
            return false;
        }

        //check avaialable remaining event slot to register
        int registerNum = registerDAO.getRegisterNumByEventID(eventID);
        if (registerNum >= event.getSlot()) {
            request.setAttribute("errorMessage", "Event is full");
            return false;
        }

        //get user by email
        UserDTO user = userDAO.getUserByEmail(email);

        //check isBanned/new/invalid?
        if (user.getStatus() != 500) {
            request.setAttribute("errorMessage", "You are not allow to register because of your account status!");
            return false;
        }
        //on success
        //send Email

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
                request.getRequestDispatcher(Routers.SEARCH_EVENT_CONTROLLER).forward(request, response);
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

            String btAction = GetParam.getStringParam(request, "payment", "Payment", 1, 50, null);

            if (btAction == null) {
                if (postHandler(request, response)) {
                    response.sendRedirect(Routers.SEARCH_EVENT_CONTROLLER + "?success=true");
                } else {
                    request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                }
            } else if (btAction.equalsIgnoreCase("paypal")) {
                String result = executePaymentHanlder(request, response);
                if (result == null) {
                    request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                } else {
                    response.sendRedirect(result);
                }
            } else {
                if (executeCashHandler(request, response)) {
                    response.sendRedirect(Routers.SEARCH_EVENT_CONTROLLER + "?success=true");
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
        HttpSession session = request.getSession();
        //get Parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);
        String email = (String) session.getAttribute("email");
        //check parameter
        if (eventID == null || email == null) {
            return false;
        }

        //get current date
        String registerDate = new SimpleDateFormat("yyyy-MM-dd").format(System.currentTimeMillis());

        //initialize resouce
        EventRegisterDAO registerDAO = new EventRegisterDAO();

        //add registration
        if (!registerDAO.addNewEventRegistration(new EventRegisterDTO(eventID, email, registerDate))) {
            request.setAttribute("errorMessage", "Internal error!");
            return false;
        }
        EventDAO eventDAO = new EventDAO();

       // AutoMailerHelper sendMail = new AutoMailerHelper();

       // sendMail.sendEventRegistrationMail(email, eventDAO.getEventByID(eventID).getEventName());

        return true;
    }

    /**
     *
     *
     * @param request
     * @param response
     * @return
     * @throws PayPalRESTException
     * @throws NamingException
     * @throws SQLException
     */
    protected String executePaymentHanlder(HttpServletRequest request, HttpServletResponse response)
            throws PayPalRESTException, NamingException, SQLException {
        //get value from parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);
        //validate paramter value
        if (eventID == null) {
            return null;
        }
        //get current session
        HttpSession session = request.getSession();
        //set attribute
        session.setAttribute("eventID", eventID);
        //get user email
        String email = (String) session.getAttribute("email");
        //get current date
        String registerDate = new SimpleDateFormat("yyyy-MM-dd").format(System.currentTimeMillis());
        //initialize resource
        PaymentServices paymentServies = new PaymentServices();
        return paymentServies.authorizePayment(new EventRegisterDTO(eventID, email, registerDate));
    }

    protected boolean executeCashHandler(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, NamingException, SQLException, MessagingException {
        response.setContentType("text/html;charset=UTF-8");
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);

        if (eventID == null) {
            return false;
        }

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        String registerDate = new SimpleDateFormat("yyyy-MM-dd").format(System.currentTimeMillis());

        EventRegisterDAO registerDAO = new EventRegisterDAO();

        if (!registerDAO.addNewEventRegistration(new EventRegisterDTO(eventID, email, registerDate))) {
            request.setAttribute("errorMessage", "Can not add your registration");
            return false;
        }

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);

        PaymentDAO paymentDAO = new PaymentDAO();
        int registerID = registerDAO.getRegisterID(eventID, email);

        String description = String.format("[%s] - %s", event.getEventName(), email);
        if (!paymentDAO.addNewPayment(new PaymentDTO(registerID, description, "pending", "cash", registerDate, event.getTicketFee()))) {
            request.setAttribute("errorMessage", "internal error");
            return false;
        }

        //AutoMailerHelper sendMail = new AutoMailerHelper();

        //sendMail.sendEventRegistrationMail(email, event.getEventName());
        return true;
    }
}
