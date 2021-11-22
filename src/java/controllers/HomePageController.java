/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.CommentDAO;
import daos.EventDAO;
import daos.EventRegisterDAO;
import dtos.CategoryDTO;
import dtos.CommentDTO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "HomePageController", urlPatterns = {"/home"})
public class HomePageController extends HttpServlet {

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
            throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        CategoryDAO categoryDAO = new CategoryDAO();
        EventDAO eventDAO = new EventDAO();
        CommentDAO commentDAO = new CommentDAO();

        ArrayList<EventDTO> eventList = eventDAO.getEventForHomepage();
        ArrayList<CommentDTO> commentNum = commentDAO.getCommentNumList(eventList);
        ArrayList<EventRegisterDTO> registerNum = getGegisterNumList(eventList);
        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
        
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("registerNumList", registerNum);
        request.setAttribute("commentNum", commentNum);
        request.setAttribute("eventList", eventList);
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
            request.getRequestDispatcher(Routers.HOME_PAGE).forward(request, response);
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
