/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.LocationDAO;
import dtos.LocationDTO;
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
@WebServlet(name = "AdminLocationController", urlPatterns = {"/AdminLocationController"})
public class AdminLocationController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected void getHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");

        LocationDAO locationDAO = new LocationDAO();

        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();
        if (locationList.isEmpty()) {
            throw new SQLException("Some error happen, the record from database is empty");
        }

        request.setAttribute("locationList", locationList);
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    protected boolean postHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");

        boolean isSuccess = false;

        String locationName = GetParam.getStringParam(request, "locationName", "LocationName", 0, 30, null);
        Integer locationCapacity = GetParam.getIntParams(request, "locationCapacity", "Location capacity", 10, 1000, null);

        if (locationName == null || locationCapacity == null) {
            return false;
        }
        LocationDAO locationDAO = new LocationDAO();

        if (locationDAO.getLocationByName(locationName) != null) {
            request.setAttribute("errorMessage", "This location is already exist");
        } else {
            isSuccess = locationDAO.insertNewLocation(locationName, locationCapacity);
        }

        return isSuccess;
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
            getHandler(request, response);
            request.getRequestDispatcher(Routers.ADMIN_LOCATION_PAGE).forward(request, response);
        } catch (SQLException | NamingException ex) {
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
                response.sendRedirect(Routers.ADMIN_LOCATION_PAGE + "?rs=success");
            } else {
                doGet(request, response);
            }
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }
}
