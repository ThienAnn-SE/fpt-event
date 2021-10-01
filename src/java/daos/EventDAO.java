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
            Date createDate, Date startDate, Date endDate, String content, int fee) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID,"
                    + " createDate, startDate, endDate, avgVote, content, fee)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            preStm = conn.prepareStatement(sql);

            preStm.setNString(1, eventName);
            preStm.setInt(2, clubID);
            preStm.setInt(3, locationID);
            preStm.setInt(4, catetoryID);
            preStm.setInt(5, 300);
            preStm.setDate(6, java.sql.Date.valueOf(createDate.toString()));
            preStm.setDate(7, java.sql.Date.valueOf(startDate.toString()));
            preStm.setDate(8, java.sql.Date.valueOf(endDate.toString()));
            preStm.setDouble(9, 0);
            preStm.setNString(10, content);
            preStm.setBoolean(11, fee == 1);

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
            String sql = "UPDATE tblFUEvents set eventStatus = ? WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);

            preStm.setInt(1, eventID);
            preStm.setInt(2, eventStatus);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<EventDTO> getTop9Event(int count) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "select * \n"
                        + "from (select ROW_NUMBER() over (order by eventID asc) as rn, * from tblFUEvents) as b\n"
                        + "where rn >= (?*9-8) and rn <= (?*9)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, count);
                preStm.setInt(2, count);
                rs = preStm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    String eventID = rs.getString("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    Date createDate = rs.getDate("createDate");
                    Date startDate = rs.getDate("startDate");
                    Date endDate = rs.getDate("endDate");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    boolean fee = rs.getBoolean("fee");
                    
                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, createDate, startDate, endDate);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
                  return list;
    }
  
    public EventDTO getEventByID(int eventID) throws NamingException, SQLException {
        EventDTO event = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventName, clubID, locationID, statusID,"
                    + " createDate, startDate, endDate, avgVote, content, fee"
                    + " FROM tblFUEvents WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();

            if (rs.next()) {
                String eventName = rs.getNString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int statusID = rs.getInt("statusID");
                Date createDate = Helper.convertStringToDate(rs.getDate("createDate").toString());
                Date startDate = Helper.convertStringToDate(rs.getDate("startDate").toString());
                Date endDate = Helper.convertStringToDate(rs.getDate("endDate").toString());
                Double avgVote = rs.getDouble("avgVote");
                String contend = rs.getNString("content");
                boolean fee = rs.getBoolean("fee");

                event = new EventDTO(eventID, eventName, clubID, locationID, statusID, statusID, createDate, startDate, endDate, avgVote, contend, fee);
            }
        } finally {
            this.closeConnection();
        }
        return event;
    }

    public ArrayList<EventDTO> getAllEvents() throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT eventID, eventName, clubID, locationID, statusID,"
                    + " createDate, startDate, endDate, avgVote, content, fee"
                    + " FROM tblFUEvents";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int eventID = rs.getInt("eventID");
                String eventName = rs.getNString("eventName");
                int clubID = rs.getInt("clubID");
                int locationID = rs.getInt("locationID");
                int statusID = rs.getInt("statusID");
                Date createDate = Helper.convertStringToDate(rs.getDate("createDate").toString());
                Date startDate = Helper.convertStringToDate(rs.getDate("startDate").toString());
                Date endDate = Helper.convertStringToDate(rs.getDate("endDate").toString());
                Double avgVote = rs.getDouble("avgVote");
                String contend = rs.getNString("content");
                boolean fee = rs.getBoolean("fee");

                list.add(new EventDTO(eventID, eventName, clubID, locationID, statusID, statusID, createDate, startDate, endDate, avgVote, contend, fee));
            }
        } finally {
            this.closeConnection();
        }
      return list;
    }

}
