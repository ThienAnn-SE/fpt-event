/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CategoryDTO;
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
public class CategoryDAO {

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

    public boolean insertNewCategory(String categoryName) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblCategories(categoryName) VALUES ?";
                preStm = conn.prepareStatement(sql);
                preStm.setNString(1, categoryName);

                isSuccess = preStm.executeLargeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public String getCategoryByName(String categoryName) throws NamingException, SQLException {
        String name = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT categoryName"
                        + " FROM tblCategories"
                        + " WHERE categoryName = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setNString(1, categoryName);
                rs = preStm.executeQuery();
                
                if(rs.next()){
                    name = rs.getNString("categoryName");
                }
            }
        } finally {
            this.closeConnection();
        }
        return name;
    }

    public CategoryDTO getCategoryByID(int id) throws SQLException, NamingException {
        CategoryDTO category = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT * "
                        + " FROM tblCategories "
                        + " WHERE categoryID = ? ";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    category = new CategoryDTO(rs.getInt("categoryID"), rs.getNString("categoryName"));
                }
            }
        } finally {
            this.closeConnection();
        }
        return category;
    }

    public ArrayList<CategoryDTO> getAllCategories() throws SQLException, NamingException {
        ArrayList<CategoryDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT * "
                        + " FROM tblCategories ";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    CategoryDTO category = new CategoryDTO(rs.getInt("categoryID"), rs.getNString("categoryName"));
                    list.add(category);
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }
}
