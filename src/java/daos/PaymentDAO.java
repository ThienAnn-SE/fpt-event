/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.PaymentDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.naming.NamingException;
import utils.DBHelpers;

/**
 *
 * @author thien
 */
public class PaymentDAO {

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

    public boolean addNewPayment(PaymentDTO dto) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            String sql = "INSERT INTO tblPayments(registerID, paymentDescription, statusDescription, paymentMethod, paymentDate, paymentTotal)"
                    + " VALUES(?,?,?,?)";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getRegisterID());
            preStm.setNString(2, dto.getPaymentDescription());
            preStm.setString(3, dto.getStatusDescription());
            preStm.setString(4, dto.getPaymentMethod());
            preStm.setDate(5, java.sql.Date.valueOf(dto.getPaymentDate()));
            preStm.setDouble(6, dto.getPaymentTotal());

            isSuccess = preStm.executeUpdate() > 0;
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }

    public ArrayList<PaymentDTO> getClubEventPayment(int clubID) throws NamingException, SQLException {
        ArrayList<PaymentDTO> list = new ArrayList<>();
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "SELECT *"
                        + " FROM tblPayments WHERE registerID IN"
                        + " (SELECT registerID"
                        + " FROM tblEventRegisters WHERE eventID IN"
                        + " (SELECT eventID"
                        + " FROM tblFUEvents"
                        + " WHERE clubID = ?))";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, clubID);
                rs = preStm.executeQuery();

                while (rs.next()) {
                    int registerID = rs.getInt(("registerID"));
                    String paymentDescription = rs.getNString("paymentDescription");
                    String statusDescription = rs.getString("statusDescription");
                    String paymentMethod = rs.getString("paymentMethod");
                    String paymentDate = new SimpleDateFormat("MMM dd,yyyy HH:mm:ss").format(rs.getTimestamp("paymentDate"));
                    double paymentTotal = rs.getDouble("paymentTotal");
                    list.add(new PaymentDTO(registerID, paymentDescription, statusDescription, paymentMethod, paymentDate, paymentTotal));
                }
            }
        } finally {
            this.closeConnection();
        }
        return list;
    }

    public boolean changePaymentStatus(int registerID) throws NamingException, SQLException {
        boolean isSuccess = false;
        try {
            conn = DBHelpers.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblPayments"
                        + " SET statusDescription = ?"
                        + " WHERE registerID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "paid");
                preStm.setInt(2, registerID);

                isSuccess = preStm.executeUpdate() > 0;
            }
        } finally {
            this.closeConnection();
        }
        return isSuccess;
    }
}
