/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventDTO;
import dtos.EventRegisterDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.naming.NamingException;
import utils.DBHelpers;

/**
 *
 * @author thien
 */
public class EventRegisterDAO {

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

    public boolean addNewEventRegistration(EventRegisterDTO dto)
            throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblEventRegisters (eventID, userEmail, registerDate) VALUES (?,?,?)";
                preStm = conn.prepareStatement(sql);

                preStm.setInt(1, dto.getEventID());
                preStm.setString(2, dto.getEmail());
                preStm.setDate(3, java.sql.Date.valueOf(dto.getRegisterDate()));

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public EventRegisterDTO getRegistrationByID(int registerID) throws SQLException, NamingException {
        EventRegisterDTO registration = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblEventRegisters"
                        + " WHERE registerID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, registerID);
                rs = preStm.executeQuery();

                if (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String email = rs.getString("userEmail");
                    String registerDate = new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("registerDate"));
                    registration = new EventRegisterDTO(eventID, email, registerDate);
                }
            }
        } finally {
            this.closeConnection();
        }
        return registration;
    }

    public int getRegisterID(int eventID, String userEmail) throws SQLException, NamingException {
        int registerID = 0;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT registerID"
                    + " FROM tblEventRegisters"
                    + " WHERE eventID = ? AND userEmail = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            preStm.setString(2, userEmail);
            rs = preStm.executeQuery();
            if (rs.next()) {
                registerID = rs.getInt("registerID");
            }
        } finally {
            this.closeConnection();
        }
        return registerID;
    }

    public int getRegisterNumByEventID(int eventID) throws NamingException, SQLException {
        int registerNum = -1;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT COUNT(userEmail) as num"
                    + " FROM tblEventRegisters"
                    + " WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                registerNum = rs.getInt("num");
            }
        } finally {
            this.closeConnection();
        }
        return registerNum;
    }

    public ArrayList<EventRegisterDTO> getRegisterList(int eventID)
            throws SQLException, NamingException {
        ArrayList<EventRegisterDTO> registerList = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT * "
                        + "FROM tblEventRegisters "
                        + "WHERE eventID=?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, eventID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    String userEmail = rs.getString("email");
                    String registerDate = new SimpleDateFormat("dd/MM/yyyy").format(rs.getDate("createDate"));
                    registerList.add(new EventRegisterDTO(eventID, userEmail, registerDate));
                }
            }
        } finally {
            this.closeConnection();
        }

        return registerList;
    }

    public ArrayList<EventDTO> getEventRegisterListForUserPage(String userEmail)
            throws SQLException, NamingException {
        ArrayList<EventDTO> eventRegisterList = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE eventID IN (SELECT eventID"
                        + " FROM tblEventRegisters"
                        + " WHERE userEmail = ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, userEmail);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getNString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String registerEndDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("registerEndDate"));
                    String startDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("startDate"));
                    String endDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("endDate"));
                    int slot = rs.getInt("slot");
                    String content = rs.getNString("content");
                    int ticketFee = rs.getInt("ticketFee");
                    eventRegisterList.add(new EventDTO(eventID, eventName, clubID, locationID, categoryID, statusID, createDate, registerEndDate, startDate, endDate, slot, content, ticketFee));
                }
            }

        } finally {
            this.closeConnection();
        }
        return eventRegisterList;
    }

    public ArrayList<EventDTO> getAttendedEventList(String userEmail)
            throws SQLException, NamingException {
        ArrayList<EventDTO> eventRegisterList = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE eventID IN (SELECT eventID"
                        + " FROM tblEventRegisters"
                        + " WHERE userEmail = ? AND statusID = 570)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, userEmail);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getNString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int categoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String registerEndDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("registerEndDate"));
                    String startDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("startDate"));
                    String endDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("endDate"));
                    int slot = rs.getInt("slot");
                    String content = rs.getNString("content");
                    int ticketFee = rs.getInt("ticketFee");
                    eventRegisterList.add(new EventDTO(eventID, eventName, clubID, locationID, categoryID, statusID, createDate, registerEndDate, startDate, endDate, slot, content, ticketFee));
                }
            }

        } finally {
            this.closeConnection();
        }
        return eventRegisterList;
    }

    public ArrayList<Integer> getRegisterData(int clubID) throws SQLException, NamingException {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "DECLARE @date date = GETDATE() - ?"
                        + " SELECT COUNT(userEmail) AS number "
                        + " FROM tblEventRegisters "
                        + " WHERE registerDate = @date"
                        + " AND eventID IN ( SELECT eventID"
                        + " FROM tblFUEvents"
                        + " WHERE clubID = ? )"
                        + " GROUP BY registerDate";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(2, clubID);
                for (int i = 0; i < 30; i++) {
                    preStm.setInt(1, i);
                    rs = preStm.executeQuery();
                    if (rs.next()) {
                        list.add(rs.getInt("number"));
                    } else {
                        list.add(0);
                    }
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
