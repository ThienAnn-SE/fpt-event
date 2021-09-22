/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import javax.naming.NamingException;
import utils.DBHelpers;
import utils.Helper;

/**
 *
 * @author thien
 */
public class UserDAO {

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

    public boolean addUser(User user) throws SQLException, NamingException {
        boolean isSuccess;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblUsers(userEmail, userName, dateOfBirth, gender, phoneNumber, roleID, statusID)"
                    + "VALUES (?,?,?,?,?,?,?)";

            preStm = conn.prepareStatement(sql);
            preStm.setString(1, user.getEmail());
            preStm.setString(2, user.getName());
            preStm.setDate(3, java.sql.Date.valueOf(Helper.convertDateToString(user.getDayOfBirth())));
            preStm.setBoolean(0, user.isGender());
            preStm.setString(5, user.getPhoneNumber());
            preStm.setInt(6, user.getRole());
            preStm.setInt(7, user.getStatus());

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean isExisted(String email) throws SQLException, NamingException {
        boolean existed = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT userEmail FROM tblUsers WHERE userEmail=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                existed = true;
            }
        } finally {
            this.closeConnection();
        }
        return existed;
    }

    public boolean updateUser(String email, String name, Date dateOfBirth, int gender, String phoneNumber) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblUsers SET userName=?, dateOfBirth=?, gender=?, phoneNumber=? WHERE userEmail=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, name);
            preStm.setDate(2, java.sql.Date.valueOf(Helper.convertDateToString(dateOfBirth)));
            preStm.setInt(3, gender);
            preStm.setString(4, phoneNumber);
            preStm.setString(5, email);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<User> getAllUsers() throws SQLException, NamingException {
        ArrayList<User> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * FROM tblUsers";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String email = rs.getString("userEmail");
                String name = rs.getString("userName");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                boolean gender = rs.getBoolean("gender");
                String phoneNumber = rs.getString("phoneNumber");
                int role = rs.getInt("roleID");
                int status = rs.getInt("statusID");
                Date formatDate = Helper.convertStringToDate(dateOfBirth.toString());
                User user = new User(email, name, formatDate, gender, phoneNumber, role, status);
                list.add(user);
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public User getUserByName(String name) throws SQLException, NamingException {
        User user = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * FROM tblUsers WHERE userName=?";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String email = rs.getString("userEmail");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                boolean gender = rs.getBoolean("gender");
                String phoneNumber = rs.getString("phoneNumber");
                int role = rs.getInt("roleID");
                int status = rs.getInt("statusID");
                Date formatDate = Helper.convertStringToDate(dateOfBirth.toString());
                user = new User(email, name, formatDate, gender, phoneNumber, role, status);
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }
}
