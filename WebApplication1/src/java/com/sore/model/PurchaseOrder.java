/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sore.model;

/**
 *
 * @author Raka Choudhury
 */
public class PurchaseOrder {
    int order_id,item_id,po_id,quantity_ordered;
    String name,po_status;
    
    public int getQuantity_ordered() {
        return quantity_ordered;
    }
    public void setQuantity_ordered(int quantity) {
        this.quantity_ordered = quantity;
    }
    public int getpo_id() {
        return po_id;
    }

    public void setpo_id(int po_id) {
        this.po_id = po_id;
    }
    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }
    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getpo_status() {
        return po_status;
    }

    public void setpo_status(String po_status) {
        this.po_status = po_status;
    }
}
