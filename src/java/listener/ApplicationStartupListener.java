package listener;

import dao.DatabaseConnection;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class ApplicationStartupListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=================================================");
        System.out.println("UiTM Activity Management System Starting Up...");
        System.out.println("=================================================");
        
        // Test database connection
        try {
            Connection conn = DatabaseConnection.getDBConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✓ Database connection successful");
                conn.close();
            } else {
                System.err.println("✗ Database connection failed");
            }
        } catch (SQLException e) {
            System.err.println("✗ Database connection error: " + e.getMessage());
        }
        
        // Set application attributes
        sce.getServletContext().setAttribute("appName", "UiTM Activity Management System");
        sce.getServletContext().setAttribute("appVersion", "1.0.0");
        sce.getServletContext().setAttribute("startupTime", System.currentTimeMillis());
        
        System.out.println("✓ Application context initialized");
        System.out.println("✓ System ready to accept requests");
        System.out.println("=================================================");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=================================================");
        System.out.println("UiTM Activity Management System Shutting Down...");
        System.out.println("=================================================");
        
        // Close database connections
        try {
            DatabaseConnection.getInstance().closeConnection();
            System.out.println("✓ Database connections closed");
        } catch (Exception e) {
            System.err.println("✗ Error closing database connections: " + e.getMessage());
        }
        
        System.out.println("✓ Application context destroyed");
        System.out.println("=================================================");
    }
}