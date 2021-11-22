/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.ClubDTO;
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
public class ClubDAO {

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

    public boolean addNewClub(ClubDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail)"
                        + " VALUES(?,?,?,?,?,?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getClubName());
                preStm.setDate(2, java.sql.Date.valueOf(Helper.convertDateToSQLString(dto.getCreateDate())));
                preStm.setNString(3, dto.getClubDescription());
                preStm.setString(4, dto.getClubEmail());
                preStm.setString(5, dto.getClubPhoneNumber());
                preStm.setString(6, dto.getUserEmail());

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ClubDTO getClubByID(int id) throws NamingException, SQLException {
        ClubDTO club = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " Select * "
                        + " From tblClubDetails "
                        + " Where clubID = ? ";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int clubID = rs.getInt("clubID");
                    String clubName = rs.getString("clubName");
                    Date createDate = rs.getDate("createDate");
                    String clubDescription = rs.getString("clubDescription");
                    String clubEmail = rs.getString("clubEmail");
                    String clubPhoneNumber = rs.getString("clubPhoneNumber");
                    club = new ClubDTO(clubID, clubName, createDate, clubDescription, clubEmail, clubPhoneNumber);
                }
            }
        } finally {
            this.closeConnection();
        }
        return club;
    }

    public ClubDTO getClubByEmail(String email) throws NamingException, SQLException {
        ClubDTO club = null;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "SELECT *"
                    + " FROM tblClubDetails"
                    + " WHERE userEmail = ?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int clubID = rs.getInt("clubID");
                String clubName = rs.getString("clubName");
                Date createDate = rs.getDate("createDate");
                String clubDescription = rs.getString("clubDescription");
                String clubEmail = rs.getString("clubEmail");
                String clubPhoneNumber = rs.getString("clubPhoneNumber");
                club = new ClubDTO(clubID, clubName, createDate, clubDescription, clubEmail, clubPhoneNumber);
            }
        } finally {
            this.closeConnection();
        }
        return club;
    }

    public String getClubLeaderEmail(int clubID) throws NamingException, SQLException {
        String email = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT userEmail"
                        + " FROM tblClubDetails"
                        + " WHERE clubID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, clubID);
                rs = preStm.executeQuery();

                if (rs.next()) {
                    email = rs.getString("userEmail");
                }
            }
        } finally {
            this.closeConnection();
        }
        return email;
    }

    public ClubDTO getClubByName(String clubName) throws NamingException, SQLException {
        ClubDTO club = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT clubID, userEmail"
                        + " FROM tblClubDetails"
                        + " WHERE clubName = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, clubName);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int clubID = rs.getInt("clubID");
                    String userEmail = rs.getString("userEmail");
                    club = new ClubDTO(clubID, userEmail);
                }
            }
        } finally {
            this.closeConnection();
        }
        return club;
    }

    public ClubDTO getClubByPhoneNumber(String phoneNumber) throws NamingException, SQLException {
        ClubDTO club = null;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT clubID, userEmail"
                        + " FROM tblClubDetails"
                        + " WHERE clubPhoneNumber = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, phoneNumber);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int clubID = rs.getInt("clubID");
                    String userEmail = rs.getString("userEmail");
                    club = new ClubDTO(clubID, userEmail);
                }
            }
        } finally {
            this.closeConnection();
        }
        return club;
    }

    public ArrayList<ClubDTO> getAllClubs() throws SQLException, NamingException {
        ArrayList<ClubDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = " Select * "
                        + " From tblClubDetails";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int clubID = rs.getInt("clubID");
                    String clubName = rs.getString("clubName");
                    Date createDate = rs.getDate("createDate");
                    String clubDescription = rs.getString("clubDescription");
                    String clubEmail = rs.getString("clubEmail");
                    String clubPhoneNumber = rs.getString("clubPhoneNumber");
                    ClubDTO club = new ClubDTO(clubID, clubName, createDate, clubDescription, clubEmail, clubPhoneNumber);
                    list.add(club);
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public boolean updateClubLeaderEmail(int clubID, String userEmail) throws SQLException, NamingException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblClubDetails"
                        + " SET userEmail = ?"
                        + " WHERE clubID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, userEmail);
                preStm.setInt(2, clubID);

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public boolean updateClubInformation(ClubDTO club, String userEmail) throws SQLException, NamingException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblClubDetails SET clubName=?, clubDescription=?, clubPhoneNumber=?, clubEmail=? WHERE userEmail=?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, club.getClubName());
                preStm.setString(2, club.getClubDescription());
                preStm.setString(3, club.getClubPhoneNumber());
                preStm.setString(4, club.getClubEmail());
                preStm.setString(5, userEmail);

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }
}
