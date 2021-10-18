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
            String sql = "INSERT INTO tblCommentReports(commentID, userEmail, sendDate, reprotStatus)"
                    + " VALUES(?,?,?,?)";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getCommentID());
            preStm.setString(2, dto.getUserEmail());
            preStm.setDate(3, java.sql.Date.valueOf(dto.getSendDate()));
            preStm.setBoolean(4, false);

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
            String sql = "SELECT rp.reportID, rp.commentID, c.comment, rp.userEmail, rp.sendDate, rp.reportStatus"
                    + " FROM tblCommentReports AS rp, tblComments AS c"
                    + " WHERE rp.commentID = c.commentID AND rp.reportStatus = 0"
                    + " ORDER BY rp.sendDate";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int reportID = rs.getInt("reportID");
                int commentID = rs.getInt("commentID");
                String comment = rs.getNString("comment");
                String userEmail = rs.getString("userEmail");
                String sendDate = new SimpleDateFormat("MMM dd, yyyy").format(rs.getDate("sendDate"));
                boolean reportStatus = rs.getBoolean("reportStatus");
                list.add(new CommentReportDTO(reportID, commentID, userEmail, comment, sendDate, reportStatus));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
