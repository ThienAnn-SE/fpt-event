/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventStatusDTO;
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
public class EventStatusDAO {

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

    public EventStatusDTO getStatusByID(int id) throws SQLException, NamingException {
        EventStatusDTO eventStatus = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " SELECT * "
                        + " FROM tblEventStatuses "
                        + " WHERE statusID = ? ";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    eventStatus = new EventStatusDTO(rs.getInt("statusID"), rs.getString("statusDescription"));
                }
            }
        } finally {
            this.closeConnection();
        }
        return eventStatus;
    }

    public ArrayList<EventStatusDTO> getAllStatuses() throws SQLException, NamingException {
        ArrayList<EventStatusDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " SELECT * "
                        + " FROM tblEventStatuses ";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    EventStatusDTO eventStatus = new EventStatusDTO(rs.getInt("statusID"), rs.getString("statusDescription"));
                    list.add(eventStatus);
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
