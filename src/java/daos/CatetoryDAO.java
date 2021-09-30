/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CatetoryDTO;
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
public class CatetoryDAO {

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
    
    public CatetoryDTO getCatetoryByID(int id) throws SQLException, NamingException{
        CatetoryDTO category = null;
        try {
            conn = DBHelpers.makeConnection();
            if(conn != null){
                String sql = "SELECT * "
                        + " FROM tblCategories "
                        + " WHERE categoryID = ? ";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if(rs.next()){
                    category = new CatetoryDTO(rs.getInt("categoryID"), rs.getString("categoryName"));
                }
            }
        } finally {
            this.closeConnection();
        }
        return category;
    }
    
    public ArrayList<CatetoryDTO> getAllCatetories() throws SQLException, NamingException{
        ArrayList<CatetoryDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if(conn != null){
                String sql = "SELECT * "
                        + " FROM tblCategories ";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while(rs.next()){
                   CatetoryDTO category = new CatetoryDTO(rs.getInt("categoryID"), rs.getString("categoryName"));
                   list.add(category);
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
