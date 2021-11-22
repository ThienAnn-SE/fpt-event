/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.ClubDAO;
import daos.UserDAO;
import dtos.ClubDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet(name = "AdminClubManagementController", urlPatterns = {"/admin-club"})
public class AdminClubManagementController extends HttpServlet {

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

        ClubDAO clubDAO = new ClubDAO();

        ArrayList<ClubDTO> clubList = clubDAO.getAllClubs();

        if (clubList.isEmpty()) {
            throw new SQLException("Some error happen, the record from database is empty");
        }

        request.setAttribute("clubList", clubList);
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
            request.getRequestDispatcher(Routers.ADMIN_CLUB_MANAGEMENT_PAGE).forward(request, response);
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
        String action = GetParam.getStringParam(request, "action", "Action", 0, 10, null);

        try {
            if (action != null) {
                if (action.equalsIgnoreCase("add")) {
                    addNewClub(request, response);
                    response.sendRedirect(Routers.ADMIN_CLUB_CONTROLLER + "?add=success");
                }
                if (action.equalsIgnoreCase("change")) {
                    changeLeaderEmmail(request, response);
                    response.sendRedirect(Routers.ADMIN_CLUB_CONTROLLER + "?change=success");
                }
            } else {
                throw new IllegalArgumentException("Parameter does not exist!");
            }
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher(Routers.ADMIN_CLUB_MANAGEMENT_PAGE).forward(request, response);
        } catch (IOException | ServletException | NamingException | SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex);
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

    /**
     * Processes requests for <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void addNewClub(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        ClubDAO clubDAO = new ClubDAO();

        String clubName = GetParam.getStringParam(request, "clubName", "clubName", 0, 100, null);
        String clubDescription = GetParam.getStringParam(request, "clubDescription", "Club description", 0, 200, null);
        Date createDate = GetParam.getDateParams(request, "createDate", "Create date", null);
        String clubEmail = GetParam.getEmailParams(request, "clubEmail", "Club email");
        String clubPhoneNumber = GetParam.getPhoneParams(request, "clubPhoneNumber", "Club phone number");
        String userEmail = GetParam.getEmailParams(request, "userEmail", "Leader email");

        if (clubName == null || clubDescription == null || createDate == null
                || clubEmail == null || clubPhoneNumber == null || userEmail == null) {
            throw new IllegalArgumentException();
        }
        //check the name is available
        if (clubDAO.getClubByName(clubName) != null) {
            throw new IllegalArgumentException("This club name is already taken!");
        }
        //validate club create date
        if (createDate.after(new Date(System.currentTimeMillis()))) {
            throw new IllegalArgumentException("Club create time can not be in the future!");
        }
        //check the email is available
        if (clubDAO.getClubByEmail(clubEmail) != null) {
            throw new IllegalArgumentException("This club email is already taken!");
        }
        //check the phonenumber is used or not
        if (clubDAO.getClubByPhoneNumber(clubPhoneNumber) != null) {
            throw new IllegalArgumentException("This phone number is already existed!");
        }
        //validate user email
        validateUserEmail(userEmail);
        //add new club
        if (!clubDAO.addNewClub(new ClubDTO(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail))) {
            throw new SQLException("Internale error");
        }
    }

    /**
     * Processes requests for <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void changeLeaderEmmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        //initialize resource
        UserDAO userDAO = new UserDAO();
        ClubDAO clubDAO = new ClubDAO();
        //get param
        Integer clubID = GetParam.getIntParams(request, "clubID", "Club ID", 0, Integer.MAX_VALUE, null);
        String newEmail = GetParam.getEmailParams(request, "userEmail", "User email");
        //validate param
        if (clubID == null || newEmail == null) {
            throw new ServletException("Parameter does not exist!");
        }
        //validate user email
        validateUserEmail(newEmail);
        //get current club admin email
        String currentLeaderEmail = clubDAO.getClubLeaderEmail(clubID);

        if (clubDAO.updateClubLeaderEmail(clubID, newEmail)) {
            userDAO.changeUserRole(newEmail, 5);
            userDAO.changeUserRole(currentLeaderEmail, 1);
        } else {
            throw new SQLException("Internal error");
        }

    }

    private void validateUserEmail(String email) throws SQLException, NamingException {
        UserDAO userDAO = new UserDAO();
        //validate email
        if (!email.contains("@fpt.edu.vn")) {
            throw new IllegalArgumentException("Please choose the user with FPT email!");
        }
        //checking user is exist
        UserDTO user = userDAO.getUserByEmail(email);
        if (user == null) {
            throw new IllegalArgumentException("User with this email does not exist!");
        }
        //checking user status
        if (user.getStatus() == 400 || user.getStatus() == 450) {
            throw new IllegalArgumentException("This user is not available to be changed at the momment!");
        }
        //checking user is another club admin
        if (user.getRole() == 4 || user.getRole() == 5) {
            throw new IllegalArgumentException("This user is another club admin at the momment!");
        }
    }
}
