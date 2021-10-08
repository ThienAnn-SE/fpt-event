/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import constant.Routers;
import daos.CatetoryDAO;
import daos.EventDAO;
import daos.UserDAO;
import dtos.CatetoryDTO;
import dtos.EventDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "SearchEventController", urlPatterns = {"/SearchEventController"})
public class SearchEventController extends HttpServlet {

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

            String btAtion = GetParam.getStringParam(request, "btAction", "Action", 1, 50, null);
            Integer page = GetParam.getIntParams(request, "page", "Page", 1, 50, 1);

            boolean result = true;
            if (btAtion != null) {
                if (btAtion.equalsIgnoreCase("price")) {
                    result = getEventListByPrice(request, page);
                }
                if (btAtion.equalsIgnoreCase("name")) {
                    result = getEventListByName(request, page);
                }
                if (btAtion.equalsIgnoreCase("catetory")) {
                    result = getEventListByCatetory(request, page);
                }
            } else {
                result = getAllEventList(request, page);
            }
            //on success
            if (result) {
                request.getRequestDispatcher(Routers.SEARCH_EVENT_PAGE).forward(request, response);
            } else {
                request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
            }
            //on fail

        } catch (Exception ex) {
            log(ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher(Routers.ERROR_PAGE).forward(request, response);
        }
    }

    private boolean getAllEventList(HttpServletRequest request, int page)
            throws Exception {
        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        eventList = eventDAO.getTop9Event(page);
        if (eventList == null) {
            request.setAttribute("error", "There is no event take places now");
        } else {
            int endPage = eventList.size() / 9;
            if (eventList.size() % 3 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
        }

        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventListByPrice(HttpServletRequest request, int page)
            throws Exception {

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        Integer minPrice = GetParam.getIntParams(request, "minPrice", "Min price", 0, 1000000, null);
        Integer maxPrice = GetParam.getIntParams(request, "maxPrice", "Max price", 0, 1000000, null);

        if (minPrice == null || maxPrice == null) {
            return false;
        }

        if (maxPrice < minPrice) {
            request.setAttribute("errorMessage", "Min price can not be greater than max price");
            return false;
        }

        eventList = eventDAO.getEventByPrice(page, maxPrice, minPrice);

        if (eventList == null) {
            request.setAttribute("error", "There is no event take places now");
        } else {
            int endPage = eventList.size() / 9;
            if (eventList.size() % 3 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
        }

        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventListByName(HttpServletRequest request, int page)
            throws Exception {

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        String eventName = GetParam.getStringParam(request, "eventName", "Event name", 0, 50, null);

        if (eventName == null) {
            eventList = eventDAO.getTop9Event(1);
        } else {
            eventList = eventDAO.getEventByName(page, eventName);
        }

        if (eventList == null) {
            request.setAttribute("errorMessage", "There is no event take places now");
        } else {
            int endPage = eventList.size() / 9;
            if (eventList.size() % 3 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
        }
        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventListByCatetory(HttpServletRequest request, int page)
            throws Exception {

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        Integer catetoryID = GetParam.getIntParams(request, "catetoryID", "Catetory", 10, 500, null);

        if (catetoryID == null) {
            return false;
        }

        eventList = eventDAO.getEventByCatetory(page, catetoryID);

        if (eventList == null) {
            request.setAttribute("error", "There is no event take places now");
        } else {
            int endPage = eventList.size() / 9;
            if (eventList.size() % 3 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
        }
        request.setAttribute("eventList", eventList);
        return true;
    }
}
