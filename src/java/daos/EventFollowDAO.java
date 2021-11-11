/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventDTO;
import dtos.EventFollowDTO;
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
public class EventFollowDAO {

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

    public boolean isFollowedByUser(int eventID, String userEmail) throws NamingException, SQLException {
        boolean isFollowed = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT followID "
                        + " FROM tblFollowed"
                        + " WHERE eventID = ? AND userEmail = ?";
                preStm = conn.prepareStatement(sql);

                preStm.setInt(1, eventID);
                preStm.setString(2, userEmail);
                rs = preStm.executeQuery();

                isFollowed = rs.next();
            }
        } finally {
            this.closeConnection();
        }
        return isFollowed;
    }

    public boolean addNewFollow(EventFollowDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblFollowed(eventID, userEmail, followDate)"
                        + " VALUES (?,?,?)";
                preStm = conn.prepareStatement(sql);

                preStm.setInt(1, dto.getEventID());
                preStm.setString(2, dto.getUserEmail());
                preStm.setDate(3, java.sql.Date.valueOf(new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()))));

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean removeExistFollow(EventFollowDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "DELETE FROM tblFollowed"
                    + " WHERE eventID = ? AND userEmail = ?";
            preStm = conn.prepareStatement(sql);

            preStm.setInt(1, dto.getEventID());
            preStm.setString(2, dto.getUserEmail());

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<EventDTO> getFollowEventListForUserPage(String userEmail) throws NamingException, SQLException {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblFUEvents"
                        + " WHERE eventID IN (SELECT eventID"
                        + " FROM tblFollowed"
                        + " WHERE userEmail = ?)";
                preStm = conn.prepareStatement(sql);

                preStm.setString(1, userEmail);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int eventID = rs.getInt("eventID");
                    String eventName = rs.getNString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("categoryID");
                    int statusID = rs.getInt("statusID");
                    String createDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String registerEndDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("createDate"));
                    String startDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getTimestamp("startDate"));
                    String endDate = new SimpleDateFormat("MMM dd yyyy").format(rs.getTimestamp("endDate"));
                    int slot = rs.getInt("slot");
                    String content = rs.getNString("content");
                    int ticketFee = rs.getInt("ticketFee");
                    list.add(new EventDTO(eventID, eventName, clubID, locationID, catetoryID, statusID, createDate, registerEndDate, startDate, endDate, slot, content, ticketFee));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<Integer> getFollowData(int clubID) throws NamingException, SQLException {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "DECLARE @date date = GETDATE() - ?"
                        + " SELECT COUNT(userEmail) AS number "
                        + " FROM tblFollowed "
                        + " WHERE followDate = @date"
                        + " AND eventID IN ( SELECT eventID"
                        + " FROM tblFUEvents"
                        + " WHERE clubID = ? )"
                        + " GROUP BY followDate";
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
