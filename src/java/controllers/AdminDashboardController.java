/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.BanRequestDAO;
import daos.CommentReportDAO;
import daos.UserDAO;
import daos.VisitorCounterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author thien
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin-dashboard"})
public class AdminDashboardController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        UserDAO userDAO = new UserDAO();
        BanRequestDAO banDAO = new BanRequestDAO();
        CommentReportDAO reportDAO = new CommentReportDAO();
        VisitorCounterDAO counterDAO = new VisitorCounterDAO();

        ArrayList<Integer> userStatusRatioList = userDAO.getUserStatusRatioList();
        int numOfUnreslovedRequest = banDAO.getNumOfUnreslovedRequest();
        int numOfUnprocessedReport = reportDAO.getNumOfUnprocessedReport();
        long numOfTotalVisitors = counterDAO.getTotalVisitorNumber();
        int numOf30DayVisitors = counterDAO.get30DaysVisitorNumber();
        ArrayList<Integer> visitorList = counterDAO.getMonthlyVisitorOverview();

        if (userStatusRatioList.isEmpty()) {
            throw new SQLException("Some error happen, the record from database is empty");
        }

        request.setAttribute("userStatusRatioList", userStatusRatioList);
        request.setAttribute("numOfUnreslovedRequest", numOfUnreslovedRequest);
        request.setAttribute("numOfUnprocessedReport", numOfUnprocessedReport);
        request.setAttribute("numOfTotalVisitors", numOfTotalVisitors);
        request.setAttribute("numOf30DayVisitors", numOf30DayVisitors);
        request.setAttribute("visitorList", visitorList);
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
            processRequest(request, response);
            request.getRequestDispatcher(Routers.ADMIN_DASHBOARD_PAGE).forward(request, response);
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorName", ex.getMessage());
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
    }

}
