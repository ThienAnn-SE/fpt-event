/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.ClubDAO;
import daos.EventFollowDAO;
import daos.EventRegisterDAO;
import daos.UserDAO;
import dtos.ClubDTO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
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
        UserDAO userDAO = new UserDAO();
        ClubDAO clubDAO = new ClubDAO();
        EventRegisterDAO registerDAO = new EventRegisterDAO();
        EventFollowDAO followDAO = new EventFollowDAO();

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
        ArrayList<EventDTO> eventFollowList = followDAO.getFollowEventListForUserPage(email);
        ArrayList<EventRegisterDTO> registerNumList_register = getGegisterNumList(eventRegisterList);
        ArrayList<EventRegisterDTO> registerNumList_follow = getGegisterNumList(eventFollowList);

        //get register list
        //get follow list
        request.setAttribute("user", user);
        request.setAttribute("club", club);
        request.setAttribute("registerNumList_register", registerNumList_register);
        request.setAttribute("registerNumList_follow", registerNumList_follow);
        request.setAttribute("eventRegisterList", eventRegisterList);
        request.setAttribute("eventFollowedList", eventFollowList);
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
