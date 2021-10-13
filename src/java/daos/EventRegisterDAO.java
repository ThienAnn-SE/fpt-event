/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventDTO;
import dtos.EventRegisterDTO;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
                String sql = "INSERT INTO tblEventRegister(eventID, userEmail, registerDate) VALUES (?,?,?)";
                preStm = conn.prepareStatement(sql);

                preStm.setInt(1, dto.getEventID());
                preStm.setString(2, dto.getEmail());
                preStm.setDate(3, java.sql.Date.valueOf(dto.getRegisterDate().toString()));

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
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
                if (rs.next()) {
                    String userEmail = rs.getString("email");
                    Date registerDate = rs.getDate("createDate");
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
                if (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getNString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("startDate"));
                    String endDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getDate("endDate"));
                    int slot = rs.getInt("slot");
                    Double avgVote = rs.getDouble("avgVote");
                    String contend = rs.getNString("content");
                    int ticketFee = rs.getInt("ticketFee");
                    eventRegisterList.add(new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, contend, ticketFee));
                }
            }
        } finally {
            this.closeConnection();
        }
        return eventRegisterList;
    }
}
