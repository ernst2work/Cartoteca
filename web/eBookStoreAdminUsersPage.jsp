<%-- 
    Document   : ebookStoreAdminUserspage
    Created on : 07-Aug-2018, 16:40:51
    Author     : ernst
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eBookStore User Management</title>
        <link rel="stylesheet" type="text/css" href="./css/eBookStoreCSS.css"/>
    </head>
    <body>
        
        <%-- test if actual user is valid --%>
        <c:choose>
            <c:when  test="${validUser == true}">              
                <!-- include ADMIN menu, if the user is valid -->
                <%@ include file="./utils/eBookStoreMenu.jsp" %>
                
                <%-- ask the eBSAUS.java servlet do the integogation on database in line with specified parameters --%>
                <form action="${pageContext.request.contextPath}/eBookStoreAdminUsersServlet" method="POST">
                    <sql:setDataSource 
                        var="snapshot" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                    <sql:query dataSource="${snapshot}" var="result">
                        SELECT ERNST.USERS.SSN, ERNST.USERS.USERNAME, ERNST.USERS.PASSWORD, ERNST.USERS."ROLE" FROM ERNST.USERS, ERNST.USER_ROLES WHERE ERNST.USERS."ROLE" = ERNST.USER_ROLES."ROLE" ORDER BY USERNAME, "ROLE" ASC 
                    </sql:query>
                <!-- place the results of the interrogation in  a table, first the head of the table:  -->        
                    <table border="1" width="100%">
                        <tr>
                            <td width="4%" class="thc"> select </td>   
                            <td width="14%" class="thc"> SSN </td>  
                            <td width="14%" class="thc">USERNAME</td>
                            <td width="14%" class="thc">PASSWORD</td>
                            <td width="14%" class="thc">ROLE
                                <%-- this is a feature not implemented yet: --%>
                                <%-- <input type="submit" name="admin_userroles_open" value="Admin">
                                --%></td>
                        </tr>
                    </table>    
                    <table border="1" width="100%">    
                <!-- ...then the rows of the "result" of the interrogatoion  -->          
                        <c:forEach var="row" varStatus="loop" items="${result.rows}">
                            <tr>
                                <td width="4%" class="tdc"><input type="checkbox" name="admin_users_checkbox" value="${row.ssn}"></td>
                                <td width="14%" class="tdc"><c:out value="${row.ssn}"/></td>
                                <td width="14%" class="tdc"><c:out value="${row.username}"/></td>
                                <td width="14%" class="tdc"><c:out value="${row.password}"/></td>
                                <td width="14%" class="tdc"><c:out value="${row.role}"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                        
                    <%-- interogate the database to collect the rolenames --%>
                    <sql:setDataSource 
                        var="snapshotroles" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                    <sql:query dataSource="${snapshotroles}" var="resultroles">
                        SELECT ROLE from ERNST.USER_ROLES ORDER BY ROLE ASC 
                    </sql:query>
                        
                    <%-- interogate the database to collect the rolenames --%>    
                    <table class="tablecenterdwithborder">
                        <tr>
                            <td>    
                                <table>
                                    <tr>
                                        <td> SSN: </td>
                                        <td> <input type="text" class="inputlarge" name="admin_users_ssn"> </td>
                                    </tr>                                        
                                    <tr>
                                        <td> USERNAME: </td>
                                        <td> <input type="text" class="inputlarge" name="admin_users_username"> </td>
                                    </tr>
                                    <tr>
                                        <td> PASSWORD: </td>
                                        <td> <input type="password" class="inputlarge" name="admin_users_password"> </td>
                                    </tr>
                                    <tr>
                                        <td> ROLE: </td>
                                        <td class="inputlarge">
                                                <select name="admin_user_role" required>
                                                    <c:forEach var="rowrole" items="${resultroles.rows}">    
                                                        <option id="admin_users_roles" value="${rowrole.role}">${rowrole.role}</option>
                                                    </c:forEach>
                                                </select>
                                        </td>
                                    </tr>     
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%-- buttons --%>
                                <table>

                                    <tr><td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_users_insert" value="Insert"></td> 
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_users_update" value="Update"></td>
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_users_delete" value="Delete"></td> 
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_users_cancel" value="Cancel"></td>
                                    </tr>  
                                </table>
                            </td>
                        </tr>
                    </table>    
                </form>
            </c:when>
            <c:otherwise>
                <c:redirect url="./index.jsp"></c:redirect>
            </c:otherwise>
        </c:choose>
    </body>    
</html>