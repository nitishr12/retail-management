<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
    <%@ page import= "java.awt.List"%>
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Update Orders</title>    
  </head>
  <body>
  <%Order obj=null;
  int item_id=0;%>
 <div class="container">
  <div class="warehouse">
  	<%try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/retail1", "root", "root");
      		String option[]=request.getParameterValues("id");
      		PreparedStatement pst = conn.prepareStatement("select s.order_id,s1.quantity_ordered,s.delivery_date,s.status,s1.item_id from retail1.store_order s inner join retail1.store_order_item s1 on s.order_id=s1.order_id where s.order_id=?");
      		pst.setInt(1, Integer.parseInt(option[0]));
      		//System.out.println(option[0]);
      		ResultSet rs = pst.executeQuery();
      		rs.next();
      		obj=new Order(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getString(4));
      		item_id=rs.getInt(5);
      		//System.out.println(rs.getInt(1)+" "+rs.getInt(2)+" "+rs.getString(3)+" "+rs.getString(4));
  	}
  	catch(Exception e){
		e.printStackTrace();
	}
      %> 
    <form action="executeQuery" method="post">
    <table>
    <tr>
    <th><strong>Order Number</strong></th>
    <th><strong>Quantity Required</strong></th>
    <th><strong>DeliveryDate</strong></th>
    <th><strong>Status</strong></th></tr>
    <tr>
    <td><input type="text" name="order" value=<%=obj.orderID%>></td>
  	<td><input type="text" name="quantity" value=<%=obj.quantityOrdered%>></td>
  	<td><%=obj.deliveryDate%></td>
  	<td><%=obj.order%></td>
    </tr>     
    </table>
    <input type="hidden" name="item_id" value=<%=item_id %>>
    <button type="submit" class="btn btn--right">OK</button>
    </form>
   </div>
  </div>  
  </body>
</html>
