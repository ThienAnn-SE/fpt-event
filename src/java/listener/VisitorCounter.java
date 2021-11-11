/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import daos.VisitorCounterDAO;
import dtos.VisitorCounterDTO;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;

/**
 *
 * @author thien
 */
public class VisitorCounter extends TimerTask {

    private final ServletContext servletContext;

    public VisitorCounter(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @Override
    public void run() {
        try {
            String realWebAppPath = servletContext.getRealPath("");
            String hitFilePath = realWebAppPath.concat("hit.txt");
            File hitFile = new File(hitFilePath);

            int currentHit = readHitCounterFromFile(hitFile);
            //store the visitor counter
            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
            VisitorCounterDTO counter = new VisitorCounterDTO(currentDate, currentHit);
            VisitorCounterDAO counterDAO = new VisitorCounterDAO();
            if (!counterDAO.insertNewCounter(counter)) {
                throw new SQLException("Can not insert new record for tblVisitorCounters");
            }

            updateHitCounterFile(0, hitFile);
        } catch (IOException | NamingException | SQLException ex) {
            Logger.getLogger(VisitorCounter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private int readHitCounterFromFile(File file) throws FileNotFoundException, IOException {
        if (!file.exists()) {
            return 0;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            int hit = Integer.parseInt(reader.readLine());
            return hit;
        }
    }

    private void updateHitCounterFile(long hit, File hitFile) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(hitFile));) {
            writer.write(String.valueOf(hit));
        }
    }
}
