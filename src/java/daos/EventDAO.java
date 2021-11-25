/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.naming.NamingException;
import utils.DBHelpers;
import utils.Helper;

/**
 *
 * @author thien
 */
public class EventDAO {

    private Connection conn;

    private PreparedStatement preStm;

    private ResultSet rs;

    // This function handle to close connection of database
    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }

        if (preStm != null) {
            preStm.close();
        }

        if (conn != null) {

            conn.close();
        }
    }

    public EventDTO checkExistedEventByEventName(String eventName) throws SQLException, NamingException {
        EventDTO event = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventID, createDate, startDate, endDate"
                    + " FROM tblFUEvents WHERE eventName = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, eventName);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int eventID = rs.getInt("eventID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                event = new EventDTO(eventID, createDate, startDate, endDate);
            }
        } finally {
            this.closeConnection();
        }
        return event;
    }

    public boolean addEvent(String eventName, int clubID, int locationID, int categoryID,
            Date createDate, Date startDate, Date endDate, Date registerEndDate, int slot, String imageURL, String content, int ticketFee) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblFUEvents (eventName, clubID, locationID, categoryID, statusID,"
                    + " createDate, startDate, endDate, registerEndDate, slot, imageURL, content, ticketFee)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            preStm = conn.prepareStatement(sql);

            preStm.setNString(1, eventName);
            preStm.setInt(2, clubID);
            preStm.setInt(3, locationID);
            preStm.setInt(4, categoryID);
            preStm.setInt(5, 300);
            preStm.setDate(6, java.sql.Date.valueOf(Helper.convertDateToSQLString(createDate)));
            preStm.setTimestamp(7, java.sql.Timestamp.valueOf(Helper.convertDateTimeToSQLString(startDate)));
            preStm.setTimestamp(8, java.sql.Timestamp.valueOf(Helper.convertDateTimeToSQLString(endDate)));
            preStm.setTimestamp(9, java.sql.Timestamp.valueOf(Helper.convertDateTimeToSQLString(registerEndDate)));
            preStm.setInt(10, slot);
            preStm.setString(11, imageURL);
            preStm.setNString(12, content);
            preStm.setInt(13, ticketFee);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean changeEventStatus(int eventID, int eventStatus) throws SQLException, NamingException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblFUEvents set statusID = ? WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);

            preStm.setInt(1, eventStatus);
            preStm.setInt(2, eventID);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<EventDTO> getEventForUpdateStatus() throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventID, createDate, startDate, endDate"
                    + " FROM tblFUEvents"
                    + " WHERE statusID != 400"
                    + " ORDER BY startDate ASC";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                list.add(new EventDTO(eventID, createDate, startDate, endDate));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<EventDTO> getEventForHomepage() throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT TOP 4 *"
                    + " FROM tblFUEvents"
                    + " WHERE statusID NOT IN (400, 570) AND startDate >= GETDATE()"
                    + " ORDER BY startDate ASC";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getString("eventName");
                int clubID = rs.getInt("clubID");
                int categoryID = rs.getInt("categoryID");
                int statusID = rs.getInt("statusID");
                String startDate = new SimpleDateFormat("HH:mm:ss MM-dd-yyyy").format(rs.getTimestamp("startDate"));
                String content = rs.getNString("content");
                String imageURL = rs.getString("imageURL");
                int ticketFee = rs.getInt("ticketFee");
                int slot = rs.getInt("slot");

                EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, content, imageURL, ticketFee, slot);
                list.add(dto);
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<EventDTO> getEventForSearchPage(int count) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE statusID NOT IN (400)"
                        + " ORDER BY statusID"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, count);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String content = rs.getNString("content");
                    String imageURL = rs.getString("imageURL");
                    int ticketFee = rs.getInt("ticketFee");
                    int slot = rs.getInt("slot");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, content, imageURL, ticketFee, slot);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getRecordNumForSearchPage() throws SQLException, NamingException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE statusID NOT IN (400)";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    pageNum = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return pageNum;
    }

    public ArrayList<EventDTO> getEventByCategory(int count, int categoryID) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE categoryID = ? AND statusID NOT IN (400)"
                        + " ORDER BY statusID"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, categoryID);
                preStm.setInt(2, count);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int statusID = rs.getInt("statusID");
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String content = rs.getNString("content");
                    String imageURL = rs.getString("imageURL");
                    int ticketFee = rs.getInt("ticketFee");
                    int slot = rs.getInt("slot");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, content, imageURL, ticketFee, slot);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getRecordNumForCategorySearch(int categoryID) throws SQLException, NamingException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE categoryID = ? AND statusID NOT IN (400)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, categoryID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    pageNum = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return pageNum;
    }

    public ArrayList<EventDTO> getEventByPrice(int count, int maxPrice, int minPrice) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE (ticketFee >= ? AND ticketFee <= ?) AND statusID NOT IN (400)"
                        + " ORDER BY statusID"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, minPrice);
                preStm.setInt(2, maxPrice);
                preStm.setInt(3, count);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String content = rs.getNString("content");
                    String imageURL = rs.getString("imageURL");
                    int ticketFee = rs.getInt("ticketFee");
                    int slot = rs.getInt("slot");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, content, imageURL, ticketFee, slot);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getRecordNumForPriceSearch(int min, int max) throws SQLException, NamingException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE (ticketFee >= ? AND ticketFee <= ?) AND statusID NOT IN (400)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, min);
                preStm.setInt(2, max);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    pageNum = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return pageNum;
    }

    public ArrayList<EventDTO> getEventByName(int count, String searchName) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE (eventName LIKE ?) AND statusID NOT IN (400)"
                        + " ORDER BY statusID"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchName + "%");
                preStm.setInt(2, count);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String content = rs.getNString("content");
                    String imageURL = rs.getString("imageURL");
                    int ticketFee = rs.getInt("ticketFee");
                    int slot = rs.getInt("slot");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, content, imageURL, ticketFee, slot);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getRecordNumForEventNameSearch(String searchName) throws SQLException, NamingException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE eventName like ? AND statusID NOT IN (400)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + searchName + "%");
                rs = preStm.executeQuery();
                while (rs.next()) {
                    pageNum = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return pageNum;
    }

    public ArrayList<EventDTO> GetEventByDate(String startDate, String endDate, int page)
            throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE (startDate >= ? AND endDate <= ?)"
                        + " AND eventID NOT IN (400)"
                        + " ORDER BY statusID"
                        + " OFFSET(?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setDate(1, java.sql.Date.valueOf(startDate));
                preStm.setDate(2, java.sql.Date.valueOf(endDate));
                preStm.setInt(3, page);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String start = new SimpleDateFormat("MM-dd-yyyy").format(rs.getDate("startDate"));
                    String content = rs.getNString("content");
                    String imageURL = rs.getString("imageURL");
                    int ticketFee = rs.getInt("ticketFee");
                    int slot = rs.getInt("slot");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, categoryID, statusID, start, content, imageURL, ticketFee, slot);
                    list.add(dto);
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public int getRecordForEventDateSearch(String startDate, String endDate)
            throws NamingException, SQLException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE (startDate >= ? AND endDate <= ?)"
                        + " AND eventID NOT IN (400)";
                preStm = conn.prepareStatement(sql);
                preStm.setDate(1, java.sql.Date.valueOf(startDate));
                preStm.setDate(2, java.sql.Date.valueOf(endDate));
                rs = preStm.executeQuery();
                while (rs.next()) {
                    pageNum = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return pageNum;
    }

    public EventDTO getEventByID(int eventID) throws NamingException, SQLException {
        EventDTO event = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventName, clubID, locationID, categoryID, statusID,"
                    + " createDate, registerEndDate, startDate, endDate, slot, content,imageURL, ticketFee"
                    + " FROM tblFUEvents WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();

            if (rs.next()) {
                String eventName = rs.getNString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int categoryID = rs.getInt("categoryID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String registerEndDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("registerEndDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                String imageURL = rs.getString("imageURL");
                int slot = rs.getInt("slot");
                String content = rs.getNString("content");
                int ticketFee = rs.getInt("ticketFee");

                event = new EventDTO(eventID, eventName, clubID, locationID, categoryID, statusID, createDate, registerEndDate, startDate, endDate, slot, imageURL, content, ticketFee);
            }
        } finally {
            this.closeConnection();
        }
        return event;
    }

    public ArrayList<EventDTO> getEventByClub(int clubID) throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblFUEvents"
                    + " WHERE (clubID = ?)"
                    + " ORDER BY startDate";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, clubID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getNString("eventName");
                int locationID = rs.getInt("locationID");
                int categoryID = rs.getInt("categoryID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getDate("createDate"));
                String registerEndDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getTimestamp("registerEndDate"));
                String startDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                int ticketFee = rs.getInt("ticketFee");
                list.add(new EventDTO(eventID, eventName, locationID, categoryID, statusID, createDate, registerEndDate, startDate, endDate, slot, ticketFee));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public int getRecordNumForClub(int clubID) throws NamingException, SQLException {
        int num = 0;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT COUNT(eventID) as num"
                    + " FROM tblFUEvents"
                    + " WHERE clubID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, clubID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                num = rs.getInt("num");
            }
        } finally {

        }
        return num;
    }

    public ArrayList<EventDTO> getCLubClosedEvent(int clubID) throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblEvents"
                        + " WHERE (clubID = ? AND statusID = 570)"
                        + " ORDER BY endDate";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, clubID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getNString("eventName");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String startDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    list.add(new EventDTO(eventID, eventName, clubID, categoryID, statusID, startDate, endDate, null, 0, slot));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<EventDTO> getAllEvents() throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventID, eventName, clubID, locationID, statusID,"
                    + " createDate, startDate, endDate, slot, avgVote, content, fee"
                    + " FROM tblFUEvents";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getNString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String registerEndDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("registerEndDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                String content = rs.getNString("content");
                int ticketFee = rs.getInt("ticketFee");

                list.add(new EventDTO(eventID, eventName, clubID, locationID, statusID, statusID, createDate, registerEndDate, startDate, endDate, slot, content, ticketFee));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public boolean UpdateEvent(EventDTO event) throws SQLException, NamingException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblFUEvents SET eventName = ?, categoryID = ?, locationID = ?, registerEndDate = ?, startDate = ?, endDate = ?,"
                    + " imageURL = ?, content =?, ticketFee = ?, slot = ?"
                    + " WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setNString(1, event.getEventName());
            preStm.setInt(2, event.getCategoryID());
            preStm.setInt(3, event.getLocationID());
            preStm.setTimestamp(4, java.sql.Timestamp.valueOf(event.getRegisterEndDate()));
            preStm.setTimestamp(5, java.sql.Timestamp.valueOf(event.getStartDate()));
            preStm.setTimestamp(6, java.sql.Timestamp.valueOf(event.getEndDate()));
            preStm.setString(7, event.getImageURL());
            preStm.setNString(8, event.getContent());
            preStm.setInt(9, event.getTicketFee());
            preStm.setInt(10, event.getSlot());
            preStm.setInt(11, event.getEventID());

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean checkAvailabeTimeAndPlace(String startDate, String endDate, int locationID)
            throws NamingException, SQLException {
        boolean isExist = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT eventID FROM tblFUEvents"
                        + " WHERE statusID NOT IN (400, 570)"
                        + " AND locationID= ?"
                        + " AND (startDate BETWEEN ? AND ? OR endDate BETWEEN ? AND ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, locationID);
                preStm.setTimestamp(2, java.sql.Timestamp.valueOf(startDate));
                preStm.setTimestamp(3, java.sql.Timestamp.valueOf(endDate));
                preStm.setTimestamp(4, java.sql.Timestamp.valueOf(startDate));
                preStm.setTimestamp(5, java.sql.Timestamp.valueOf(endDate));
                rs = preStm.executeQuery();

                isExist = rs.next();
            }
        } finally {
            this.closeConnection();
        }
        return isExist;
    }
}
