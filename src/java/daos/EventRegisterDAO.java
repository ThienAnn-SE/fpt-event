/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.EventRegisterDTO;
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
public class EventRegisterDAO {

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

    public boolean addNewEventRegistration(EventRegisterDTO dto)
            throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblEventRegister(eventID, userEmail, registerDate) VALUES (?,?,?)";
            preStm = conn.prepareStatement(sql);

            preStm.setInt(1, dto.getEventID());
            preStm.setString(2, dto.getEmail());
            preStm.setDate(3, java.sql.Date.valueOf(dto.getRegisterDate().toString()));

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<EventRegisterDTO> getRegisterList(int eventID)
            throws SQLException, NamingException {
        ArrayList<EventRegisterDTO> registerList = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * "
                    + "FROM tblEventRegisters "
                    + "WHERE eventID=?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, eventID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String userEmail = rs.getString("email");
                Date registerDate = rs.getDate("createDate");
                registerList.add(new EventRegisterDTO(eventID, userEmail, registerDate));
            }
        } finally {
            this.closeConnection();
        }

        return registerList;
    }
}
