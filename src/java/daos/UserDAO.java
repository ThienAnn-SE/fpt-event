/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.UserDTO;
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

    public boolean addUser(UserDTO user) throws SQLException, NamingException {
        boolean isSuccess;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblUsers(userEmail, userName, dateOfBirth, gender, phoneNumber, roleID, statusID)"
                    + "VALUES (?,?,?,?,?,?,?)";

            preStm = conn.prepareStatement(sql);
            preStm.setString(1, user.getEmail());
            preStm.setString(2, null);
            preStm.setDate(3, null);
            preStm.setBoolean(4, true);
            preStm.setString(5, null);
            preStm.setInt(6, user.getRole());
            preStm.setInt(7, user.getStatus());

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean changeUserStatus(String email, int status) throws NamingException, SQLException {
        boolean isSuccess;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblUsers SET statusID = ? WHERE userEmail = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, status);
            preStm.setString(2, email);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean updateUser(String email, String name, String dateOfBirth, int gender, String phoneNumber) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "UPDATE tblUsers SET userName=?, dateOfBirth=?, gender=?, phoneNumber=? WHERE userEmail=?";
            preStm = conn.prepareStatement(sql);
            preStm.setNString(1, name);
            preStm.setDate(2, java.sql.Date.valueOf(dateOfBirth));
            preStm.setInt(3, gender);
            preStm.setString(4, phoneNumber);
            preStm.setString(5, email);

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<UserDTO> getUserBanList() throws NamingException, SQLException {
        ArrayList<UserDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblUsers"
                    + " WHERE statusID in (400, 450)"
                    + " ORDER by statusID DESC";
            preStm = conn.prepareStatement(sql);

            rs = preStm.executeQuery();
            while (rs.next()) {
                String email = rs.getString("userEmail");
                String name = rs.getString("userName");
                int statusID = rs.getInt("statusID");
                list.add(new UserDTO(email, name, statusID));
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public ArrayList<UserDTO> getAllUsers() throws SQLException, NamingException {
        ArrayList<UserDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * FROM tblUsers";
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String email = rs.getString("userEmail");
                String name = rs.getNString("userName");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                boolean gender = rs.getBoolean("gender");
                String phoneNumber = rs.getString("phoneNumber");
                int role = rs.getInt("roleID");
                int status = rs.getInt("statusID");
                String formatDateOfBirth = null;
                if (dateOfBirth != null) {
                    formatDateOfBirth = Helper.convertDateToString(dateOfBirth);
                }
                UserDTO user = new UserDTO(email, name, formatDateOfBirth, gender, phoneNumber, role, status);
                list.add(user);
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public UserDTO getUserByName(String name) throws SQLException, NamingException {
        UserDTO user = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * FROM tblUsers WHERE userName=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, name);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String email = rs.getString("userEmail");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                boolean gender = rs.getBoolean("gender");
                String phoneNumber = rs.getString("phoneNumber");
                int role = rs.getInt("roleID");
                int status = rs.getInt("statusID");
                String formatDateOfBirth = null;
                if (dateOfBirth != null) {
                    formatDateOfBirth = Helper.convertDateToString(dateOfBirth);
                }
                user = new UserDTO(email, name, formatDateOfBirth, gender, phoneNumber, role, status);
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }

    public UserDTO getUserByEmail(String email) throws SQLException, NamingException {
        UserDTO user = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT * FROM tblUsers WHERE userEmail=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("userName");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                boolean gender = rs.getBoolean("gender");
                String phoneNumber = rs.getString("phoneNumber");
                int role = rs.getInt("roleID");
                int status = rs.getInt("statusID");
                String formatDateOfBirth = null;
                if (dateOfBirth != null) {
                    formatDateOfBirth = Helper.convertDateToString(dateOfBirth);
                }
                user = new UserDTO(email, name, formatDateOfBirth, gender, phoneNumber, role, status);
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }
}
