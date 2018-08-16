/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet is serving eBookStoreAdminUsersPage.jsp
 * 
 * what it does, depends on the values of the values of the "control variables" received:
 * admin_users_insert if not null INSERTS element to USER table [content is supplied by other fields of a form)
 * admin_users_update if not null UPDATES element to USER table [for the ssn specified)
 * admin_users_delete if not null INSERTS element to USER table 
 * 
 * after each of these operations, a RequestDispatcher (of the request) 
 * is used to forward the request object BACK to eBookStoreAdminUsersPage.jsp
 * 
 * @author ernst&all.
 */
public class eBookStoreAdminUsersServlet extends HttpServlet {

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
            
            // check push on INSERT button, and if yes ADDS [INSERTS] elements (rows) to database's USER table
            // declare specific DB info
            String user = "ernst" ;
            String password = "ernst";
            String url = "jdbc:derby://localhost:1527/ebooksstore;create=true;";
            String driver = "org.apache.derby.jdbc.ClientDriver";  
            
            if (request.getParameter("admin_users_insert") != null) { // insert values from fields
                // set connection paramters to the DB
                // read values from page fields
                String ssn = request.getParameter("admin_users_ssn");
                String username = request.getParameter("admin_users_username");
                String user_password = request.getParameter("admin_users_password");
                String role = request.getParameter("admin_user_role");
//                String customer = request.getParameter("admin_user_customer");
                // declare specific DBMS operations variables
                ResultSet resultSet = null;
                Statement statement = null;
                Connection connection = null;
                PreparedStatement pstmnt = null;
                try
                { 
                    //check driver and create connection
                    Class driverClass = Class.forName(driver);
                    connection = DriverManager.getConnection(url, user, password);
                    
                    String DML = "INSERT INTO ERNST.USERS VALUES (?, ?, ?, ?)";
                    
                    pstmnt = connection.prepareStatement(DML);
                    pstmnt.setString(1, ssn);
                    pstmnt.setString(2, username);
                    pstmnt.setString(3, user_password);
                    pstmnt.setString(4, role);
                    pstmnt.execute();
                }
                catch (ClassNotFoundException | SQLException ex)
                {
                    // display a message for NOT OK
                    Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                finally
                {
                    if (resultSet != null)
                    {
                        try
                        {
                            resultSet.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    if (statement != null)
                    {
                        try
                        {
                            statement.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    if (pstmnt != null)
                    {
                        try
                        {
                            pstmnt.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    if (connection != null)
                    {
                        try
                        {
                            connection.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    // redirect page to its JSP as view
                    request.getRequestDispatcher("./eBookStoreAdminUsersPage.jsp").forward(request, response);
                }
            }  

                // check push on UPDATE button
            else if (request.getParameter("admin_users_update") != null){ // update
                // declare specific variables
                ResultSet resultSet = null;
                Statement statement = null;
                PreparedStatement pstmnt = null;
                Connection connection = null;
                try
                { 
                    //check driver and create connection
                    Class driverClass = Class.forName(driver);
                    connection = DriverManager.getConnection(url, user, password);
                    // identify selected checkbox and for each execute the update operation
                    String[] selectedCheckboxes = request.getParameterValues("admin_users_checkbox");
                    String username = request.getParameter("admin_users_username");
                    String user_password = request.getParameter("admin_users_password");
                    String role = request.getParameter("admin_user_role");
                    // if both username and password are "" do nothing
                    if(!(("".equals(username)) && ("".equals(user_password)))){
                        // operate updates for all selected rows
                        for(String s : selectedCheckboxes){
                            // realize update of all selected rows
                            String ssn = s;
                            if("".equals(username)){ // only password/s should be updated
                                String DML = "UPDATE ERNST.USERS SET ssn=?, password=?,role=? WHERE SSN=?";
                                pstmnt = connection.prepareStatement(DML);
                                pstmnt.setString(1, ssn);
                                pstmnt.setString(2, user_password);
                                pstmnt.setString(3, role);
                                pstmnt.setString(4, ssn);
                            }
                            else if("".equals(user_password)){// only username should be updated
                                String DML = "UPDATE ERNST.USERS SET ssn=?, name=?,role=? WHERE SSN=?";
                                pstmnt = connection.prepareStatement(DML);
                                pstmnt.setString(1, ssn);
                                pstmnt.setString(2, username);
                                pstmnt.setString(3, role);
                                pstmnt.setString(4, ssn);
                            }else{
                                String DML = "UPDATE ERNST.USERS SET ssn=?, name=?, password=?,role=? WHERE SSN=?";
                                pstmnt = connection.prepareStatement(DML);
                                pstmnt.setString(1, ssn);
                                pstmnt.setString(2, username);
                                pstmnt.setString(3, user_password);
                                pstmnt.setString(4, role);
                                pstmnt.setString(5, ssn);
                            }
                            boolean execute = pstmnt.execute();
                        }
                    }else{ // update one or more roles for one or more users
                        for(String s : selectedCheckboxes){
                            // realize update of all selected rows
                            String ssn = s;
                            String DML = "UPDATE ERNST.USERS SET role=? WHERE SSN=?";
                            pstmnt = connection.prepareStatement(DML);
                            pstmnt.setString(1, role);
                            pstmnt.setString(2, ssn);
                            boolean execute = pstmnt.execute();
                        }                    
                    }
                }
                catch (ClassNotFoundException | SQLException ex)
                {
                    // display a message for NOT OK
                    Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);

                }
                finally
                {
                    if (resultSet != null)
                    {
                        try
                        {
                            resultSet.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    if (pstmnt != null)
                    {
                        try
                        {
                            pstmnt.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }	
                    if (connection != null)
                    {
                        try
                        {
                            connection.close();
                        }
                        catch (SQLException ex){Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);}
                    }
                    // redirect page to its JSP as view
                    request.getRequestDispatcher("./eBookStoreAdminUsersPage.jsp").forward(request, response);
                }
            } // check push on DELETE  button
            else if (request.getParameter("admin_users_delete") != null) { // delete 
                // declare specific variables
                ResultSet resultSet = null;
                PreparedStatement pstmnt = null;
                Connection connection = null;
                try
                {
                    //check driver and create connection
                    Class driverClass = Class.forName(driver);
                    connection = DriverManager.getConnection(url, user, password);
                    // identify selected checkbox and for each execute the delete operation
                    String[] selectedCheckboxes = request.getParameterValues("admin_users_checkbox");
                    // more critical DB operations should be made into a transaction
                    connection.setAutoCommit(false);
                    for(String s : selectedCheckboxes){
                        // realize delete of all selected rows
                        String ssn = s;
                        String DML = "DELETE FROM ERNST.USERS WHERE SSN=?";
                        pstmnt = connection.prepareStatement(DML);
                        pstmnt.setString(1, ssn);
                        pstmnt.execute();
                    }
                    connection.commit();
                    connection.setAutoCommit(true);
                }
                catch (ClassNotFoundException | SQLException ex)
                {
                    Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                    if (connection != null){
                        try {
                            connection.rollback();
                        } catch (SQLException ex1) {
                            Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex1);
                        }
                    }
                }              
                finally
                {
                    if (resultSet != null)
                    {
                        try
                        {
                            resultSet.close();
                        }
                        catch (SQLException ex){
                            Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (pstmnt != null)
                    {
                        try
                        {
                            pstmnt.close();
                        }
                        catch (SQLException ex){
                            Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (pstmnt != null)
                    {
                        try
                        {
                            pstmnt.close();
                        }
                        catch (SQLException ex){
                            Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (connection != null){
                        try
                        {
                            connection.setAutoCommit(true);
                        }
                        catch (SQLException ex){                          
                            Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        finally{
                            try {
                                connection.close();
                            } catch (SQLException ex) {
                                Logger.getLogger(eBookStoreAdminUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }
                    // redirect page to its JSP as view
                    request.getRequestDispatcher("./eBookStoreAdminUsersPage.jsp").forward(request, response);
                }
            } // check push on CANCEL button
            else if (request.getParameter("admin_users_cancel") != null){ // cancel
                request.getRequestDispatcher("./eBookStoreMainPage.jsp").forward(request, response);
            } // check push on admin user roles button
            else if (request.getParameter("admin_userroles_open") != null) { // insert values from fields
                request.getRequestDispatcher("./eBookStoreAdminUsersPage.jsp").forward(request, response);
            } // check push on admin customers button
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
        return "Servlet is serving eBooksStoreAdminUsersPage.jsp";
    }// </editor-fold>

}