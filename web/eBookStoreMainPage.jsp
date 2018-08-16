<%-- 
    Document   : eBookStore
    Created on : 03-Aug-2018, 17:37:32
    Author     : i.an
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BookStore's Main Page</title>
        <link rel="stylesheet" type="text/css" href="./css/eBookStoreCSS.css"/>
    </head>
    
    <body>
        
        <%-- depending on the actualuser Role, a specific menu is INCLUDED in the page --%>
        <c:choose>
            <c:when test="${(actualUserRole == 'admin')||(actualUserRole =='user')}" >
                <%@ include file="./utils/eBookStoreMenu.jsp" %>
            </c:when>
         <%-- if neither admin nor user, the session is re-directed to index.jsp page [login page] --%>    
            <c:otherwise>
                <c:redirect url="./index.jsp"></c:redirect>
            </c:otherwise>
        </c:choose>
        
    </body>
</html>
