<%-- 
    Document   : manageStoreOrders
    Created on : Nov 4, 2016, 7:25:21 PM
    Author     : Sweet_Home
--%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
    function updateOrder(){
    var quantity = document.getElementById('quant'+item_id).value;
    var oid = document.getElementById('desc'+item_id).value;
    var iid = document.getElementById('price'+item_id).value;
  
    $.post("UpdateOrder",
    {
        action:"Update_Order",
        quant:quantity,
        oid:oid,
        iid:iid
    },
    function(data, status){
        alert("Data: " + data + "\nStatus: " + status);
    });
    }
    function deleteOrder(){
    var oid = document.getElementById('desc'+item_id).value;
    var iid = document.getElementById('price'+item_id).value;
  
    $.post("DeleteOrder",
    {
        action:"Delete_Order",
        oid:oid,
        iid:iid
    },
    function(data, status){
        alert("Data: " + data + "\nStatus: " + status);
    });
    }
    function updateOrder(){
        window.location.href="UpdateOrder?action=update";
    }
    function deleteOrder(){
        window.location.href="DeleteOrder?action=delete";
    }
    </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Store Active Orders Page</title>
    </head>
    <body align="center">
        <br/>
        <h1>Manage Orders</h1>
        <br/>
        Order id:<input type="number" min=1 name="btnoid"/>
        <br/><br/>
        Item_id: <input type="number" min=1 name="btniod"/>
        <br/><br/>
        Quantity needed: <input type="number" min=0 name="btnquant"/>
        <br/><br/></br>
        <button type="button" onclick="updateOrder()">Update Order</button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" onclick="deleteOrder()">Delete Active Order</button>
    </body>
</html>
