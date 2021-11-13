/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author thien
 */
@WebFilter(filterName = "VisitorsCounterFilter", urlPatterns = {"/HomePageController"})
public class VisitorsCounterFilter implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public VisitorsCounterFilter() {
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        if (session.isNew()) {
            ServletContext servletContext = request.getServletContext();

            String realWebAppPath = servletContext.getRealPath("");
            String hitFilePath = realWebAppPath.concat("hit.txt");
            File hitFile = new File(hitFilePath);

            int currentHit = readHitCounterFromFile(hitFile);

            updateHitCounterFile(++currentHit, hitFile);
            System.out.println(currentHit);
        }
        chain.doFilter(request, response);
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

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
        
    }

    /**
     * Init method for this filter
     *
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("VisitorsCounterFilter:Initializing filter");
            }
        }
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
