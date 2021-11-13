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
import java.text.SimpleDateFormat;
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
        response.setContentType("text/html;charset=UTF-8");
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
                if (btAtion.equalsIgnoreCase("category")) {
                    result = getEventListByCategory(request, page);
                }
                if (btAtion.equalsIgnoreCase("date")) {
                    result = getEventByDate(request, page);
                }
            } else {
                result = getAllEventList(request, page);
            }
            //on success
            if (result) {
                request.setAttribute("page", page);
                CategoryDAO categoryDAO = new CategoryDAO();
                ArrayList<CategoryDTO> categoryList = categoryDAO.getAllCategories();
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher(Routers.SEARCH_EVENT_PAGE).forward(request, response);
            } else {
                request.setAttribute("error", "There is no event for your result beacause some error happen");
                request.getRequestDispatcher(Routers.SEARCH_EVENT_PAGE).forward(request, response);
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
        CommentDAO commentDAO = new CommentDAO();
        ArrayList<EventDTO> eventList;
        ArrayList<CommentDTO> commentNum;
        ArrayList<EventRegisterDTO> registerNum;

        eventList = eventDAO.getEventForSearchPage(page);
        if (eventList.isEmpty()) {
            request.setAttribute("error", "There is no event take places now");
        } else {
            int endPage = eventDAO.getRecordNumForSearchPage() / 9;
            if (endPage != 9) {
                endPage++;
            }

            registerNum = getGegisterNumList(eventList);

            commentNum = commentDAO.getCommentNumList(eventList);

            request.setAttribute("commentNum", commentNum);
            request.setAttribute("registerNumList", registerNum);
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
            request.setAttribute("priceError", "Min price can not be greater than max price");
            return false;
        }

        eventList = eventDAO.getEventByPrice(page, maxPrice, minPrice);

        if (eventList.isEmpty()) {
            request.setAttribute("error", "There is no result for your searching");
        } else {
            int endPage = eventDAO.getRecordNumForPriceSearch(minPrice, maxPrice) / 9;
            if (endPage != 9) {
                endPage++;
            }

            ArrayList<EventRegisterDTO> registerNum = getGegisterNumList(eventList);
            request.setAttribute("registerNumList", registerNum);
            request.setAttribute("endPage", endPage);
        }
        request.setAttribute("lastSearch", "&minPirce=" + minPrice + "&maxPrice=" + maxPrice + "&btAction=price");
        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventByDate(HttpServletRequest request, int page) throws NamingException, SQLException {
        Date startDate = GetParam.getDateParams(request, "startDate", "StartDate", null);
        Date endDate = GetParam.getDateParams(request, "endDate", "End date", null);

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;
        if (startDate == null || endDate == null) {
            return false;
        }

        if (startDate.after(endDate)) {
            request.setAttribute("dateError", "Start date can not be after end date");
            return false;
        }
        SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd");
        eventList = eventDAO.GetEventByDate(frm.format(startDate), frm.format(endDate), page);
        if (eventList.isEmpty()) {
            request.setAttribute("error", "There is no result for your searching");
        } else {
            int endPage = eventDAO.getRecordForEventDateSearch(frm.format(startDate), frm.format(endDate)) / 9;
            if (endPage != 9) {
                endPage++;
            }
            ArrayList<EventRegisterDTO> registerNum = getGegisterNumList(eventList);
            request.setAttribute("registerNumList", registerNum);
            request.setAttribute("endPage", endPage);
        }

        request.setAttribute("lastSearch", "&startDate" + startDate + "&endDate" + endDate + "&btAction=date");
        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventListByName(HttpServletRequest request, int page)
            throws Exception {

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        String eventName = GetParam.getStringParam(request, "eventName", "Event name", 0, 50, null);

        if (eventName == null) {
            eventList = eventDAO.getEventForSearchPage(1);
        } else {
            eventList = eventDAO.getEventByName(page, eventName);
        }

        if (eventList.isEmpty()) {
            request.setAttribute("error", "There is no result for your searching");
        } else {
            int endPage = eventDAO.getRecordNumForEventNameSearch(eventName) / 9;
            if (endPage != 9) {
                endPage++;
            }

            ArrayList<EventRegisterDTO> registerNum = getGegisterNumList(eventList);
            request.setAttribute("registerNumList", registerNum);
            request.setAttribute("endPage", endPage);
        }
        request.setAttribute("lastSearch", "&eventName=" + eventName + "&btAction=name");
        request.setAttribute("eventList", eventList);
        return true;
    }

    private boolean getEventListByCategory(HttpServletRequest request, int page)
            throws Exception {

        EventDAO eventDAO = new EventDAO();
        ArrayList<EventDTO> eventList;

        Integer categoryID = GetParam.getIntParams(request, "categoryID", "Category", 10, 500, null);

        if (categoryID == null) {
            return false;
        }

        eventList = eventDAO.getEventByCategory(page, categoryID);

        if (eventList.isEmpty()) {
            request.setAttribute("error", "There is no event in this category");
        } else {
            int endPage = eventDAO.getRecordNumForCategorySearch(categoryID) / 9;
            if (endPage != 9) {
                endPage++;
            }

            ArrayList<EventRegisterDTO> registerNum = getGegisterNumList(eventList);
            request.setAttribute("registerNumList", registerNum);
            request.setAttribute("endPage", endPage);
        }
        request.setAttribute("lastSearch", "&categoryID=" + categoryID + "&btAction=category");
        request.setAttribute("eventList", eventList);
        return true;
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
