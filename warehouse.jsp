<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.sore.model.*"  %>
<!DOCTYPE html>
<html >
  <head>
      
      
      <style>
      @import url(http://fonts.googleapis.com/css?family=Tenor+Sans);
html {
  background-color: #5D92BA;
  font-family: "Tenor Sans", sans-serif;
}

.container {
  width: 500px;
  height: 400px;
  margin: 0 auto;
}

.warehouse {
  margin-top: 50px;
  width: 450px;
}

.warehouse-heading {
  font: 1.8em/48px "Tenor Sans", sans-serif;
  color: white;
}

.input-txt {
  width: 100%;
  padding: 20px 10px;
  background: #5D92BA;
  border: none;
  font-size: 1em;
  color: white;
  border-bottom: 1px dotted rgba(250, 250, 250, 0.4);
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -moz-transition: background-color 0.5s ease-in-out;
  -o-transition: background-color 0.5s ease-in-out;
  -webkit-transition: background-color 0.5s ease-in-out;
  transition: background-color 0.5s ease-in-out;
}
.input-txt:-moz-placeholder {
  color: #81aac9;
}
.input-txt:-ms-input-placeholder {
  color: #81aac9;
}
.input-txt::-webkit-input-placeholder {
  color: #81aac9;
}
.input-txt:focus {
  background-color: #4478a0;
}

.login-footer {
  margin: 10px 0;
  overlow: hidden;
  float: left;
  width: 100%;
}

.btn {
  padding: 15px 30px;
  border: none;
  background: white;
  color: #5D92BA;
}

.btn--right {
  float: right;
}

.icon {
  display: inline-block;
}

.icon--min {
  font-size: .9em;
}

.lnk {
  font-size: .8em;
  line-height: 3em;
  color: white;
  text-decoration: none;
}

      </style>
    <meta charset="UTF-8">
    <title>Warehouse Inventory</title>    
  </head>
  <body>
 <div class="container">
  <div class="warehouse">
  	<h1 class="warehouse-heading">
  	<%
  	String name=(String)request.getAttribute("name");
  	String uid=(String)request.getAttribute("userid");
  	%>
      <strong>Welcome, <%=name  %></strong></h1>
      <form method="post" action="Warehouse">
      <% if (uid!=null) { %>
        <input name="userid" type="text" value="<%=uid%>" />
         <input name="name" type="text" value="<%=name %>"/>
         <button type="submit" class="btn btn--right">View</button>
       <% } %>
      </form>
      
    <div>
      	<%
  	String pName=(String)request.getAttribute("Name");
  	String line1=(String)request.getAttribute("line1");
  	String line2=(String)request.getAttribute("line2");
  	String city=(String)request.getAttribute("city");
  	ArrayList<WarehouseItem> result=(ArrayList<WarehouseItem>)request.getAttribute("item_list");
  	
  	int i;
  	%>	
  	<h2 class=login-footer>
  	<% if (pName!=null) { %>
  	Address:<br>
  	<%=pName %><br>
  	<%=line1 %>
  	<%=line2 %><br>
  	<%=city %><br>
  	<div align="center">
  	<table>
  	<c:forEach items="${result}" var="item">
  	<tr>
    <td>${item.name}</td>
    <td>${item.desc}</td>
    <td>${item.quantity}</td> 
    </tr>   
    </c:forEach>
  	</table>
  	</div>
  	<%}%>
  	</h2>
  	
   </div>
  </div>
</div>    
  </body>
</html>
