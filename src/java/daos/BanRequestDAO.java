/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.BanRequestDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import utils.DBHelpers;

/**
 *
 * @author thien
 */
public class BanRequestDAO {

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

    public boolean addNewRequest(int clubID, String userEmail, String sendDate) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblBanRequests(clubID, userEmail, sendDate, requestStatus)"
                    + " VALUES (?,?,?,?)";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, clubID);
            preStm.setString(2, userEmail);
            preStm.setTimestamp(3, java.sql.Timestamp.valueOf(sendDate));
            preStm.setBoolean(4, false);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean processBanRequest(String email, String date) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblBanRequests"
                        + " SET approvalDate = ?, requestStatus = 1"
                        + " WHERE userEmail = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setDate(1, java.sql.Date.valueOf(date));
                preStm.setString(2, email);

                isSuccess = preStm.executeUpdate()> 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean isReported(int clubID, String userEmail) throws NamingException, SQLException {
        boolean isReported = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT requestID "
                        + " FROM tblBanRequests"
                        + " WHERE clubID = ? AND userEmail = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, clubID);
                preStm.setString(2, userEmail);

                rs = preStm.executeQuery();
                if (rs.next()) {
                    isReported = true;
                }
            }
        } finally {
            this.closeConnection();
        }
        return isReported;
    }

    public int getNumOfUnreslovedRequest() throws NamingException, SQLException {
        int num = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(requestID) AS num"
                        + " FROM tblBanRequests"
                        + " WHERE requestStatus = 0";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();

                if (rs.next()) {
                    num = rs.getInt("num");
                }
            }
        } finally {
            this.closeConnection();
        }
        return num;
    }

    public ArrayList<BanRequestDTO> getBanRequestList() throws NamingException, SQLException {
        ArrayList<BanRequestDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblBanRequests"
                    + " WHERE requestStatus = 0";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                int clubID = rs.getInt("clubID");
                String userEmail = rs.getString("userEmail");
                String sendDate = rs.getString("sendDate");
                boolean requestStatus = rs.getBoolean("requestStatus");

                list.add(new BanRequestDTO(requestID, clubID, userEmail, sendDate, requestStatus));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
