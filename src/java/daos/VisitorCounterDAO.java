/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.VisitorCounterDTO;
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
public class VisitorCounterDAO {

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

    public boolean insertNewCounter(VisitorCounterDTO counter) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblVisitorCounters(logDate, visitorNumber) VALUES (?,?)";
                preStm = conn.prepareStatement(sql);
                preStm.setDate(1, java.sql.Date.valueOf(counter.getLogDate()));
                preStm.setInt(2, counter.getVisitorNumber());

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public long getTotalVisitorNumber() throws NamingException, SQLException {
        long number = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(visitorNumber) as number"
                        + " FROM tblVisitorCounters";
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    number = rs.getLong("number");
                }
            }
        } finally {
            this.closeConnection();
        }
        return number;
    }

    public int get30DaysVisitorNumber() throws SQLException, NamingException {
        int number = 0;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "DECLARE @date date = GETDATE() - ?"
                        + " SELECT COUNT(visitorNumber) AS number "
                        + " FROM tblVisitorCounters "
                        + " WHERE logDate = @date"
                        + " GROUP BY logDate";
                preStm = conn.prepareStatement(sql);
                for (int i = 0; i < 30; i++) {
                    preStm.setInt(1, i);
                    rs = preStm.executeQuery();
                    if (rs.next()) {
                        number += rs.getInt("number");
                    }
                }
            }
        } finally {
            this.closeConnection();
        }
        return number;
    }

    public ArrayList<Integer> getMonthlyVisitorOverview() throws NamingException, SQLException {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "DECLARE @date date = GETDATE() - ?"
                        + " SELECT COUNT(visitorNumber) AS number "
                        + " FROM tblVisitorCounters "
                        + " WHERE logDate = @date"
                        + " GROUP BY logDate ";
                preStm = conn.prepareStatement(sql);
                for (int i = 0; i < 30; i++) {
                    preStm.setInt(1, i);
                    rs = preStm.executeQuery();
                    if (rs.next()) {
                        list.add(rs.getInt("number"));
                    } else {
                        list.add(0);
                    }
                }
            }
        } finally {
            this.closeConnection();
        }
        return list ;
    }
}
