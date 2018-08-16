<%-- 
    Document   : eBookStoreMenu
    Created on : 07-Aug-2018, 00:48:42
    Author     : i.an
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8" />
        <title>BookStore Menu</title>
        <link href="./css/menu.css" rel="stylesheet" type="text/css" />
    </head>
    
    <body>
        
<%-- the beginning of the navigable menu  --%>        
        <ul id="nav">
            <c:choose>
                <c:when test="${(actualUserRole == 'admin')||(actualUserRole =='user')}">
                    <li><a href="#">Manage</a>
                        <ul>
                            <c:choose>
                                <c:when test="${actualUserRole == 'admin'}">
                                    <li><a href="./eBookStoreAdminUsersPage.jsp"> Users </a></li>
                                    <li><a href="./eBookStoreAdminUserRolesPage.jsp">User roles</a></li>
                                    <li><a href="./eBookStoreAdminBooksPage.jsp"> Books </a></li>
                                    </c:when>
                                <c:when test="${actualUserRole == 'user'}">
                                    <li><a href="./eBookStoreAdminUsersPage.jsp"> Account </a></li>
                                    </c:when>                                    
                                </c:choose>                              
                        </ul>
                    </li>
                </c:when>
            </c:choose>        
            <c:choose>
                <c:when test="${actualUserRole == 'admin'}">
                    <li><a href="#">Orders</a>
                        <ul>
                            <%-- <li><a href="./eBooksStoreOrderBookPage.jsp">Orders</a></li> --%>
                            <li><a href="./eBooksStoreMainPage.jsp">Orders</a></li>
                            <li><a href="./eBooksSoldEBooksPage.jsp">Books Inventory</a></li>
                        </ul>
                    </li>    
                </c:when>
            </c:choose>              
            <c:choose>
                <c:when test="${actualUserRole == 'user'}">
                    <li><a href="#">Browse Books</a>
                        <ul>
                            <c:choose>
                                <c:when test="${actualUserRole == 'user'}">
                                    <li><a href="./eBookStoreUserAllBooks.jsp"> All Books </a></li>
                                    <li><a href="./eBookStoreUserBookSearch.jsp">Book Search</a></li>                     
                                    </c:when>
                                </c:choose>                              
                        </ul>
                    </li>
                </c:when>
            </c:choose>        
            <c:choose>
                <c:when test="${actualUserRole == 'user'}">
                    <li><a href="#">Orders</a>
                        <ul>
                            <%-- <li><a href="./eBooksStoreOrderBookPage.jsp">Orders</a></li> --%>
                            <li><a href="./eBooksStoreUserSeeBasket.jsp"> See Basket</a></li>
                            <li><a href="./eBooksStoreUserCommitBasket.jsp">Commit Basket</a></li>
                        </ul>
                    </li>    
                </c:when>
            </c:choose>                           
                    
            <li><a href="./eBooksStoreExit.jsp">Log out</a></li>
        </ul>
        
 <%-- the end  of the navigable menu  --%>  
 
        <script src="js/script.js"></script>
    </body>
</html>