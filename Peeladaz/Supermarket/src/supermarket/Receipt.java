/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package supermarket;

import java.util.ArrayList;

/**
 *
 * @author ranco
 */
public class Receipt {
    String ReceiptID;
    String CustomerID;
    int DeliveryCharges;
    boolean PaymentMethod;
    ArrayList<Receipt_Detail> list;

    public Receipt(String ReceiptID, String CustomerID, int DeliveryCharges, boolean PaymentMethod, ArrayList<Receipt_Detail> list) {
        this.ReceiptID = ReceiptID;
        this.CustomerID = CustomerID;
        this.DeliveryCharges = DeliveryCharges;
        this.PaymentMethod = PaymentMethod;
        this.list = list;
    }

    public String getReceiptID() {
        return ReceiptID;
    }

    public void setReceiptID(String ReceiptID) {
        this.ReceiptID = ReceiptID;
    }

    public String getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(String CustomerID) {
        this.CustomerID = CustomerID;
    }

    public int getDeliveryCharges() {
        return DeliveryCharges;
    }

    public void setDeliveryCharges(int DeliveryCharges) {
        this.DeliveryCharges = DeliveryCharges;
    }

    public boolean getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(boolean PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public ArrayList<Receipt_Detail> getList() {
        return list;
    }

    public void setList(ArrayList<Receipt_Detail> list) {
        this.list = list;
    }
    
}
