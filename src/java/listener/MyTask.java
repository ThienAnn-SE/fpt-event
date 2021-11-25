/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import daos.EventDAO;
import daos.EventRegisterDAO;
import daos.LocationDAO;
import dtos.EventDTO;
import java.util.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import utils.AutoMailerHelper;
import utils.Helper;

/**
 *
 * @author thien
 */
public class MyTask extends TimerTask {

    @Override
    public void run() {
        try {
            EventDAO eventDAO = new EventDAO();
            ArrayList<EventDTO> eventList = eventDAO.getEventForUpdateStatus();
            if (eventList == null) {
                throw new NullPointerException("The list is empty");
            }
            Date now = Date.from(Instant.now());
            for (int i = 0; i < eventList.size(); i++) {
                if (new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").parse(eventList.get(i).getEndDate()).before(now)) {
                    eventDAO.changeEventStatus(eventList.get(i).getEventID(), 570);
                } else if (new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").parse(eventList.get(i).getStartDate()).before(now)) {
                    eventDAO.changeEventStatus(eventList.get(i).getEventID(), 550);

                }
                if (Helper.is3DayAfterNow(new SimpleDateFormat("dd-MM-yyyy").parse(eventList.get(i).getCreateDate()))) {
                    eventDAO.changeEventStatus(eventList.get(i).getEventID(), 500);
                    EventRegisterDAO registerDAO = new EventRegisterDAO();
                    LocationDAO locationDAO = new LocationDAO();
                    String locationName = locationDAO.getLocationByID(eventList.get(i).getEventID()).getLocationName();
                    AutoMailerHelper sendMail = new AutoMailerHelper();
                    sendMail.sendEventNotification(registerDAO.getRegisterList(eventList.get(i).getEventID()), eventDAO.getEventByID(eventList.get(i).getEventID()), locationName);
                }
            }
        } catch (NamingException | SQLException | ParseException | MessagingException ex) {
            Logger.getLogger(MyTask.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
