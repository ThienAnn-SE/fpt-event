/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.LocationDTO;
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
public class LocationDAO {

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

    public LocationDTO getLocationByID(int id) throws SQLException, NamingException {
        LocationDTO location = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " Select * "
                        + " From tblLocations "
                        + " Where locationID = ? ";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    location = new LocationDTO(rs.getInt("locationID"), rs.getString("locationName"),
                            rs.getInt("locationCapacity"));
                }
            }
        } finally {
            closeConnection();
        }
        return location;
    }

    public ArrayList<LocationDTO> getAllLocations() throws SQLException, NamingException {
        ArrayList<LocationDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " Select * "
                           + " From tblLocations ";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    LocationDTO location = new LocationDTO(rs.getInt("locationID"), rs.getString("locationName"),
                            rs.getInt("locationCapacity"));
                    list.add(location);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
