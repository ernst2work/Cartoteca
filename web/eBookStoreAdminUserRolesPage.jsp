<%-- 
   Document   : index
   Created on : 07-Jul-2018, 17:16:50
   Author     : ernst
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> BookStore User Roles Management Page</title>
        <link rel="stylesheet" type="text/css" href="./css/eBookStoreCSS.css">
    </head>
    <body>
            <%-- test if actual user is authenticated and authorized --%>
        <c:choose>
                <c:when test="${validUser == true}">   
                    <%-- Build the table containing actual user roles and their roles in a master-detail view--%>
                    <%-- include menu --%>
                    <%@ include file="./utils/eBookStoreMenu.jsp" %>
                    <%-- Master view --%>
                        <form action="${pageContext.request.contextPath}/eBookStoreAdminUserRolesServlet" method="POST">
                        <sql:setDataSource 
                        var="snapshot" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                        <sql:query dataSource="${snapshot}" var="result">
                            SELECT ROLE from ERNST.USER_ROLES ORDER BY ROLE ASC 
                        </sql:query>
                        <table border="1" width="100%">
                            <tr>
                            <td class="thc">select</td>    
                            <td class="thc">ROLE</td>
                            </tr>
                            <c:forEach var="row" varStatus="loop" items="${result.rows}">
                            <tr>
                                <td class="tdc"><input type="checkbox" name="admin_user_roles_checkbox" value="${row.role}"></td>
                                <td class="tdc"><c:out value="${row.role}"/></td>
                            </tr>
                            </c:forEach>
                        </table>
                        <%-- Details --%>
                        <table class="tablecenterdwithborder">
                            <tr><td>
                            <table>
                                <tr>
                                    <td> ROLE </td>
                                    <td> <input type="text" name="admin_user_roles_role"> </td>
                                </tr>
                            </table>
                            <%-- buttons --%>
                            <table>
                                    <tr><td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_user_roles_insert" value="Insert"> </td> 
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_user_roles_update" value="Update"> </td>
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_user_roles_delete" value="Delete"> </td> 
                                        <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_user_roles_cancel" value="Cancel"> </td>
                                    </tr>     
                            </table>
                            </td></tr>
                        </table>    
                        </form>
            </c:when>
            <c:otherwise>
                <c:redirect url="./index.jsp"></c:redirect>
            </c:otherwise>
        </c:choose>                
    </body>
</html>