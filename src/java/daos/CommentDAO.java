/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CommentDTO;
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
            String sql = "INSERT INTO tblComments(eventID, userEmail, avatar, comment, postDate)"
                    + " VALUES (?,?,?,?,?)";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, comment.getEventID());
            preStm.setString(2, comment.getEmail());
            preStm.setString(3, comment.getAvatar());
            preStm.setNString(1, comment.getComment());
            preStm.setDate(5, java.sql.Date.valueOf(comment.getPostDate()));

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }
    
    public CommentDTO getCommentByID(int commentID) throws NamingException, SQLException{
        CommentDTO dto = null;
        try{
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblComments"
                    + " WHERE commentID = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, commentID);
            rs = preStm.executeQuery();
            if(rs.next()){
                int eventID = rs.getInt("eventID");
                String email = rs.getString("userEmail");
                String avatar = rs.getString("avatar");
                String comment = rs.getNString("comment");
                String postDate = new SimpleDateFormat("MMM dd,yyyy").format(rs.getDate("postDate"));
                dto = new CommentDTO(commentID, eventID, email, avatar, comment, postDate);
            }
        }finally{
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
                    + " WHERE eventID = ? AND visible = true"
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
            String sql = "SELECT COUNT(userEmail) as num"
                    + " FROM tblComments"
                    + " WHERE eventID = ?";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                num = rs.getInt("num");
            }
        } finally {

        }
        return num;
    }
}
