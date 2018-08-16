<%-- 
   Document   : index
   Created on : 07-Jul-2018, 17:16:50
   Author     : ernst
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./css/eBookStoreCSS.css" >
        <title>eBookStore welcome page</title>
    </head>

    <body>
        <c:set var="activePage" value="index" scope="session"></c:set>
            <h1>Welcome to the BookStore!</h1>

        <%-- authentification box begins --%>
        <%-- authentification box invokes */Index servlet with doPost method --%>
        <form action="${pageContext.request.contextPath}/Index" method="POST">   
            <table style="width:25%" class = "tablecenterdwithborder" >  
                <tr> <td> USERNAME:</td> <td> <input class="inputlarge" type="text" name = "authenticationpage_username"> </td> </tr>
                <tr> <td> PASSWORD:</td> <td> <input class="inputlarge" type="password" name = "authenticationpage_password"> </tr>
                <tr> <td> </td> <td> <input class="inputlarge" type="submit" value="Login" name = "authenticationpage_authenticate"> </td> </tr> 
            </table> 
        </form>  
        <%-- authentification/invocation box ends  --%>

    </body>
</html>