/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.payment;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import constant.Routers;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.PaymentDAO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.PaymentDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.PaymentServices;

/**
 *
 * @author thien
 */
@WebServlet(name = "ExecutePaymentController", urlPatterns = {"/ExecutePaymentController"})
public class ExecutePaymentController extends HttpServlet {

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
     * @throws com.paypal.base.rest.PayPalRESTException
     */
    protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException, PayPalRESTException {
        response.setContentType("text/html;charset=UTF-8");
        //get current session
        HttpSession session = request.getSession();
        //get data from session
        String userEmail = (String) session.getAttribute("email");
        int eventID = (int) session.getAttribute("eventID");
        //get current Date
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
        //add new registration
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        if (!registerDAO.addNewEventRegistration(new EventRegisterDTO(eventID, userEmail, currentDate))) {
            //error happen
            return false;
        }

        //get payment parameter
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        //execute payment
        PaymentServices paymentServices = new PaymentServices();
        Payment payment = paymentServices.executePayment(paymentId, payerId);
        //get payment information
        PayerInfo payerInfo = payment.getPayer().getPayerInfo();
        Transaction transaction = payment.getTransactions().get(0);

        //get the registerID
        int registerID = registerDAO.getRegisterID(eventID, userEmail);
        //get the amount 
        double amount = Double.parseDouble(transaction.getAmount().getTotal());

        EventDAO eventDAO = new EventDAO();
        EventDTO event = eventDAO.getEventByID(eventID);
        //payment description
        String description = String.format("[%s] - %s", event.getEventName(), userEmail);

        //add new payment
        PaymentDAO paymentDAO = new PaymentDAO();
        if (!paymentDAO.addNewPayment(new PaymentDTO(registerID, description, "paid", "paypal", currentDate, amount))) {
            //delete registration
            return false;
        }
        //send Email

        //set payment information
        request.setAttribute("payer", payerInfo);
        request.setAttribute("transaction", transaction);
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
        HttpSession session = request.getSession();
        try {
            if (processRequest(request, response)) {
                request.getRequestDispatcher(Routers.VIEW_PAYMENT_RECEIPT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException | PayPalRESTException ex) {
            //Get the email and eventID for remove registration 
            //when exception happen on excecuting payment
            String email = (String) session.getAttribute("email");
            int eventID = (int) session.getAttribute("eventID");
            //initialize resource
            EventRegisterDAO registerDAO = new EventRegisterDAO();
            //remove fail registration
            try {
                if (registerDAO.getRegisterID(eventID, email) > 0) {
                    //remove registration
                }
            } catch (SQLException | NamingException ex1) {
                log(ex1.getMessage());
                request.setAttribute("errorMessage", ex1.getMessage());
            }
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        } finally {
            //remove eventID out of the session
            session.removeAttribute("eventID");
        }
    }
}
