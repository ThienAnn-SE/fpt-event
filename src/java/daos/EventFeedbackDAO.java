/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventFeedbackDTO;
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
public class EventFeedbackDAO {

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

    public boolean addNewFeedback(EventFeedbackDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblFeedbacks(registerID, feedback, vote)"
                        + " VALUES (?,?,?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getRegisterID());
                preStm.setString(2, dto.getFeedback());
                preStm.setInt(3, dto.getVote());
                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean isFeedbacked(int registerID) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT * FROM tblFeedbacks"
                        + " WHERE registerID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, registerID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    isSuccess = true;
                }
            }
        } finally {

        }
        return isSuccess;
    }

    public ArrayList<EventFeedbackDTO> getEventFeedbackList(int eventID) throws NamingException, SQLException {
        ArrayList<EventFeedbackDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT er.userEmail , fb.feedback, fb.vote"
                        + " FROM tblFeedbacks AS fb"
                        + " LEFT JOIN tblEventRegisters AS er ON er.registerID = fb.registerID"
                        + " WHERE fb.registerID IN (SELECT registerID"
                        + " FROM tblEventRegisters"
                        + " WHERE eventID = ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, eventID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    String email = rs.getString("userEmail");
                    String feedback = rs.getNString("feedback");
                    int vote = rs.getInt("vote");
                    list.add(new EventFeedbackDTO(vote, feedback, email));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public double getEventAvgVote(int eventID) throws NamingException, SQLException {
        double ans = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT avg(fb.vote) as avgVote"
                        + " FROM tblFeedbacks AS fb"
                        + " LEFT JOIN tblEventRegisters AS er ON er.registerID = fb.registerID"
                        + " WHERE fb.registerID IN (SELECT registerID"
                        + " FROM tblEventRegisters"
                        + " WHERE eventID = ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, eventID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    ans = rs.getDouble("avgVote");
                }
            }
        } finally {
            this.closeConnection();
        }
        return ans;
    }
    
        public int getEventNumOfVote(int eventID) throws NamingException, SQLException {
        int ans = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT count(fb.feedbackID) as num"
                        + " FROM tblFeedbacks AS fb"
                        + " LEFT JOIN tblEventRegisters AS er ON er.registerID = fb.registerID"
                        + " WHERE fb.registerID IN (SELECT registerID"
                        + " FROM tblEventRegisters"
                        + " WHERE eventID = ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, eventID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    ans = rs.getInt("num");
                }
            }
        } finally {
            this.closeConnection();
        }
        return ans;
    }
}
