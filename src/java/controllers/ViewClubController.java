/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.ClubDAO;
import dtos.ClubDTO;
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
@WebServlet(name = "ViewClubDetailController", urlPatterns = {"/ViewClubDetailController"})
public class ViewClubController extends HttpServlet {

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected boolean getAllClubList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        ClubDAO clubDAO = new ClubDAO();
        ArrayList<ClubDTO> clubList = clubDAO.getAllClubs();
        if (clubList == null) {
            request.setAttribute("errorMesssage", "There is an error happen, no club found");
            return false;
        }
        request.setAttribute("clubList", clubList);
        return true;
    }

    /**
     * Processes requests for HTTP <code>GET</code> methods.
     *
     * @param clubID
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected boolean getClubByID(int clubID, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        ClubDAO clubDAO = new ClubDAO();
        ClubDTO club = clubDAO.getClubByID(clubID);
        if (club == null) {
            request.setAttribute("errorMesssage", "Club does not exist");
            return false;
        }
        request.setAttribute("club", club);
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
            Integer clubID = GetParam.getIntParams(request, "clubID", "Club ID", 10, 500, null);
            if (clubID == null) {
                if (getAllClubList(request, response)) {
                    request.getRequestDispatcher(Routers.VIEW_CLUB_PAGE).forward(request, response);
                } else {
                    request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                }
            } else {
                if (getClubByID(clubID, request, response)) {
                    request.getRequestDispatcher(Routers.VIEW_CLUB_DETAIL_PAGE).forward(request, response);
                } else {
                    request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
                }
            }

        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

}
