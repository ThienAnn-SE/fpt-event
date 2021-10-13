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

    public boolean checkExistedEventByEventName(String eventName) throws SQLException, NamingException {
        boolean isExist = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventID FROM tblFUEvents WHERE eventName = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, eventName);
            rs = preStm.executeQuery();
            if (rs.next()) {
                isExist = true;
            }
        } finally {
            this.closeConnection();
        }
        return isExist;
    }

    public boolean addEvent(String eventName, int clubID, int locationID, int catetoryID,
            Date createDate, Date startDate, Date endDate, String content, int ticketFee) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID,"
                    + " createDate, startDate, endDate, slot, avgVote, content, ticketFee)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            preStm = conn.prepareStatement(sql);

            preStm.setNString(1, eventName);
            preStm.setInt(2, clubID);
            preStm.setInt(3, locationID);
            preStm.setInt(4, catetoryID);
            preStm.setInt(5, 300);
            preStm.setDate(6, java.sql.Date.valueOf(Helper.convertDateToSQLString(createDate)));
            preStm.setTimestamp(7, java.sql.Timestamp.valueOf(Helper.convertDateTimeToSQLString(startDate)));
            preStm.setTimestamp(8, java.sql.Timestamp.valueOf(Helper.convertDateTimeToSQLString(startDate)));
            preStm.setInt(9, 0);
            preStm.setDouble(10, 0);
            preStm.setNString(11, content);
            preStm.setInt(12, ticketFee);

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
                    + " WHERE statusID IN (300, 450, 500)"
                    + " ORDER BY startDate ASC";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int catetoryID = rs.getInt("catetoryID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss MM-dd-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss MM-dd-yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                double avgVote = rs.getDouble("avgVote");
                String content = rs.getString("content");
                int ticketFee = rs.getInt("ticketFee");

                EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee);
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
                        + " WHERE statusID NOT IN (400, 570)"
                        + " ORDER BY startDate"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, count);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    int ticketFee = rs.getInt("ticketFee");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee);
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
                        + " WHERE statusID NOT IN (400,570)";
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

    public ArrayList<EventDTO> getEventByCatetory(int count, int catetoryID) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE catetoryID = ? AND statusID NOT IN (400, 570)"
                        + " ORDER BY startDate"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, catetoryID);
                preStm.setInt(2, count);
                rs = preStm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    int ticketFee = rs.getInt("ticketFee");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getRecordNumForCatetorySearch(int catetoryID) throws SQLException, NamingException {
        int pageNum = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(eventID) as number"
                        + " FROM tblFUEvents"
                        + " WHERE catetoryID = ? AND statusID NOT IN (400,570)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, catetoryID);
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
                        + " WHERE (ticketFee >= ? AND ticketFee <= ?) AND statusID NOT IN (400, 570)"
                        + " ORDER BY startDate"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, minPrice);
                preStm.setInt(2, maxPrice);
                preStm.setInt(3, count);
                rs = preStm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    int ticketFee = rs.getInt("ticketFee");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee);
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
                        + " WHERE (ticketFee >= ? AND ticketFee <= ?) AND statusID NOT IN (400,570)";
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
                        + " WHERE (eventName LIKE %?%) AND statusID NOT IN (400,570)"
                        + " ORDER BY startDate"
                        + " OFFSET (?-1)*9 ROWS FETCH NEXT 9 ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, searchName);
                preStm.setInt(2, count);
                preStm.setInt(3, count);
                rs = preStm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    int ticketFee = rs.getInt("ticketFee");

                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee);
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
                        + " WHERE eventName like %?% AND statusID NOT IN (400,570)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, searchName);
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
            String sql = "SELECT eventName, clubID, locationID, catetoryID, statusID,"
                    + " createDate, startDate, endDate, slot, avgVote, content, ticketFee"
                    + " FROM tblFUEvents WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();

            if (rs.next()) {
                String eventName = rs.getNString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int catetoryID = rs.getInt("catetoryID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                Double avgVote = rs.getDouble("avgVote");
                String contend = rs.getNString("content");
                int ticketFee = rs.getInt("ticketFee");

                event = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, contend, ticketFee);
            }
        } finally {
            this.closeConnection();
        }
        return event;
    }

    public ArrayList<EventDTO> getEventByClub(int page, int clubID) throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM (SELECT ROW_NUMBER() OVER (ORDER BY eventID ASC) AS rn, * FROM tblFUEvents) AS b"
                    + " WHERE (clubID = ?) AND (rn >= (?*9-8) AND rn <= (?*9))";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, clubID);
            preStm.setInt(2, page);
            preStm.setInt(3, page);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getNString("eventName");
                int locationID = rs.getInt("locationID");
                int catetoryID = rs.getInt("catetoryID");
                int statusID = rs.getInt("statusID");
                String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                Double avgVote = rs.getDouble("avgVote");
                String contend = rs.getNString("content");
                int ticketFee = rs.getInt("ticketFee");
                list.add(new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, contend, ticketFee));
            }
        } finally {
            this.closeConnection();
        }
        return list;
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
                String startDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("startDate"));
                String endDate = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(rs.getTimestamp("endDate"));
                int slot = rs.getInt("slot");
                Double avgVote = rs.getDouble("avgVote");
                String contend = rs.getNString("content");
                int ticketFee = rs.getInt("ticketFee");

                list.add(new EventDTO(eventID, eventName, clubID, locationID, statusID, statusID, createDate, startDate, endDate, slot, avgVote, contend, ticketFee));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

}
