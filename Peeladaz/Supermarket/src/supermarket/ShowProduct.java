/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package supermarket;

import java.awt.Image;
import java.awt.event.ItemEvent;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.sql.*;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author ranco
 */
public class ShowProduct extends javax.swing.JFrame {

    /**
     * Creates new form ShowProduct
     * @param ID
     * @throws java.io.IOException
     */
    public ShowProduct(String ID) throws IOException {
        this.id = ID;
        initComponents();
        populateJTable(new QueryForProduct().BindTable(user, pass));
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonGroup1 = new javax.swing.ButtonGroup();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        ProductTable = new javax.swing.JTable();
        nameVar = new javax.swing.JTextField();
        fillterBox = new javax.swing.JComboBox<>();
        jLabel6 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        priceVar = new javax.swing.JTextField();
        jLabel8 = new javax.swing.JLabel();
        AddBtn = new javax.swing.JButton();
        jScrollPane4 = new javax.swing.JScrollPane();
        ProductTable2 = new javax.swing.JTable();
        billVar = new javax.swing.JLabel();
        paymentVar = new javax.swing.JLabel();
        allPaymentVar = new javax.swing.JLabel();
        clearBillBtn = new javax.swing.JButton();
        confirmBtn = new javax.swing.JButton();
        quanVar2 = new javax.swing.JSpinner();
        cardVar = new javax.swing.JRadioButton();
        cashVar = new javax.swing.JRadioButton();
        idVar = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setResizable(false);

        jPanel1.setBackground(new java.awt.Color(153, 153, 255));
        jPanel1.setPreferredSize(new java.awt.Dimension(1165, 720));

        jPanel2.setBackground(new java.awt.Color(255, 255, 255));
        jPanel2.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        ProductTable.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        ProductTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Id", "Name", "Unit", "Price", "NoInventory", "Image"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        ProductTable.setGridColor(new java.awt.Color(153, 153, 255));
        ProductTable.setShowGrid(false);
        ProductTable.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                ProductTableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(ProductTable);
        if (ProductTable.getColumnModel().getColumnCount() > 0) {
            ProductTable.getColumnModel().getColumn(0).setResizable(false);
            ProductTable.getColumnModel().getColumn(0).setPreferredWidth(0);
        }

        nameVar.setEditable(false);
        nameVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        nameVar.setForeground(new java.awt.Color(153, 153, 255));

        fillterBox.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        fillterBox.setForeground(new java.awt.Color(153, 153, 255));
        fillterBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "All", "Lower 50k", "50k to 500k", "Higher 500k", "Stationery", "Electric Appliances", "Kitchen Utensils & Appliances", "Phone Accessories", "Detergents", "Beauty & Personal Care", "Food", "Beverage" }));
        fillterBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                fillterBoxItemStateChanged(evt);
            }
        });

        jLabel6.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(153, 153, 255));
        jLabel6.setText("Fillter by:");

        jLabel2.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(153, 153, 255));
        jLabel2.setText("Name:");

        jLabel7.setFont(new java.awt.Font("Arial", 1, 20)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(153, 153, 255));
        jLabel7.setText("Shopping Cart");

        jLabel3.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(153, 153, 255));
        jLabel3.setText("Price:");

        priceVar.setEditable(false);
        priceVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        priceVar.setForeground(new java.awt.Color(153, 153, 255));

        jLabel8.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel8.setForeground(new java.awt.Color(153, 153, 255));
        jLabel8.setText("Quantity:");

        AddBtn.setBackground(new java.awt.Color(204, 204, 255));
        AddBtn.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        AddBtn.setText("Add");
        AddBtn.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
        AddBtn.setBorderPainted(false);
        AddBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                AddBtnMouseClicked(evt);
            }
        });

        ProductTable2.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        ProductTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "PRODUCT", "PRICE", "QUANTITY", "TOTAL"
            }
        ));
        jScrollPane4.setViewportView(ProductTable2);

        billVar.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        billVar.setForeground(new java.awt.Color(153, 153, 255));
        billVar.setText("Your bill: ");

        paymentVar.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        paymentVar.setForeground(new java.awt.Color(153, 153, 255));
        paymentVar.setText("Shipping fee: ");

        allPaymentVar.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        allPaymentVar.setForeground(new java.awt.Color(153, 153, 255));
        allPaymentVar.setText("Total:");

        clearBillBtn.setText("Refresh cart");
        clearBillBtn.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED, new java.awt.Color(204, 204, 204), new java.awt.Color(204, 204, 204), new java.awt.Color(204, 204, 204), new java.awt.Color(204, 204, 204)));
        clearBillBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                clearBillBtnMouseClicked(evt);
            }
        });

        confirmBtn.setBackground(new java.awt.Color(0, 204, 51));
        confirmBtn.setText("Confirm");
        confirmBtn.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
        confirmBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                confirmBtnMouseClicked(evt);
            }
        });

        quanVar2.setModel(new javax.swing.SpinnerNumberModel());

        buttonGroup1.add(cardVar);
        cardVar.setFont(new java.awt.Font("Arial", 0, 14)); // NOI18N
        cardVar.setText("By Card");
        cardVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cardVarActionPerformed(evt);
            }
        });

        buttonGroup1.add(cashVar);
        cashVar.setFont(new java.awt.Font("Arial", 0, 14)); // NOI18N
        cashVar.setSelected(true);
        cashVar.setText("By cash");
        cashVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cashVarActionPerformed(evt);
            }
        });

        idVar.setVisible(false);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(75, 75, 75)
                .addComponent(jScrollPane4, javax.swing.GroupLayout.PREFERRED_SIZE, 530, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 61, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(allPaymentVar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(paymentVar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(billVar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addContainerGap())
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(confirmBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 167, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addComponent(cashVar)
                                .addGap(90, 90, 90)
                                .addComponent(cardVar)))
                        .addGap(96, 96, 96))))
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(261, 261, 261)
                        .addComponent(jLabel7)
                        .addGap(18, 18, 18)
                        .addComponent(clearBillBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(20, 20, 20)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 640, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(72, 72, 72)
                                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(jLabel6)
                                        .addGap(109, 109, 109))
                                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addGroup(jPanel2Layout.createSequentialGroup()
                                            .addComponent(jLabel2)
                                            .addGap(31, 31, 31)
                                            .addComponent(idVar, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addComponent(nameVar, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(jLabel3)
                                        .addComponent(priceVar, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(jLabel8)
                                        .addComponent(quanVar2, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE))))
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(99, 99, 99)
                                .addComponent(AddBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addComponent(jLabel6)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(18, 18, 18)
                                .addComponent(jLabel2))
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(6, 6, 6)
                                .addComponent(idVar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(nameVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(priceVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jLabel8)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(quanVar2, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(AddBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 389, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel7)
                            .addComponent(clearBillBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 24, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jScrollPane4, javax.swing.GroupLayout.PREFERRED_SIZE, 151, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(67, 67, 67))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(44, 44, 44)
                        .addComponent(billVar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(paymentVar, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(allPaymentVar, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(cashVar)
                            .addComponent(cardVar))
                        .addGap(18, 18, 18)
                        .addComponent(confirmBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE))))
        );

        jLabel4.setFont(new java.awt.Font("Arial", 1, 20)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setText("PEELADAZ");

        jLabel9.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        jLabel9.setForeground(new java.awt.Color(255, 255, 255));
        jLabel9.setText("X");
        jLabel9.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel9MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap(140, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(20, 20, 20))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel9)
                        .addContainerGap())))
            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel1Layout.createSequentialGroup()
                    .addGap(487, 487, 487)
                    .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel9)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, 665, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(20, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel1Layout.createSequentialGroup()
                    .addGap(280, 280, 280)
                    .addComponent(jLabel4)
                    .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, 719, Short.MAX_VALUE)
                .addGap(0, 1, Short.MAX_VALUE))
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void cashVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cashVarActionPerformed
        // TODO add your handling code here:
        if (cashVar.isSelected() == true){
            cashAndCard = true;
        }
    }//GEN-LAST:event_cashVarActionPerformed
    private String getReceiptID() throws SQLException{
        Con = JDBCConnection.getConnection(user, pass);
        Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
        CallableStatement cstmt = Con.prepareCall("{? = call AUTO_ReceiptID()}");
        cstmt.registerOutParameter(1, Types.CHAR);
        cstmt.execute();
        return cstmt.getString(1);
    }
    private void confirmBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_confirmBtnMouseClicked

        try{                                        
            String CustomerID = this.id;
            Receipt receipt = new Receipt(getReceiptID(), CustomerID, feeDelivery, cashAndCard, ListProd);
            Con = JDBCConnection.getConnection(user, pass);
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            String sql0 = "INSERT INTO RECEIPT (ReceiptID,CustomerID,OrderDate,DeliveryCharges,PaymentMethod) VALUES(?, ?, GETDATE(), ?, ?)";
            String sql1 = "INSERT INTO RECEIPT_DETAIL (ReceiptID,ProductID,Quantity,Price) VALUES(?,?,?,?)";
            PreparedStatement ps0 = null;
            PreparedStatement ps1 = null;
            try{
                Con.setAutoCommit(false);
                ps0 = Con.prepareStatement(sql0);
                ps0.setString(1,receipt.getReceiptID());
                ps0.setString(2,receipt.getCustomerID());
                ps0.setInt(3,receipt.getDeliveryCharges());
                ps0.setBoolean(4, cashAndCard);
                ps0.execute();
                
                ps1 = Con.prepareStatement(sql1);
                for(Receipt_Detail i : receipt.getList()){
                    System.out.println(i);
                    ps1.setString(1,receipt.getReceiptID());
                    ps1.setString(2,i.getProdId());
                    ps1.setInt(3,i.getQty());
                    ps1.setInt(4,i.getPrice());
                    ps1.execute();
                }                             
                Con.commit();
                JOptionPane.showMessageDialog(this, "Purchase successfully !!!");  
                clearBillBtn.doClick();
            }catch(Exception e){
                e.printStackTrace();
                JOptionPane.showMessageDialog(this, "Purchase failed !!!");  
                Con.rollback();
            }finally{
                    Con.setAutoCommit(true);
                    Con.close();                    
            }
        }catch(SQLException ex){
            Logger.getLogger(ShowProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_confirmBtnMouseClicked

    private void clearBillBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_clearBillBtnMouseClicked
        // TODO add your handling code here:
        ProdTotal = 0;
        smallTotal = 0;
        bigTotal = 0;
        numberOfProduct = 0;

        billVar.setText("Your bill: " + smallTotal + " vnđ");
        paymentVar.setText("Your fee: " + 0 + " vnđ");
        allPaymentVar.setText("All your payment is:" + bigTotal + " vnđ");

        String[]columnName = {"PRODUCT","PRICE","QUANTITY","TOTAL"};
        DefaultTableModel model = (DefaultTableModel)ProductTable2.getModel();
        model.setRowCount(0);
        ProductTable2.getColumnModel().getColumn(0).setPreferredWidth(65);
        ProductTable2.getColumnModel().getColumn(1).setPreferredWidth(10);
        ProductTable2.getColumnModel().getColumn(2).setPreferredWidth(10);
        ProductTable2.getColumnModel().getColumn(3).setPreferredWidth(10);
        ListProd.clear();
    }//GEN-LAST:event_clearBillBtnMouseClicked

    private void AddBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_AddBtnMouseClicked
        // TODO add your handling code here:
        int Uprice = Integer.parseInt(priceVar.getText());        
        if(nameVar.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "You're not chossing product !!!");
        }else if((Integer)quanVar2.getValue() <= 0 ){
            JOptionPane.showMessageDialog(this, "Please take one or more product !!!");
        } else {
            numberOfProduct++;
            ProdTotal = Uprice * (Integer)quanVar2.getValue();
            smallTotal = ProdTotal + smallTotal;
            bigTotal = smallTotal + (smallTotal / 100 )* 10;

            billVar.setText("Your bill: " + smallTotal + " vnđ");
            if ((smallTotal / 100 )* 10 < 12000){
                feeDelivery = 12000;
                paymentVar.setText("Shipping fee: 12000 vnđ");
            } else if((smallTotal / 100 )* 10 > 47000){
                feeDelivery = 47000;
                paymentVar.setText("Shipping fee: 47000 vnđ");
            }else{
                paymentVar.setText("Shipping fee: " + (smallTotal / 100 )* 10 + " vnđ");
                feeDelivery = (smallTotal / 100 )* 10;
            }
            //        paymentVar.setText("Your fee: " + (smallTotal / 100 )* 7 + " vnđ");
            allPaymentVar.setText("Total: " + bigTotal + " vnđ");

            //        Object[] rows = new Object[5];
            String[]columnName = {"PRODUCT","PRICE","QUANTITY","TOTAL"};
            DefaultTableModel model = (DefaultTableModel)ProductTable2.getModel();
            //        model.setColumnIdentifiers(columnName);
            ProductTable2.getColumnModel().getColumn(0).setPreferredWidth(65);
            ProductTable2.getColumnModel().getColumn(1).setPreferredWidth(10);
            ProductTable2.getColumnModel().getColumn(2).setPreferredWidth(10);
            ProductTable2.getColumnModel().getColumn(3).setPreferredWidth(10);

            model.addRow(new Object[]{nameVar.getText(), Uprice,quanVar2.getValue(),ProdTotal});
            ListProd.add(new Receipt_Detail(idVar.getText(),nameVar.getText(),(int)quanVar2.getValue(),Uprice));
        }
    }//GEN-LAST:event_AddBtnMouseClicked

    private void ProductTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_ProductTableMouseClicked
        // TODO add your handling code here:
        int Myindex = ProductTable.getSelectedRow();
        idVar.setText(ProductTable.getValueAt(Myindex, 5).toString());
        nameVar.setText(ProductTable.getValueAt(Myindex, 0).toString());
        priceVar.setText(ProductTable.getValueAt(Myindex, 2).toString());
    }//GEN-LAST:event_ProductTableMouseClicked

    private void jLabel9MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel9MouseClicked
        // TODO add your handling code here:
        System.exit(0);
    }//GEN-LAST:event_jLabel9MouseClicked
    private String getTypee(String type){
        String res = null;
        switch (type) {
            case "Stationery":
                res = "01";
                break;
            case "Electric Appliances":
                res = "02";
                break;
            case "Kitchen Utensils & Appliances":
                res = "03";
                break;
            case "Phone Accessories":
                res = "04";
                break;
            case "Detergents":
                res = "05";
                break;
            case "Beauty & Personal Care":
                res = "06";
                break;
            case "Food":
                res = "07";
                break;
            case "Beverage":
                res = "08";
                break;
            default:
                break;
        }
        return res;
    }
    private void fillterBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_fillterBoxItemStateChanged
        try {
            // TODO add your handling code here:
            Con = JDBCConnection.getConnection(user, pass);
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            PreparedStatement Ps = null;
            String item = (String) evt.getItem();
            ArrayList<ListOfProducts> list = new ArrayList<ListOfProducts>();
            String sql1 = "EXEC pr_getProductByType ?";
            String sql0 = "SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT";
            if (evt.getStateChange() == ItemEvent.SELECTED) {
                System.out.println(item);
                try{
                    switch (item) {
                        case "ALL":
                            Ps = Con.prepareStatement(sql0);
                            break;
                        case "Lower 50k":
                            Ps = Con.prepareStatement("select ProductID, ProductName, Unit, Price, NoInventory, Img from dbo.PRODUCT WHERE Price < 50000 Order by Price ASC");
                            break;
                        case "50k to 500k":
                            Ps = Con.prepareStatement("select ProductID, ProductName, Unit, Price, NoInventory, Img from dbo.PRODUCT WHERE Price >= 50000 and Price <= 500000 Order by Price ASC");
                            break;
                        case "Higher 500k":
                            Ps = Con.prepareStatement("select ProductID, ProductName, Unit, Price, NoInventory, Img from dbo.PRODUCT WHERE Price > 500000 Order by Price ASC");
                            break;
                        default:
                            Ps = Con.prepareStatement(sql1);
                            Ps.setString(1, getTypee(item));
                            break;
                    }
                    Rs = Ps.executeQuery();
                    while(Rs.next()){
                        ListOfProducts p = new ListOfProducts(
                                Rs.getString("ProductID"),
                                Rs.getString("ProductName"),
                                Rs.getString("Unit"),
                                Rs.getInt("Price"),
                                Rs.getInt("NoInventory"),
                                Rs.getString("Img")
                        );
                        list.add(p);
                    }
                    populateJTable(list);
                } catch (IOException | SQLException e){
                    e.printStackTrace();
                }
            }
        } catch (SQLException ex) {         
            Logger.getLogger(ShowProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_fillterBoxItemStateChanged

    private void cardVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cardVarActionPerformed

    }//GEN-LAST:event_cardVarActionPerformed

    private void clearTable(){
        ((DefaultTableModel)ProductTable.getModel()).setNumRows(0);
    }      
    
    public void populateJTable (ArrayList<ListOfProducts> list) throws MalformedURLException, IOException {
        String[]columnName = {"Name","Unit","Price","No Inventory","Image","ID"};
        Object[][] rows = new Object [list.size()][6];
        for (int i = 0; i < list.size (); i++) {
            rows[i][0] = list.get(i).getProductName();
            rows[i][1] = list.get(i).getUnit();
            rows[i][2] = list.get(i).getPrice();
            rows[i][3] = list.get(i).getNoProd();
            rows[i][5] = list.get(i).getProductID();
            if(list.get(i).getImg() != null){
                URL url = new URL(list.get(i).getImg());
                Image image = ImageIO.read(url);
                Image imagee = image.getScaledInstance(120, 120,  java.awt.Image.SCALE_SMOOTH);
                ImageIcon picture = new ImageIcon(imagee);   
                rows[i][4] = picture;
            }
            else{
                rows[i][4] = null;
            }
        }
        
        TheModelProduct model = new TheModelProduct(rows, columnName);
        ProductTable.setModel(model);
        ProductTable.setRowHeight(120);
        
        DefaultTableCellRenderer rendar = new DefaultTableCellRenderer();

        ProductTable.getColumnModel().getColumn(1).setCellRenderer(rendar); 
        ProductTable.getColumnModel().getColumn(2).setCellRenderer(rendar); 
        ProductTable.getColumnModel().getColumn(3).setCellRenderer(rendar); 
        
        ProductTable.getColumnModel().getColumn(5).setWidth(0);
        ProductTable.getColumnModel().getColumn(5).setMinWidth(0);
        ProductTable.getColumnModel().getColumn(5).setMaxWidth(0); 
        ProductTable.getColumnModel().getColumn(0).setPreferredWidth(75);
        ProductTable.getColumnModel().getColumn(1).setPreferredWidth(25);
        ProductTable.getColumnModel().getColumn(2).setPreferredWidth(30);
        ProductTable.getColumnModel().getColumn(3).setPreferredWidth(30);
        ProductTable.getColumnModel().getColumn(4).setPreferredWidth(120);
    }
    
    /**
     * @param args the command line arguments
     */
//    public static void main(String args[]) {
//        /* Set the Nimbus look and feel */
//        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
//        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
//         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
//         */
//        try {
//            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
//                if ("Nimbus".equals(info.getName())) {
//                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
//                    break;
//                }
//            }
//        } catch (ClassNotFoundException ex) {
//            java.util.logging.Logger.getLogger(ShowProduct.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (InstantiationException ex) {
//            java.util.logging.Logger.getLogger(ShowProduct.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (IllegalAccessException ex) {
//            java.util.logging.Logger.getLogger(ShowProduct.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
//            java.util.logging.Logger.getLogger(ShowProduct.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        }
//        //</editor-fold>
//
//        /* Create and display the form */
//        java.awt.EventQueue.invokeLater(new Runnable() {
//            @Override
//            public void run() {
//                try {
//                    new ShowProduct().setVisible(true);
//                } catch (IOException ex) {
//                    Logger.getLogger(ShowProduct.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        });   
//    }
    private Connection Con = null;
    private ResultSet Rs = null;
    private Statement St = null;
    private String user = "KH", pass = "KH";
    private int ProdTotal = 0;
    private int bigTotal = 0;
    private int smallTotal = 0;
    private int numberOfProduct = 0;
    private boolean cashAndCard = true;
    private int feeDelivery = 0;
    private String id;
    private ArrayList<Receipt_Detail> ListProd = new ArrayList<Receipt_Detail>();
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton AddBtn;
    private javax.swing.JTable ProductTable;
    private javax.swing.JTable ProductTable2;
    private javax.swing.JLabel allPaymentVar;
    private javax.swing.JLabel billVar;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.JRadioButton cardVar;
    private javax.swing.JRadioButton cashVar;
    private javax.swing.JButton clearBillBtn;
    private javax.swing.JButton confirmBtn;
    private javax.swing.JComboBox<String> fillterBox;
    private javax.swing.JTextField idVar;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane4;
    private javax.swing.JTextField nameVar;
    private javax.swing.JLabel paymentVar;
    private javax.swing.JTextField priceVar;
    private javax.swing.JSpinner quanVar2;
    // End of variables declaration//GEN-END:variables
}
