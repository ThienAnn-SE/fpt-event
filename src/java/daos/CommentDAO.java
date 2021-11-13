/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CommentDTO;
import dtos.EventDTO;
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
public class CommentDAO {

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

    public boolean insertNewComment(CommentDTO comment) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblComments(eventID, userEmail, avatar, comment, postDate, visible)"
                        + " VALUES (?,?,?,?,?,?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, comment.getEventID());
                preStm.setString(2, comment.getEmail());
                preStm.setString(3, comment.getAvatar());
                preStm.setNString(4, comment.getComment());
                preStm.setTimestamp(5, java.sql.Timestamp.valueOf(comment.getPostDate()));
                preStm.setBoolean(6, true);

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public CommentDTO getCommentByID(int commentID) throws NamingException, SQLException {
        CommentDTO dto = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblComments"
                    + " WHERE commentID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, commentID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int eventID = rs.getInt("eventID");
                String email = rs.getString("userEmail");
                String avatar = rs.getString("avatar");
                String comment = rs.getNString("comment");
                String postDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getDate("postDate"));
                dto = new CommentDTO(commentID, eventID, email, avatar, comment, postDate);
            }
        } finally {
            this.closeConnection();
        }
        return dto;
    }

    public ArrayList<CommentDTO> getCommentListByEventID(int eventID) throws SQLException, NamingException {
        ArrayList<CommentDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblComments"
                    + " WHERE eventID = ? AND visible = 1"
                    + " ORDER BY postDate DESC";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int commentID = rs.getInt("commentID");
                String email = rs.getString("userEmail");
                String avatar = rs.getString("avatar");
                String comment = rs.getNString("comment");
                String postDate = new SimpleDateFormat("dd MMM yyyy").format(rs.getDate("postDate"));
                list.add(new CommentDTO(commentID, eventID, email, avatar, comment, postDate));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public int getCommentNumByEventID(int eventID)
            throws NamingException, SQLException {
        int num = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(userEmail) as num"
                        + " FROM tblComments"
                        + " WHERE eventID = ? AND visible = 1";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, eventID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("num");
                }
            }
        } finally {

        }
        return num;
    }

    public ArrayList<CommentDTO> getCommentNumList(ArrayList<EventDTO> eventList) throws NamingException, SQLException {
        ArrayList<CommentDTO> numList = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT eventID, COUNT(userEmail) as num"
                        + " FROM tblComments"
                        + " WHERE eventID = ? AND visible = 1"
                        + " GROUP BY eventID";
                preStm = conn.prepareStatement(sql);
                if (!eventList.isEmpty()) {
                    for (int i = 0; i < eventList.size(); i++) {
                        preStm.setInt(1, eventList.get(i).getEventID());
                        rs = preStm.executeQuery();
                        if (rs.next()) {
                            int eventID = rs.getInt("eventID");
                            int commentNum = rs.getInt("num");
                            numList.add(new CommentDTO(eventID, commentNum));
                        }
                    }
                }
            }
        } finally {
            this.closeConnection();
        }
        return numList;
    }

    public boolean changeCommentVisible(int commentID, boolean visible)
            throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblComments SET visible = ?"
                    + " WHERE commentID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setBoolean(1, visible);
            preStm.setInt(1, commentID);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }
}
