/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.ClubDAO;
import daos.EventDAO;
import daos.EventFollowDAO;
import daos.EventRegisterDAO;
import daos.LocationDAO;
import daos.PaymentDAO;
import dtos.CategoryDTO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.LocationDTO;
import dtos.PaymentDTO;
import java.io.IOException;
import java.sql.SQLException;
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
    protected boolean getHandler(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");

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

        CategoryDAO categoryDAO = new CategoryDAO();
        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
        if (categoryList == null) {
            request.setAttribute("errorMessage", "There is an error happen. No category found");
            return false;
        }

        LocationDAO locationDAO = new LocationDAO();
        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();
        if (locationList == null) {
            request.setAttribute("errorMessage", "There is an error happen. No location found");
        }

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList = eventDAO.getEventByClub(club.getClubID());

        EventRegisterDAO registerDAO = new EventRegisterDAO();
        ArrayList<Integer> dataRegisterList = registerDAO.getRegisterData(club.getClubID());

        EventFollowDAO followDAO = new EventFollowDAO();
        ArrayList<Integer> dataFollowList = followDAO.getFollowData(club.getClubID());

        PaymentDAO paymentDAO = new PaymentDAO();
        ArrayList<PaymentDTO> paymentList = paymentDAO.getClubEventPayment(club.getClubID());

        ArrayList<EventRegisterDTO> registerNumList = getRegisterNumList(eventList);

        request.setAttribute("registerNumList", registerNumList);
        request.setAttribute("paymentList", paymentList);
        request.setAttribute("locationList", locationList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("eventList", eventList);
        request.setAttribute("dataRegisterList", dataRegisterList);
        request.setAttribute("dataFollowList", dataFollowList);
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
                request.setAttribute("statisticsActive", true);
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

    private ArrayList<EventRegisterDTO> getRegisterNumList(ArrayList<EventDTO> dto) throws NamingException, SQLException {
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
