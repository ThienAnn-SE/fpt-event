/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import javax.naming.NamingException;
import utils.DBHelpers;

/**
 *
 * @author thien
 */
public class EventDAO {

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

    public boolean addEvent(EventDTO event) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, createDate, startDate, endDate, avgVote, content, fee) VALUES (?,?,?,?,?,?,?,?,?,?)";
            preStm = conn.prepareStatement(sql);
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<EventDTO> getTo9Event(int count) throws Exception {
        ArrayList<EventDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "select * \n"
                        + "from (select ROW_NUMBER() over (order by eventID asc) as rn, * from tblFUEvents) as b\n"
                        + "where rn >= (?*9-8) and rn <= (?*9)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, count);
                preStm.setInt(2, count);
                rs = preStm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    String eventID = rs.getString("eventID");
                    String eventName = rs.getString("eventName");
                    int clubID = rs.getInt("clubID");
                    int locationID = rs.getInt("locationID");
                    int catetoryID = rs.getInt("catetoryID");
                    Date createDate = rs.getDate("createDate");
                    Date startDate = rs.getDate("startDate");
                    Date endDate = rs.getDate("endDate");
                    double avgVote = rs.getDouble("avgVote");
                    String content = rs.getString("content");
                    boolean fee = rs.getBoolean("fee");
                    
                    EventDTO dto = new EventDTO(eventID, eventName, clubID, locationID, catetoryID, createDate, startDate, endDate);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
