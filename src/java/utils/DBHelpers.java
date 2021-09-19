package utils;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

public class DBHelpers implements Serializable {
    /**
     * Get sql database connection
     *
     * @return connection to database
     * @throws NamingException
     * @throws SQLException
     */
    public static Connection makeConnection() throws NamingException, SQLException {
        //1.get current system file
        Context context = new InitialContext();
        //2. get container context
        Context tomcatContext = (Context) context.lookup("java:comp/env");
        //3.get Datasource form Container
        DataSource ds = (DataSource) tomcatContext.lookup("DSBlink");
        //4. get Connection
        Connection con = ds.getConnection();
        return con;
    }
}
