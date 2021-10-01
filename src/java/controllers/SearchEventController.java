/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CatetoryDAO;
import daos.EventDAO;
import dtos.CatetoryDTO;
import dtos.EventDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author thien
 */
@WebServlet(name = "SearchEventController", urlPatterns = {"/SearchEventController"})
public class SearchEventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        //initialized resource
        CatetoryDAO catetoryDAO = new CatetoryDAO();
        EventDAO eventDAO = new EventDAO();

        //get catetory
        ArrayList<CatetoryDTO> catetoryList = catetoryDAO.getAllCatetories();
        if (catetoryList == null) {
            request.setAttribute("errorMessage", "Catetory is empty");
            return false;
        }

        //get top 9 avaiable event
        ArrayList<EventDTO> eventList = eventDAO.getAllEvents();
        if (eventList == null) {
            request.setAttribute("eventListError", "There is no event avaiable at the moment");
        }

        //on success
        request.setAttribute("eventList", eventList);
        request.setAttribute("catetoryList", catetoryList);
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
                request.getRequestDispatcher(Routers.VIEW_EVENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
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
        processRequest(request, response);
    }
// </editor-fold>
}
