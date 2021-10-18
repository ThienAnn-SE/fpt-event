/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CatetoryDAO;
import daos.ClubDAO;
import daos.CommentDAO;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.EventStatusDAO;
import daos.LocationDAO;
import dtos.CatetoryDTO;
import dtos.ClubDTO;
import dtos.CommentDTO;
import dtos.EventDTO;
import dtos.EventStatusDTO;
import dtos.LocationDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
@WebServlet(name = "ViewEventController", urlPatterns = {"/ViewEventController"})
public class ViewEventController extends HttpServlet {

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
    protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");

        //initialize resources
        EventDAO eventDAO = new EventDAO();
        EventStatusDAO statusDAO = new EventStatusDAO();
        CatetoryDAO catetoryDAO = new CatetoryDAO();
        LocationDAO locationDAO = new LocationDAO();
        ClubDAO clubDAO = new ClubDAO();
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        CommentDAO commentDAO = new CommentDAO();
        
        //get parameter
        Integer eventID = GetParam.getIntParams(request, "eventID", "Event ID", 10, 5000, null);

        //check paramter
        if (eventID == null) {
            return false;
        }

        //get event
        EventDTO event = eventDAO.getEventByID(eventID);

        //check event is exist
        if (event == null) {
            request.setAttribute("errorMessage", "Event does not exist");
            return false;
        }

        //get status 
        EventStatusDTO status = statusDAO.getStatusByID(event.getStatusID());
        //get catetory
        CatetoryDTO catetory = catetoryDAO.getCatetoryByID(event.getCatetoryID());
        //get location
        LocationDTO location = locationDAO.getLocationByID(event.getLocationID());
        //get club
        ClubDTO club = clubDAO.getClubByID(event.getClubID());
        //get register num of event
        int registerNum = registerDAO.getRegisterNumByEventID(eventID);
        //get comment list
        ArrayList<CommentDTO> commentList = commentDAO.getCommentListByEventID(eventID);

        //set data
        request.setAttribute("commentList", commentList);
        request.setAttribute("registerNum", registerNum);
        request.setAttribute("event", event);
        request.setAttribute("catetoryName", catetory.getCatetoryName());
        request.setAttribute("locationName", location.getLocationName());
        request.setAttribute("statusDescription", status.getStatusDescription());
        request.setAttribute("clubName", club.getClubName());
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
            if (processRequest(request, response)) {
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
}
