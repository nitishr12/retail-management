<%-- 
    Document   : supplier
    Created on : Nov 19, 2016, 3:31:35 PM
    Author     : Raka Choudhury
--%>

<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
       
    <script type="text/javascript">
    function addItem(item_id){
    var quantity = document.getElementById('quant'+item_id).value;
    var po_id = document.getElementById('po_id'+item_id).value;
    var order_id = document.getElementById('order_id'+item_id).value;
    var item_id = document.getElementById('item_id'+item_id).value;
    var name = document.getElementById('name'+item_id).value;
    var po_status=document.getElementById('po_status'+item_id).value;
    alert(item_id+" and "+quantity+" item_id "+item_id);
    $.post("ViewCarton",
    {
        action:"add_item",
        item_id: item_id,
        quantity:quantity,
        name:name,
        po_id:po_id,
        po_status:po_status,
        order_id:order_id
    },
    function(data, status){
        alert("Data: " + data + "\nStatus: " + status);
    });
    }
    
    function sendOrder(){
    alert("Alert generated");
    }
</script>
<style>
    .button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
}

.button1:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}

table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid black;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
</head>
<body>
    <div align="right">
        <a href="index.html"><h2>Logout</h2></a>
    </div>
    
    <div align="center">
    
    <div align="center">
   <button type="submit" class="button button1" onclick="sendOrder()">Alert generate</button>     
<table>
    <h1>Received Purchase Orders</h1>
  <tr>
    <th>PO ID</th>
    <th>Order ID</th>
    <th>Item ID</th>
    <th>Name</th>
    <th>Quantity Ordered</th>
    <th>PO Status</th>
    <th>Quantity Sent</th>
    <th></th>
  </tr>
  <c:forEach items="${item_list}" var="item">
      <tr>
    <td>${item.po_id}</td>
    <td>${item.order_id}</td>
    <td>${item.item_id}</td>
    <td>${item.name}</td>
    <td>${item.quantity_ordered}</td>
    <td>${item.po_status}</td>
    <td>
        <input type="text" name="btnQuantity" id="quant${item.item_id}"/>
        <input type="hidden" name="btnQuantity" value="${item.po_id}" id="po_id${item.item_id}"/>
        <input type="hidden" name="btnQuantity" value="${item.order_id}" id="order_id${item.item_id}"/>
        <input type="hidden" name="btnQuantity" value="${item.name}" id="name${item.item_id}"/>
        <input type="hidden" name="btnQuantity" value="${item.po_status}" id="po_status${item.item_id}"/>
    </td>
    <td>
        <button type="button" onclick="addItem(${item.item_id})">Add to Carton</button>
    </td>
  </tr>
  </c:forEach>
  
</table>
    </div>
    <br/>
    <button type="submit" class="button button1" onclick="sendOrder()">View Carton</button>
    
</body>
</html>

