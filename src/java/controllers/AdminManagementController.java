/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CategoryDAO;
import daos.LocationDAO;
import dtos.CategoryDTO;
import dtos.LocationDTO;
import java.io.IOException;
import java.rmi.ServerException;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "AdminManagemntController", urlPatterns = {"/AdminManagemntController"})
public class AdminManagementController extends HttpServlet {

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
        CategoryDAO categoryDAO = new CategoryDAO();

        ArrayList<LocationDTO> locationList = locationDAO.getAllLocations();
        ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();

        if (categoryList.isEmpty() || locationList.isEmpty()) {
            throw new SQLException("Some error happen, the record from database is empty");
        }

        request.setAttribute("locationList", locationList);
        request.setAttribute("categoryList", categoryList);
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
        } catch (SQLException | NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMEssage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void addNewLocation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String locationName = GetParam.getStringParam(request, "locationName", "Location name", 0, 100, null);
        Integer locationCapacity = GetParam.getIntParams(request, "locationCapacity", "Location capacity", 0, Integer.MAX_VALUE, null);

        if (locationName == null || locationCapacity == null) {
            throw new ServletException("Can not find paramter");
        }

        LocationDAO locationDAO = new LocationDAO();
        if (!locationDAO.insertNewLocation(locationName, locationCapacity)) {
            throw new SQLException("Can not insert new record to database");
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void addNewCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String categoryName = GetParam.getStringParam(request, "categoryName", "Category name", 0, 100, null);

        if (categoryName == null) {
            throw new ServletException("Can not find parameter");
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        if (!categoryDAO.insertNewCategory(categoryName)) {
            throw new SQLException("Can not insert new record into database");
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
        String btAction = GetParam.getStringParam(request, "btAction", "Action", 0, 50, null);
        try {
            if (btAction != null) {
                if (btAction.equalsIgnoreCase("addCategory")) {
                    addNewCategory(request, response);
                }
                if (btAction.equalsIgnoreCase("addLocation")) {
                    addNewLocation(request, response);
                }
                /*
                
                */
                //on success
                response.sendRedirect("");
            } else {
                throw new ServerException("Can not find parameter");
            }
        } catch (NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }

    }

}
