/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

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
        Timer timer = new Timer();
        MyTask myTask = new MyTask();
        timer.schedule(myTask, 0, 1000 * 60 * 5);
        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("timer", timer);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        Timer timer = (Timer) servletContext.getAttribute("timer");
        if (timer != null) {
            timer.cancel();
        }
        
        servletContext.removeAttribute("timer");
    }
}
