/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CommentDAO;
import daos.CommentReportDAO;
import daos.EventDAO;
import dtos.CommentDTO;
import dtos.CommentReportDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;
import utils.GetParam;
import utils.Helper;

/**
 *
 * @author thien
 */
@WebServlet(name = "CommentController", urlPatterns = {"/CommentController"})
public class CommentController extends HttpServlet {

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
        //initialize resources
        EventDAO eventDAO = new EventDAO();
        CommentDAO commentDAO = new CommentDAO();
        HttpSession session = request.getSession();

        //get parameter
        String comment = GetParam.getStringParam(request, "comment", "Comment", 0, 100, null);
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, 5000, null);

        //check parameter
        if (comment == null || eventID == null) {
            return false;
        }

        //check event is exist
        if (eventDAO.getEventByID(eventID) == null) {
            request.setAttribute("errorMessage", "No event found!!");
            return false;
        }

        //get user email and avatar
        String email = (String) session.getAttribute("email");
        String avatar = (String) session.getAttribute("avatar");

        //get current time date
        String postDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis());

        //set eventID paramter to forward
        request.setAttribute("eventID", eventID);

        //return result
        return commentDAO.insertNewComment(new CommentDTO(eventID, email, avatar, comment, postDate));
    }

    /**
     * Processes requests for HTTP <code>POST</code> methods.
     *
     * @param request servlet request
     * @param respone servlet response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    public boolean getHandler(HttpServletRequest request, HttpServletResponse respone)
            throws ServletException, IOException, NamingException, SQLException {
        respone.setContentType("text/html;charset=UTF-8");
        Integer commentID = GetParam.getIntParams(request, "commentID", "Comment", 0, Integer.MAX_VALUE, null);
        if (commentID == null) {
            return false;
        }
        CommentDAO commentDAO = new CommentDAO();
        if (commentDAO.getCommentByID(commentID) == null) {
            request.setAttribute("errorMessage", "Comment does not exist!!");
            return false;
        }
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));

        //generate report
        CommentReportDAO reportDAO = new CommentReportDAO();
        return reportDAO.addNewReport(new CommentReportDTO(commentID, email, now));
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
            if (!postHandler(request, response)) {
                request.setAttribute("errorMessage", "Some error happened, please try again!!");
            }
            request.getRequestDispatcher(Routers.VIEW_EVENT_CONTROLLER).forward(request, response);
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
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
            if (getHandler(request, response)) {
                request.getRequestDispatcher(Routers.ADMIN_REQUEST_PAGE).forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Internal error");
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
