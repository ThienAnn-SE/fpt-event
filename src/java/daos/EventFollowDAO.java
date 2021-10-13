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

    public boolean addNewFollow(EventFollowDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblFollowed(eventID, userEmail)"
                        + " VALUES (?,?)";
                preStm = conn.prepareStatement(sql);

                preStm.setInt(1, dto.getEventID());
                preStm.setString(2, dto.getUserEmail());

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
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
