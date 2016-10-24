package com.sore.model;

public class Order {
	public int orderID;
	public int quantityOrdered;
	public String deliveryDate;
	public String order;
	public Order(int orderID, int quantityOrdered, String deliveryDate, String order){
		this.orderID=orderID;
		this.quantityOrdered=quantityOrdered;
		this.deliveryDate=deliveryDate;
		this.order=order;
	}
}
