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
@WebServlet(name = "ViewEventController", urlPatterns = {"/ViewEventController"})
public class ViewEventController extends HttpServlet {

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
        try {
            //check event exist
            //get event
            //check event is followed
            //check event is registered        
            int i = 1;
            if (request.getParameter("i") != null) {
                i = Integer.parseInt(request.getParameter("i"));
            }
            EventDAO dao = new EventDAO();
            ArrayList<EventDTO> list = dao.getTop9Event(i);
            int count = dao.getAllEvents().size();
            int endPage = count/9;
            if(count % 3 != 0){
                endPage++;
            }
            
            if (list.isEmpty()) {
                request.setAttribute("notify", "Some events will coming up soon.");
            }
            
            request.setAttribute("listEvent", list);
            request.setAttribute("index", i);
            request.setAttribute("endPage", endPage);
        } catch (Exception e) {
            log(e.getMessage());
        } finally {
            request.getRequestDispatcher("pagination.jsp").forward(request, response);
        }

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
        processRequest(request, response);

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
