/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.ClubDAO;
import daos.EventFollowDAO;
import daos.EventRegisterDAO;
import daos.LocationDAO;
import daos.UserDAO;
import dtos.CategoryDTO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.LocationDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author thien
 */
@WebServlet(name = "ViewUserController", urlPatterns = {"/ViewUserController"})
public class ViewUserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws IOException if an error occurs
     */
    protected boolean getHanlder(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        UserDAO userDAO = new UserDAO();
        ClubDAO clubDAO = new ClubDAO();
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        EventFollowDAO followDAO = new EventFollowDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        LocationDAO locationDAO = new LocationDAO();

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        if (email == null) {
            return false;
        }

        UserDTO user = userDAO.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("errorMessage", "User with this given name was not found");
            return false;
        }

        ArrayList<ClubDTO> club = clubDAO.getAllClubsForUserPage();
        if (club == null) {
            request.setAttribute("errorMessage", "There is an error happen, no club found");
        }

        ArrayList<EventDTO> eventRegisterList = registerDAO.getEventRegisterListForUserPage(email);
        ArrayList<EventDTO> attendedEventList = registerDAO.getAttendedEventList(email);
        ArrayList<EventDTO> eventFollowedList = followDAO.getFollowEventListForUserPage(email);
        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();

        request.setAttribute("user", user);
        request.setAttribute("club", club);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("locationList", locationList);
        request.setAttribute("eventFollowedList", eventFollowedList);
        request.setAttribute("eventRegisterList", eventRegisterList);
        request.setAttribute("attendedEventList", attendedEventList);
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
            if (this.getHanlder(request, response)) {
                request.getRequestDispatcher(Routers.USER_INFO_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
