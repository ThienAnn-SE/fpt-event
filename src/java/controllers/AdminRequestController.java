/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CommentDAO;
import daos.CommentReportDAO;
import daos.UserDAO;
import dtos.CommentReportDTO;
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
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "AdminRequestController", urlPatterns = {"/AdminRequestController"})
public class AdminRequestController extends HttpServlet {

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
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        //get request list
        CommentReportDAO reportDAO = new CommentReportDAO();
        
        ArrayList<CommentReportDTO> reportList = reportDAO.getReportList();
        
        ArrayList<CommentReportDTO> violatedUserList = reportDAO.getViolatedUserList();

        request.setAttribute("reportList", reportList);
        request.setAttribute("violatedUserList", violatedUserList);
        return true;
    }

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

        Integer reportID = GetParam.getIntParams(request, "reportID", "Report ID", 0, Integer.MAX_VALUE, null);
        String userEmail = GetParam.getStringParam(request, "userEmail", "User Email", 0, 50, null);
        String btAction = GetParam.getStringParam(request, "btAction", "Action", 0, 20, null);
        if (reportID == null || btAction == null || userEmail == null) {
            return false;
        }

        //change report status
        CommentReportDAO reportDAO = new CommentReportDAO();
        if (btAction.equalsIgnoreCase("cancel")) {
            return reportDAO.changeReportStatus(reportID, 400);
        } else if (!reportDAO.changeReportStatus(reportID, 500)) {
            request.setAttribute("errorMessage", "Internal error");
            return false;
        }

        //change comment visible
        CommentDAO commentDAO = new CommentDAO();
        if (!commentDAO.changeCommentVisible(0, false)) {
            request.setAttribute("errorMessage", "internal error");
            return false;
        }

        //check user violation times and ban
        int violationTimes = reportDAO.getUserViolationTimes(userEmail);
        if (violationTimes > 0 && violationTimes % 2 == 0) {
            //banning user
            UserDAO userDAO = new UserDAO();
            if (!userDAO.changeUserStatus(userEmail, 450)) {
                request.setAttribute("errorMessage", "Can not ban user, some error happen when banning!!");
                return false;
            }
            //send notification
        }
        //send warning

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
                request.getRequestDispatcher(Routers.ADMIN_REQUEST_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
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
            if (postHandler(request, response)) {

            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
            Logger.getLogger(AdminRequestController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
