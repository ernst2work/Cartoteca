<%-- 
    Document   : eBookStoreAdminBookspage
    Created on : 09-Aug-2018, 22:03:46
    Author     : i.an
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BooksStore Book Management Page </title>
        <link rel="stylesheet" type="text/css" href="./css/eBookStoreCSS.css">
    </head>
    <body>
        <h1>Manage the Books from eBookStore</h1>

        <%-- test if actual user is authenticated and authorized --%>
        <c:choose>
            <c:when test="${validUser == true}">   
                <!-- include menu -->
                <%@ include file="./utils/eBookStoreMenu.jsp" %>
                <%-- Master view --%>
                <form action="${pageContext.request.contextPath}/eBookStoreAdminBooksServlet" method="POST">  
                    <%-- usage of JSTL tag setDataSource for DB connection --%>
                    <sql:setDataSource 
                        var="snapshot" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>


                    <sql:query dataSource="${snapshot}" var="result">
                        SELECT ISBN, BOOK_NAME, ID_FORMAT, ID_QUALITY, PAGES, ID_GENRE, PRICE, STOCK FROM ERNST.BOOKS
                    </sql:query>
                    <table border="1" width="100%">
                        <tr>
                            <td width="4%" class="thc"> select </td>   
                            <td width="12%" class="thc"> ISBN </td>  
                            <td width="18%" class="thc">BOOK_NAME</td>
                            <td width="10%" class="thc">ID_FORMAT</td>
                            <td width="10%" class="thc">ID_QUALITY</td>
                            <td width="10%" class="thc">PAGES</td>
                            <td width="10%" class="thc">ID_GENRE</td>
                            <td width="10%" class="thc">PRICE</td>
                            <td width="10%" class="thc">STOCK</td>
                        </tr>
                    </table>    
                    <table border="1" width="100%">    
                        <c:forEach var="row" varStatus="loop" items="${result.rows}">
                            <tr>
                                <td width="4%" class="tdc"><input type="checkbox" name="admin_users_checkbox" value="${row.isbn}"></td>
                                <td width="12%" class="tdc"><c:out value="${row.isbn}"/></td>
                                <td width="18%" class="tdc"><c:out value="${row.book_name}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.id_format}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.id_quality}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.pages}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.id_genre}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.price}"/></td>
                                <td width="10%" class="tdc"><c:out value="${row.stock}"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%-- Details --%>
                    <sql:setDataSource 
                        var="snapshotgenres" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                    <sql:query dataSource="${snapshotgenres}" var="resultgenres">
                        SELECT ID, GENRE FROM ERNST.BOOK_GENRES 
                    </sql:query>
                    <sql:setDataSource 
                        var="snapshotpaperqualities" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                    <sql:query dataSource="${snapshotpaperqualities}" var="resultpaperqualities">
                        SELECT ID, QUALITY FROM ERNST.BOOK_PAPER_QUALITIES 
                    </sql:query>    
                    <sql:setDataSource 
                        var="snapshotformats" 
                        driver="org.apache.derby.jdbc.ClientDriver40"
                        url="jdbc:derby://localhost:1527/ebooksstore;create=true;"
                        user="ernst"  
                        password="ernst"/>
                    <sql:query dataSource="${snapshotformats}" var="resultformats">
                        SELECT ID, FORMAT FROM ERNST.BOOK_FORMATS 
                    </sql:query>    
                    <table class="tablecenterdwithborder">
                        <tr>
                            <td>    
                                <table>
                                    <tr>
                                        <td> STOCK: </td>
                                        <td> <input type="text" name="admin_books_stock"></td>
                                    </tr>
                                    <tr>
                                        <td> ISBN: </td>
                                        <td> <input type="text" name="admin_books_isbn"></td>
                                    </tr>                                        
                                    <tr>
                                        <td> NAME: </td>
                                        <td> <input type="text" name="admin_books_name"></td>
                                    </tr>
                                    <tr>
                                        <td> PAGES: </td>
                                        <td> <input type="text" name="admin_books_pages"></td>
                                    </tr>
                                    <tr>
                                        <td> PRICE: </td>
                                        <td> <input type="text" name="admin_books_price"></td>
                                    </tr>
                                    <td> ID_FORMAT: </td>
                                    <td>
                                        <select name="admin_books_id_format" required>
                                            <c:forEach var="rowformat" items="${resultformats.rows}">    
                                                <option name="admin_books_formats" value="${rowformat.ID}|${rowformat.format}">${rowformat.ID}|${rowformat.format}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                        </tr>
                        <tr>
                            <td> ID_PAPER_QUALITY: </td>
                            <td>
                                <select name="admin_books_id_paper_quality" required>
                                    <c:forEach var="rowquality" items="${resultpaperqualities.rows}">    
                                        <option name="admin_books_qualities" value="${rowquality.ID}|${rowquality.quality}">${rowquality.ID}|${rowquality.quality}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td> ID_GENRE: </td>
                            <td>
                                <select name="admin_books_id_genre" required>
                                    <c:forEach var="rowgenre" items="${resultgenres.rows}">    
                                        <option name="admin_books_genres" value="${rowgenre.ID}|${rowgenre.genre}">${rowgenre.ID}|${rowgenre.genre}</option>
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

                        <tr><td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_books_insert" value="Insert"></td> 
                            <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_books_update" value="Update"></td>
                            <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_books_delete" value="Delete"></td> 
                            <td class="tdc"><input type="submit" class="ebooksstorebutton" name="admin_books_cancel" value="Cancel"></td>
                        </tr>  
                    </table>
                </td>
            </tr>
        </table>    

    </c:when>
    <c:otherwise>
        <c:redirect url="./index.jsp"></c:redirect>
    </c:otherwise>
</c:choose>
</form>
</body>
</html>