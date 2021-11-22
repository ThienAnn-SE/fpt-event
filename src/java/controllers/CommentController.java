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
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "CommentController", urlPatterns = {"/comment"})
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //initialize resources
        EventDAO eventDAO = new EventDAO();
        CommentDAO commentDAO = new CommentDAO();
        HttpSession session = request.getSession();

        //get parameter
        String comment = GetParam.getStringParam(request, "comment", "Comment", 0, 5000, null);
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, null);

        //check parameter
        if (comment == null) {
            throw new IllegalArgumentException();
        }

        if (eventID == null) {
            throw new ServletException("Can not find the parameter");
        }

        //check event is exist
        if (eventDAO.getEventByID(eventID) == null) {
            throw new SQLException("The event doest not exist!!");
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
     * @throws ServletException
     * @throws IOException
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    public void getHandler(HttpServletRequest request, HttpServletResponse respone)
            throws ServletException, IOException, NamingException, SQLException {
        respone.setContentType("text/html;charset=UTF-8");
        Integer commentID = GetParam.getIntParams(request, "commentID", "Comment", 0, Integer.MAX_VALUE, null);
        if (commentID == null) {
            throw new ServletException("Parameter does not exist!!");
        }
        CommentDAO commentDAO = new CommentDAO();
        if (commentDAO.getCommentByID(commentID) == null) {
            request.setAttribute("errorMessage", "Comment does not exist!!");
            throw new SQLException("Comment does not exist!");
        }
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));

        //generate report
        CommentReportDAO reportDAO = new CommentReportDAO();

        if (!reportDAO.isReported(commentID, email)) {
            if (!reportDAO.addNewReport(new CommentReportDTO(commentID, email, now))) {
                throw new SQLException("Internal error!");
            }
        } else {
            throw new IllegalArgumentException("You report this comment already!");
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
                int eventID = (int) request.getAttribute("eventID");
                response.sendRedirect(Routers.VIEW_EVENT_CONTROLLER + "?cmt=success&eventID=" + eventID);
            } else {
                request.setAttribute("errorMessage", "Some error happened, please reload the page!!");
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        } catch (IllegalArgumentException ex) {
            int eventID = (int) request.getAttribute("eventID");
            response.sendRedirect(Routers.VIEW_EVENT_CONTROLLER + "?cmt=error&eventID=" + eventID);
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
        int eventID = GetParam.getIntParams(request, "eventID", "Event ID", 0, Integer.MAX_VALUE, 0);

        try {
            getHandler(request, response);
            if (eventID > 0) {
                response.sendRedirect(Routers.VIEW_EVENT_CONTROLLER + "?report=success&eventID=" + eventID);
            } else {
                request.setAttribute("errorMessage", "Internal error");
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage()); 
            request.getRequestDispatcher(Routers.VIEW_EVENT_CONTROLLER + "?eventID=" + eventID).forward(request, response);
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
