/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CommentReportDTO;
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
public class CommentReportDAO {

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

    public boolean addNewReport(CommentReportDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblCommentReports(commentID, userEmail, sendDate, reportStatus)"
                    + " VALUES(?,?,?,?)";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getCommentID());
            preStm.setString(2, dto.getUserEmail());
            preStm.setTimestamp(3, java.sql.Timestamp.valueOf(dto.getSendDate()));
            preStm.setInt(4, 300);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public CommentReportDTO getReportByID(int reportID) throws NamingException, SQLException {
        CommentReportDTO report = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT commentID, userEmail, sendDate"
                        + " FROM tblCommentReports"
                        + " WHERE reportID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, reportID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int commentID = rs.getInt("commentID");
                    String userEmail = rs.getString("userEmail");
                    String sendDate = rs.getString("sendDate");
                    report = new CommentReportDTO(commentID, userEmail, sendDate);
                }
            }
        } finally {
            this.closeConnection();
        }
        return report;
    }

    public boolean isReported(int commentID, String userEmail) throws NamingException, SQLException {
        boolean result = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT reportID"
                        + " FROM tblCommentReports"
                        + " WHERE commentID = ? AND userEmail = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, commentID);
                preStm.setString(2, userEmail);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = true;
                }
            }
        } finally {
            this.closeConnection();
        }
        return result;
    }

    public int getNumOfUnprocessedReport() throws NamingException, SQLException {
        int num = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(reportID) AS num"
                        + " FROM tblCommentReports"
                        + " WHERE reportStatus = 300";
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

    public boolean changeReportStatus(int commentID, int reportStatus) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblCommentReports SET reportStatus = ?"
                    + " WHERE commentID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, reportStatus);
            preStm.setInt(2, commentID);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<CommentReportDTO> getReportList() throws NamingException, SQLException {
        ArrayList<CommentReportDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT rp.reportID, rp.commentID, rp.userEmail, rp.sendDate, rp.reportStatus, c.comment"
                        + " FROM tblCommentReports AS rp"
                        + " LEFT JOIN tblComments AS c ON rp.commentID = c.commentID"
                        + " ORDER BY reportStatus";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int reportID = rs.getInt("reportID");
                    int commentID = rs.getInt("commentID");
                    String comment = rs.getNString("comment");
                    String userEmail = rs.getString("userEmail");
                    String sendDate = new SimpleDateFormat("MMM dd, yyyy").format(rs.getDate("sendDate"));
                    int reportStatus = rs.getInt("reportStatus");
                    list.add(new CommentReportDTO(reportID, commentID, userEmail, comment, sendDate, reportStatus));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<CommentReportDTO> getViolatedUserList() throws NamingException, SQLException {
        ArrayList<CommentReportDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT c.userEmail as userEmail, count(rp.reportID) as number"
                        + " FROM tblCommentReports AS rp"
                        + " LEFT JOIN tblComments AS c ON rp.commentID = c.commentID"
                        + " WHERE reportStatus = 500"
                        + " GROUP BY c.userEmail";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    String userEmail = rs.getString("userEmail");
                    int number = rs.getInt("number");
                    list.add(new CommentReportDTO(userEmail, number));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public int getUserViolationTimes(String userEmail) throws SQLException, NamingException {
        int num = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT count(rp.reportID) as number"
                        + " FROM tblCommentReports AS rp"
                        + " LEFT JOIN tblComments AS c ON rp.commentID = c.commentID"
                        + " WHERE rp.reportStatus = 500 AND c.userEmail = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, userEmail);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return num;
    }
}
