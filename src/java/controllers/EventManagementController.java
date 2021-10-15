/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CatetoryDAO;
import daos.ClubDAO;
import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.LocationDAO;
import daos.UserDAO;
import dtos.CatetoryDTO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.LocationDTO;
import dtos.UserDTO;
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
import javax.servlet.http.HttpSession;
import utils.GetParam;

/**
 *
 * @author thien
 */
@WebServlet(name = "EventManagementController", urlPatterns = {"/EventManagementController"})
public class EventManagementController extends HttpServlet {

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
        Integer page = GetParam.getIntParams(request, "page", "Page", 1, 50, 1);

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        if (email == null) {
            request.setAttribute("errorMessage", "There is an error happen. Please reload the website");
            return false;
        }

        ClubDAO clubDAO = new ClubDAO();
        ClubDTO club = clubDAO.getClubByEmail(email);
        if (club == null) {
            request.setAttribute("errorMessage", "This club does not exist or you do not have permission");
            return false;
        }

        CatetoryDAO catetoryDAO = new CatetoryDAO();
        ArrayList<CatetoryDTO> catetoryList = catetoryDAO.getAllCatetories();
        if (catetoryList == null) {
            request.setAttribute("errorMessage", "There is an error happen. No catetory found");
            return false;
        }

        LocationDAO locationDAO = new LocationDAO();
        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();
        if (locationList == null) {
            request.setAttribute("errorMessage", "There is an error happen. No location found");
        }

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList = eventDAO.getEventByClub(page, club.getClubID());

        ArrayList<EventRegisterDTO> registerNumList = getGegisterNumList(eventList);

        int endPage = eventDAO.getRecordNumForClub(club.getClubID());
        if (endPage % 5 != 0) {
            endPage++;
        }
        
        request.setAttribute("page", page);
        request.setAttribute("endPage", endPage);
        request.setAttribute("registerNumList", registerNumList);
        request.setAttribute("locationList", locationList);
        request.setAttribute("catetoryList", catetoryList);
        request.setAttribute("eventList", eventList);
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
                request.getRequestDispatcher(Routers.VIEW_MANAGEMENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

    private ArrayList<EventRegisterDTO> getGegisterNumList(ArrayList<EventDTO> dto) throws NamingException, SQLException {
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        ArrayList<EventRegisterDTO> registerNumList = new ArrayList<>();
        for (int i = 0; i < dto.size(); i++) {
            int eventID = dto.get(i).getEventID();
            int registerNum = registerDAO.getRegisterNumByEventID(eventID);
            registerNumList.add(new EventRegisterDTO(eventID, registerNum));
        }
        return registerNumList;
    }

}
