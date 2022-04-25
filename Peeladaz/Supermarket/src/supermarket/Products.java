/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package supermarket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import net.proteanit.sql.DbUtils;

/**
 *
 * @author ranco
 */
public class Products extends javax.swing.JFrame {

    /**
     * Creates new form Products
     */
    public Products() {
        initComponents();
        SelectProduct();
    }
    
    Connection Con = null;
    Statement St = null;
    PreparedStatement ps = null;
    ResultSet Rs = null;
    String user = "sa", pass = "123456";
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        branchIDVar = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        productIDVar = new javax.swing.JTextField();
        jLabel7 = new javax.swing.JLabel();
        unitVar = new javax.swing.JTextField();
        jLabel8 = new javax.swing.JLabel();
        quanVar = new javax.swing.JTextField();
        updateBtn = new javax.swing.JButton();
        addBtn = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();
        clearBtn = new javax.swing.JButton();
        jLabel11 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        productTable = new javax.swing.JTable();
        jLabel5 = new javax.swing.JLabel();
        nameVar1 = new javax.swing.JTextField();
        priceVar1 = new javax.swing.JTextField();
        jLabel10 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        typeVar = new javax.swing.JComboBox<>();
        jLabel9 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setUndecorated(true);

        jPanel1.setBackground(new java.awt.Color(153, 153, 255));

        jPanel2.setBackground(new java.awt.Color(255, 255, 255));

        jLabel3.setFont(new java.awt.Font("Arial", 1, 20)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(153, 153, 255));
        jLabel3.setText("MANAGE PRODUCTS");

        jLabel2.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(153, 153, 255));
        jLabel2.setText("Branch ID");

        branchIDVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        branchIDVar.setForeground(new java.awt.Color(153, 153, 255));
        branchIDVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                branchIDVarActionPerformed(evt);
            }
        });

        jLabel4.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(153, 153, 255));
        jLabel4.setText("Product ID");

        productIDVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        productIDVar.setForeground(new java.awt.Color(153, 153, 255));
        productIDVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productIDVarActionPerformed(evt);
            }
        });

        jLabel7.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(153, 153, 255));
        jLabel7.setText("Unit");

        unitVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        unitVar.setForeground(new java.awt.Color(153, 153, 255));
        unitVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                unitVarActionPerformed(evt);
            }
        });

        jLabel8.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel8.setForeground(new java.awt.Color(153, 153, 255));
        jLabel8.setText("Quantity");

        quanVar.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        quanVar.setForeground(new java.awt.Color(153, 153, 255));
        quanVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quanVarActionPerformed(evt);
            }
        });

        updateBtn.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        updateBtn.setForeground(new java.awt.Color(153, 153, 255));
        updateBtn.setText("Update");
        updateBtn.setBorder(new javax.swing.border.MatteBorder(null));
        updateBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                updateBtnMouseClicked(evt);
            }
        });
        updateBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                updateBtnActionPerformed(evt);
            }
        });

        addBtn.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        addBtn.setForeground(new java.awt.Color(153, 153, 255));
        addBtn.setText("Add");
        addBtn.setBorder(new javax.swing.border.MatteBorder(null));
        addBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                addBtnMouseClicked(evt);
            }
        });
        addBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addBtnActionPerformed(evt);
            }
        });

        jButton3.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jButton3.setForeground(new java.awt.Color(153, 153, 255));
        jButton3.setText("Delete");
        jButton3.setBorder(new javax.swing.border.MatteBorder(null));
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        clearBtn.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        clearBtn.setForeground(new java.awt.Color(153, 153, 255));
        clearBtn.setText("Clear");
        clearBtn.setBorder(new javax.swing.border.MatteBorder(null));
        clearBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                clearBtnMouseClicked(evt);
            }
        });
        clearBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                clearBtnActionPerformed(evt);
            }
        });

        jLabel11.setFont(new java.awt.Font("Arial", 1, 20)); // NOI18N
        jLabel11.setForeground(new java.awt.Color(153, 153, 255));
        jLabel11.setText("PRODUCTS LIST");

        productTable.setFont(new java.awt.Font("Arial", 0, 14)); // NOI18N
        productTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null}
            },
            new String [] {
                "BranchID", "ProductID", "Name", "Type", "Quantity", "Price", "Unit"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                true, false, false, false, false, true, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        productTable.setGridColor(new java.awt.Color(51, 51, 255));
        productTable.setRowHeight(25);
        productTable.setSelectionBackground(new java.awt.Color(153, 153, 255));
        productTable.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                productTableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(productTable);

        jLabel5.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(153, 153, 255));
        jLabel5.setText("Name");

        nameVar1.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        nameVar1.setForeground(new java.awt.Color(153, 153, 255));
        nameVar1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nameVar1ActionPerformed(evt);
            }
        });

        priceVar1.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        priceVar1.setForeground(new java.awt.Color(153, 153, 255));
        priceVar1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                priceVar1ActionPerformed(evt);
            }
        });

        jLabel10.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel10.setForeground(new java.awt.Color(153, 153, 255));
        jLabel10.setText("Price");

        jLabel6.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(153, 153, 255));
        jLabel6.setText("Type");

        typeVar.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        typeVar.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Stationery", "Electric Appliances", "Kitchen Utensils & Appliances", "Phone Accessories", "Detergents", "Beauty & Personal Care", "Food", "Beverage" }));
        typeVar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                typeVarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(66, 66, 66)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4)
                            .addComponent(jLabel2))
                        .addGap(48, 48, 48)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(productIDVar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(branchIDVar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel5)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(nameVar1, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 97, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addComponent(jLabel8)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                        .addGroup(jPanel2Layout.createSequentialGroup()
                            .addComponent(jLabel7)
                            .addGap(44, 44, 44)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel10)
                        .addGap(34, 34, 34)))
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(priceVar1, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(quanVar, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(unitVar, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(74, 74, 74))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1)
                .addContainerGap())
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(85, 85, 85)
                .addComponent(addBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 86, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(109, 109, 109)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel6)
                        .addGap(18, 18, 18)
                        .addComponent(typeVar, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(updateBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 86, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 86, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(87, 87, 87)
                .addComponent(clearBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 86, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(94, 94, 94))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(293, 293, 293))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel11, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(289, 289, 289))))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(branchIDVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel2))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(productIDVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel4)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(unitVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel7))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(quanVar, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel8))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(priceVar1, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(jLabel10))
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(nameVar1, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(jLabel5)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 29, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(typeVar, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(43, 43, 43)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(updateBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(addBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(clearBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel11)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 170, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18))
        );

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
                        .addComponent(jLabel9)
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(20, 20, 20))))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel9)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(20, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void clearBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_clearBtnActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_clearBtnActionPerformed

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton3ActionPerformed

    private void addBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addBtnActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_addBtnActionPerformed

    private void updateBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_updateBtnActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_updateBtnActionPerformed

    private void quanVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quanVarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_quanVarActionPerformed

    private void unitVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_unitVarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_unitVarActionPerformed

    private void productIDVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productIDVarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_productIDVarActionPerformed

    private void branchIDVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_branchIDVarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_branchIDVarActionPerformed

    private void updateBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_updateBtnMouseClicked
        // TODO add your handling code here:
        if(branchIDVar.getText().isEmpty() || productIDVar.getText().isEmpty() || unitVar.getText().isEmpty() || quanVar.getText().isEmpty() || nameVar1.getText().isEmpty() || priceVar1.getText().isEmpty()){
            JOptionPane.showMessageDialog(this, "Missing infomation !!!");
        } else {
            Con = JDBCConnection.getConnection(user, pass);
            String sql0 = "UPDATE PRODUCT SET ProductName = ?, Price=?, NoInventory = NoInventory + ? - (SELECT Quantity FROM STORAGE WHERE BranchID = ? AND ProductID = ?) WHERE ProductID = ?";
            String sql1 = "UPDATE STORAGE SET Quantity = ? WHERE BranchID = ? AND ProductID = ?";
            try{
                Con.setAutoCommit(false);
                String masp = productIDVar.getText(), macn = branchIDVar.getText();
                ps = Con.prepareStatement(sql0);
                ps.setString(1, nameVar1.getText());
                ps.setInt(2, Integer.valueOf(priceVar1.getText()));
                ps.setInt(3, Integer.valueOf(quanVar.getText()));
                ps.setString(4, macn);
                ps.setString(5, masp);
                ps.setString(6, masp);
                
                PreparedStatement ps1 = Con.prepareStatement(sql1);                                      
                ps1.setInt(1, Integer.valueOf(quanVar.getText()));
                ps1.setString(2, macn);
                ps1.setString(3, masp);
                
                ps.execute();
                ps1.execute();
                Con.commit();
                JOptionPane.showMessageDialog(this, "Information have been Updated !!!");            
            } catch (Exception e){
                e.printStackTrace();
                try {
                    Con.rollback();
                } catch (SQLException ex) {
                    Logger.getLogger(Products.class.getName()).log(Level.SEVERE, null, ex);
                }
            } finally{
                try {
                    Con.setAutoCommit(true);
                    Con.close();                    
                } catch (SQLException ex) {
                    Logger.getLogger(Products.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        SelectProduct();
    }//GEN-LAST:event_updateBtnMouseClicked
    private void productTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_productTableMouseClicked
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel)productTable.getModel();
        int Myindex = productTable.getSelectedRow();
        branchIDVar.setText(model.getValueAt(Myindex, 0).toString());
        productIDVar.setText(model.getValueAt(Myindex, 1).toString());
        nameVar1.setText(model.getValueAt(Myindex, 2).toString());
        quanVar.setText(model.getValueAt(Myindex, 4).toString());
        priceVar1.setText(model.getValueAt(Myindex, 5).toString());
        unitVar.setText(model.getValueAt(Myindex, 6).toString());
        

    }//GEN-LAST:event_productTableMouseClicked
    private void jLabel9MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel9MouseClicked
// TODO add your handling code here:
        System.exit(0);
    }//GEN-LAST:event_jLabel9MouseClicked

    private void clearBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_clearBtnMouseClicked
        // TODO add your handling code here:
        branchIDVar.setText("");
        productIDVar.setText("");
        nameVar1.setText("");
        quanVar.setText("");
        unitVar.setText("");
        quanVar.setText("");
        priceVar1.setText("");

    }//GEN-LAST:event_clearBtnMouseClicked

    private void nameVar1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nameVar1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_nameVar1ActionPerformed

    private void priceVar1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_priceVar1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_priceVar1ActionPerformed
    private String getUnit(){
        String res = null;
        String unit = typeVar.getSelectedItem().toString();
        switch (unit) {
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
    private void addBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_addBtnMouseClicked
        // TODO add your handling code here:
        if(branchIDVar.getText().isEmpty() || productIDVar.getText().isEmpty() || unitVar.getText().isEmpty() || quanVar.getText().isEmpty() || nameVar1.getText().isEmpty() || priceVar1.getText().isEmpty()){
            JOptionPane.showMessageDialog(this, "Missing infomation !!!");
        } else {
            String type = getUnit();
            System.out.println(type);
            Con = JDBCConnection.getConnection(user, pass);
            String sql = "EXEC pr_InsProd ?,?,?,?,?,?,?";
            try{               
                ps = Con.prepareStatement(sql);
                ps.setString(1, productIDVar.getText());
                ps.setString(2, nameVar1.getText());
                ps.setString(3, type);
                ps.setString(4, unitVar.getText());
                ps.setInt(5, Integer.valueOf(priceVar1.getText()));
                ps.setString(6, branchIDVar.getText());               
                ps.setInt(7, Integer.valueOf(quanVar.getText()));                            
                ps.execute();
                JOptionPane.showMessageDialog(this, "Product have just been added !!!");
            } catch (Exception e){
                e.printStackTrace();
            }
            SelectProduct();
        }
    }//GEN-LAST:event_addBtnMouseClicked

    private void typeVarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_typeVarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_typeVarActionPerformed

    public void SelectProduct() {
        Con = JDBCConnection.getConnection(user, pass);
        try{
            St = (Statement) Con.createStatement();
            Rs = St.executeQuery("EXEC pr_getProductByPartner 'DT0004'");
            productTable.setModel(DbUtils.resultSetToTableModel(Rs));
        } catch (Exception e){
            e.printStackTrace();
        }
    } 
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Products.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Products.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Products.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Products.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Products().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton addBtn;
    private javax.swing.JTextField branchIDVar;
    private javax.swing.JButton clearBtn;
    private javax.swing.JButton jButton3;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField nameVar1;
    private javax.swing.JTextField priceVar1;
    private javax.swing.JTextField productIDVar;
    private javax.swing.JTable productTable;
    private javax.swing.JTextField quanVar;
    private javax.swing.JComboBox<String> typeVar;
    private javax.swing.JTextField unitVar;
    private javax.swing.JButton updateBtn;
    // End of variables declaration//GEN-END:variables
}
