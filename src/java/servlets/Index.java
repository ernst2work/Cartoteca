/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import static java.lang.System.err;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *Servlet is serving index.jsp
 * What it does is the autentification  of the clients, 
 * their validation as administrators or users. 
 * Failure to supoply valid username7password redirects the client to index.jsp "entry" page
 * Successful atentification sends clients  
 * depending of their status (admin or user), 
 * to eBookStoreMainPage.jsp  or
 * to eBookStore
 * @author ernst&all.
 */
public class Index extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // retrieve username and password introduced by user
        String username = request.getParameter("authenticationpage_username");
        String userpassword = request.getParameter("authenticationpage_password");
        
        // set connection specifications
        String user = "ernst";
        String password = "ernst";
        String url = "jdbc:derby://localhost:1527/ebooksstore;create=true";
        String driver = "org.apache.derby.jdbc.ClientDataSource40";

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        // attempts to open a connection to the database
        try {
            Class driverClass = Class.forName(driver);
            connection = DriverManager.getConnection(url, user, password);
            statement = connection.createStatement();
        // sql interrogation: the details of the user with the username and password supplied 
        // by the application's client are collected from the database / USERS table,
        // and stored in resultSet object -- the result of the interogation.
            String query = "SELECT SSN, USERNAME, PASSWORD, ROLE FROM ERNST.USERS WHERE USERNAME= '" + username + "' AND PASSWORD= '" + userpassword + "'";
            resultSet = statement.executeQuery(query);

            if (resultSet.next()) {
                //decide what to do, depemding on client's role (admin or user):
                String role = resultSet.getString(4);
                // if admin, "labels" THE SESSION as valid admin SESSION and send to response "transit" MainPage
                if ("admin".equals(role)) {
                    request.getSession().setAttribute("actualUserRole", "admin");
                    request.getSession().setAttribute("validUser", true);                    
                    response.sendRedirect("./eBookStoreMainPage.jsp");
                // if user, "labels" THE SESSION as valid user SESSION and send to "transit" MainPage
                } else if ("user".equals(role)) {
                    request.getSession().setAttribute("actualUserRole", "user");
                    request.getSession().setAttribute("validUser", true);                    
                    response.sendRedirect("./eBookStoreMainPage.jsp");                    
                }
            } else {
                //stay in index.jsp page
                response.sendRedirect("./index.jsp");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(err);
            // finally, close everything
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException ex) {
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login servlet";
    }// </editor-fold>

}
