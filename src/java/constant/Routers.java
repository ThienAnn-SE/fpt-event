/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package constant;

/**
 *
 * @author thien
 */
public class Routers {

    //for google login
    public final static String GOOGLE_CLIENT_ID = "469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com";
    public final static String GOOGLE_CLIENT_SECRET = "_LV1zFjOUmN-L_vat6mRTMXM";
    public final static String GOOGLE_GET_USER_INFO_LINK = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public final static String GOOGLE_GET_TOKEN_LINK = "https://accounts.google.com/o/oauth2/token";
    public final static String GOOGLE_GRANT_TYPE = "authorization_code";
    public final static String GOOGLE_REDIRECT_URI = "http://localhost:8080/fpt-event/login";

    public final static String HOME_PAGE = "homePage.jsp";
    public final static String LOGIN_PAGE = "login.jsp";
    public final static String UPDATE_PAGE = "update.jsp";
    public final static String ERROR_PAGE = "error.jsp";
    public final static String REGISTER_PAGE = "register.jsp";
    public final static String USER_INFO_PAGE = "profile.jsp";
    public final static String ADD_EVENT_PAGE = "createEvent.jsp";
    public final static String UPDATE_EVENT_PAGE = "update.jsp";
    public final static String VIEW_EVENT_PAGE = "eventDetail.jsp";
    public final static String REVIEW_PAYMENT_PAGE = "review.jsp";
    public final static String VIEW_PAYMENT_RECEIPT_PAGE = "receipt.jsp";
    public final static String SEARCH_EVENT_PAGE = "search.jsp";
    public final static String VIEW_CLUB_PAGE = "club.jsp";
    public final static String USER_FEEDBACK_PAGE = "rating.jsp";
    public final static String VIEW_FEEDBACK_PAGE = "feedback.jsp";
    public final static String VIEW_MANAGEMENT_PAGE = "clubLeader.jsp";
    public final static String VIEW_CLUB_DETAIL_PAGE = "clubDetail.jsp";
    public final static String USER_MANAGEMENT_PAGE = "admin-table.jsp";
    public final static String ADMIN_FORM_PAGE = "admin-form.jsp";
    public final static String ADMIN_REQUEST_PAGE = "admin-request.jsp";
    public final static String VIEW_EVENT_REGISTRATION_PAGE = "registeredUser.jsp";
    public final static String CANCEL_EVENT_PAGE = "cancel.jsp";
    public final static String ADMIN_DASHBOARD_PAGE = "admin-dashboard.jsp";
    public final static String ADMIN_CATEGORY_PAGE = "admin-category.jsp";
    public final static String ADMIN_LOCATION_PAGE = "admin-location.jsp";
    public final static String ADMIN_CLUB_MANAGEMENT_PAGE = "admin-club.jsp";

    public final static String ADD_EVENT_CONTROLLER = "AddEventController";
    public final static String UPDATE_CONTROLLER = "UpdateController";
    public final static String REGISTER_CONTROLLER = "RegisterController";
    public final static String VIEW_USER_CONTROLLER = "profile";
    public final static String VIEW_EVENT_CONTROLLER = "ViewEventController";
    public final static String VIEW_CLUB_CONTROLLER = "ViewClubController";
    public final static String EXECUTE_PAYMENT_CONTROLLER = "ExecutePaymentController";
    public final static String REGISTER_EVENT_CONTROLLER = "RegisterEventController";
    public final static String FOLLOW_EVENT_CONTROLLER = "FollowEventController";
    public final static String SEARCH_EVENT_CONTROLLER = "SearchEventController";
    public final static String UPDATE_EVENT_CONTROLLER = "UpdateEventController";
    public final static String BAN_USER_CONTROLLER = "user-ban";
    public final static String FEEDBACK_CONTROLLER = "feedback";
    public final static String VIEW_REGISTERED_USER_CONTROLLER = "leader-registrationList";
    public final static String HOME_PAGE_CONTROLLER = "home";
    public final static String COMMENT_CONTROLLER = "comment";
    public final static String EVENT_MANAGEMENT_CONTROLLER = "EventManagementController";
    public final static String ADMIN_LOCATION_CONTROLLER = "admin-location";
    public final static String ADMIN_CATEGORY_CONTROLLER = "admin-category";
    public final static String ADMIN_CLUB_CONTROLLER = "admin-club";
    public final static String ADMIN_REQUEST_CONTROLLER = "admin-request";
    public final static String ADMIN_FORM_CONTROLLER = "admin-form";
    public final static String ADMIN_USER_CONTROLLER = "admin-user";
    public final static String ADMIN_DASHBOARD_CONTROLLER = "admin-dashboard";
}
