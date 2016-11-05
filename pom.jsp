<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.sore.model.*"  %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Collection"%>
<%@ page import="com.sore.model.*"%>
<%@ page import="com.mysql.jdbc.Connection"%>
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
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 3px solid black;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}

      </style>
    <meta charset="UTF-8">
    <title>Purchase Orders</title>    
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

    <div>
    <h2 class=login-footer>
      	<%
      	try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/retail1", "root", "root");
      		PreparedStatement pst = conn.prepareStatement("select p.po_id,p.order_id,p.supplier_id,p.warehouse_id,p.delivery_date,p1.quantity_ordered,g.name,g.description,p.po_status from retail1.purchase_order p inner join retail1.purchase_order_item p1 on p.po_id=p1.po_id inner join retail1.global_item g on p1.item_id=g.item_id");
	      		//System.out.println(option[0]);
	      	ResultSet rs = pst.executeQuery();
  	%>	
  	
  	<strong>Warehouse Items:</strong>
  	<div align="left">
  	<table>
  	<tr>
    <th><strong>Purchase ID</strong></th>
    <th><strong>Order ID</strong></th>
    <th><strong>Supplier ID</strong></th>
    <th><strong>Warehouse ID</strong></th>
    <th><strong>Delivery Date</strong></th>
    <th><strong>Quantity Ordered</strong></th>
    <th><strong>Item Name</strong></th>
    <th><strong>Item Description</strong></th>
    <th><strong>PO Status</strong></th> 
    </tr>
  	<%while(rs.next()) { %>
  	<tr>
  	<td><%=rs.getInt(1)%></td>
  	<td><%=rs.getInt(2)%></td>
  	<td><%=rs.getInt(3)%></td>
  	<td><%=rs.getInt(4)%></td>
  	<td><%=rs.getString(5)%></td>
  	<td><%=rs.getInt(6)%></td>
  	<td><%=rs.getString(7)%></td>
  	<td><%=rs.getString(8)%></td>
  	<td><%=rs.getString(9)%></td>
  	</tr>
  	<%} %>   
  	</table>
  	</div>
<%} 
catch(Exception e){e.printStackTrace();}%>
</h2>
</div>
</div>
</div>
</body>
</html>