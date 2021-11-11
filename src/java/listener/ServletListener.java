/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author thien
 */
public class ServletListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //timer for update event status
        Timer timer = new Timer();
        MyTask myTask = new MyTask();
        timer.schedule(myTask, 0, 1000 * 60 * 5);
        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("timer", timer);

        //set up calendar for get visitor counter at 00 am every day
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);

        Date dateSchedule = calendar.getTime();
        long period = 24 * 60 * 60 * 1000;
        
        //timer for get visitor counter
        VisitorCounter visitorCounter = new VisitorCounter(servletContext);
        Timer counter = new Timer();
        counter.schedule(visitorCounter, dateSchedule, period);
        servletContext.setAttribute("counter", counter);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        Timer timer = (Timer) servletContext.getAttribute("timer");
        Timer counter = (Timer) servletContext.getAttribute("counter");
        if (timer != null) {
            timer.cancel();
        }
        if (counter != null) {
            counter.cancel();
        }
        servletContext.removeAttribute("timer");
        servletContext.removeAttribute("counter");
    }
}
