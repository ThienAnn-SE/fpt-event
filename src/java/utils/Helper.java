package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

public class Helper {

    /**
     * Ensure that access only from authorized users
     *
     * @param request servlet request
     * @param response servlet response
     * @param minRole minimum user's role to be passed
     * @param maxRole maximum user's role to be passed
     * @param page move to this page if user can not be passed
     * @return false if the access is illegal
     * @throws java.lang.Exception
     */
    public static boolean protectedRouter(HttpServletRequest request, HttpServletResponse response, int minRole,
            int maxRole, String page) throws Exception {

        if (!correctRole(request, minRole, maxRole)) {
            //the access is illegal
            request.setAttribute("errorMessage", "Action is not allow because of your role");
            request.getRequestDispatcher(page).forward(request, response);
            return false;
        }
        return true;
    }

    /**
     * Reformat string that is too long
     *
     * @param str input string
     * @param maxLength
     * @return return string with first maxLength characters + "..." if the
     * string is too long or itself if not
     */
    public static String truncateContent(String str, int maxLength) {
        if (str.length() > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }

    /**
     * Check that user is login or not
     *
     * @param request servlet request
     * @return true if use is login or false if not
     */
    public static boolean isLogin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false; //if the session is not exist
        }
        String email = (String) session.getAttribute("email");
        return email != null; //username exist in session or not
    }

    /**
     * Check that user's role is valid or invalid
     *
     * @param request servlet request
     * @param minRole minimum user's role to be passed
     * @param maxRole maximum user's role to be passed
     * @return true if user role between min and max role range
     */
    public static boolean correctRole(HttpServletRequest request, int minRole, int maxRole) {
        HttpSession session = request.getSession(false);
        Integer roleR = (Integer) session.getAttribute("role");
        return (roleR != null) && (roleR >= minRole) && (roleR <= maxRole);
    }

    /**
     * convert date in String type into Integer
     *
     * @param date
     * @return date in Integer or null if exception happen
     */
    public static Integer convertStringDateToInteger(String date) {
        try {
            SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
            Date dateTypeDate = formatter1.parse(date);
            SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMdd");
            return Integer.parseInt(formatter2.format(dateTypeDate));
        } catch (ParseException e) {
            return null;
        }
    }

    /**
     * Convert date in String type into date in Date type
     *
     * @param date
     * @return date in Date type
     */
    public static Date convertStringToDate(String date) {
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(date);
        } catch (ParseException e) {
            return null;
        }
    }

    /**
     * Convert date in String type into date in Date type
     *
     * @param date
     * @return date in Date type
     */
    public static Date convertStringToDateTime(String date) {
        try {
            return new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date);
        } catch (ParseException e) {
            return null;
        }
    }

    /**
     * get date in Date type and convert it into a date in String type to store
     * in SQL database
     *
     * @param date
     * @return converted date string
     */
    public static String convertDateTimeToSQLString(Date date) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }

    /**
     * get date in Date type and convert it into a date in String type to store
     * in SQL database
     *
     * @param date
     * @return converted date string
     */
    public static String convertDateToSQLString(Date date) {
        return new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    /**
     * get date in Date type and convert it into a date in String type
     *
     * @param date
     * @return converted date string
     */
    public static String convertDateToString(Date date) {
        return new SimpleDateFormat("dd-MM-yyyy").format(date);
    }

    /**
     * Get today date in Date type (yyyy-MM-dd)
     *
     * @return today date
     */
    public static Date getCurrentDate() {
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return convertStringToDate(formatter.format(new Date(System.currentTimeMillis())));
    }

    /**
     * Get current date time
     *
     * @return current date time
     */
    public static Date getTodayTime() {
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return convertStringToDateTime(formatter.format(new Date(System.currentTimeMillis())));
    }

    public static boolean is3DayAfterNow(Date startDate) {
        LocalDate now = LocalDate.parse(convertDateToSQLString(new Date(System.currentTimeMillis())));
        LocalDate future = LocalDate.parse(convertDateToSQLString(startDate));
        return ChronoUnit.DAYS.between(now, future) == 3;
    }

    /* public static Integer generateOrderId() throws Exception {
        OrderDAO orderDAO = new OrderDAO();

        ArrayList<Order> list = orderDAO.getAllOrders();

        return (list.size() + 1);
    }
     */
}
