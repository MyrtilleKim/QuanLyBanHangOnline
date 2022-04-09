/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package supermarket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.JOptionPane;
import net.proteanit.sql.DbUtils;

/**
 *
 * @author ranco
 */
public class Take_Delivery extends javax.swing.JFrame {

    /**
     * Creates new form Take_Delivery
     */
    public Take_Delivery() {
        initComponents();
        SelectReceipt();
        SelectDelivery();
    }
    
    Connection Con = null;
    PreparedStatement Ps = null;
    Statement St = null;
    ResultSet Rs = null;

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
        jScrollPane1 = new javax.swing.JScrollPane();
        receiptTable = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        deliveryTable = new javax.swing.JTable();
        jLabel6 = new javax.swing.JLabel();
        fillterBox = new javax.swing.JComboBox<>();
        RefreshBtn = new javax.swing.JButton();
        confirmBtn = new javax.swing.JButton();
        jLabel9 = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setUndecorated(true);

        jPanel1.setBackground(new java.awt.Color(153, 153, 255));

        jPanel2.setBackground(new java.awt.Color(255, 255, 255));

        receiptTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null}
            },
            new String [] {
                "Receipt ID", "Customer ", "Address", "Order Date", "Delivery Charges"
            }
        ));
        jScrollPane1.setViewportView(receiptTable);

        deliveryTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null}
            },
            new String [] {
                "Delivery ID", "Receipt ID", "Shipper ID", "Delivery Date", "Delivery Charge"
            }
        ));
        jScrollPane2.setViewportView(deliveryTable);

        jLabel6.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(153, 153, 255));
        jLabel6.setText("Fillter by:");

        fillterBox.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        fillterBox.setForeground(new java.awt.Color(153, 153, 255));
        fillterBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "District 1", "District 2", "District 3", "District 4", "District 5", "District 6", "District 7", "District 8", "District 9", "District 10", "District 11", "District 12", "District Binh Tan", "District Binh Thanh", "District Go Vap", "District Phu Nhuan", "District Tan Binh", "District Tan Phu" }));
        fillterBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                fillterBoxActionPerformed(evt);
            }
        });

        RefreshBtn.setText("Refresh");
        RefreshBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                RefreshBtnMouseClicked(evt);
            }
        });
        RefreshBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                RefreshBtnActionPerformed(evt);
            }
        });

        confirmBtn.setBackground(new java.awt.Color(0, 255, 51));
        confirmBtn.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        confirmBtn.setText("Confirm Delivery");
        confirmBtn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                confirmBtnMouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(0, 81, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 752, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 747, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(67, 67, 67))
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(206, 206, 206)
                .addComponent(jLabel6)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(RefreshBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 82, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(confirmBtn)
                .addGap(384, 384, 384))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(63, 63, 63)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 110, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(41, 41, 41)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(RefreshBtn))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 110, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 45, Short.MAX_VALUE)
                .addComponent(confirmBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        jLabel9.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        jLabel9.setForeground(new java.awt.Color(255, 255, 255));
        jLabel9.setText("X");
        jLabel9.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel9MouseClicked(evt);
            }
        });

        jLabel1.setBackground(new java.awt.Color(255, 255, 255));
        jLabel1.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setText("Take Delivery");

        jLabel5.setFont(new java.awt.Font("Arial", 1, 20)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(255, 255, 255));
        jLabel5.setText("PEELADAZ");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap(161, Short.MAX_VALUE)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(24, 24, 24)
                .addComponent(jLabel5)
                .addGap(406, 406, 406)
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 284, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel9)
                .addGap(23, 23, 23))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel5)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel9))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(26, 26, 26))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jLabel9MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel9MouseClicked
        // TODO add your handling code here:
        System.exit(0);
    }//GEN-LAST:event_jLabel9MouseClicked

    private void fillterBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_fillterBoxActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_fillterBoxActionPerformed

    private void RefreshBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_RefreshBtnMouseClicked
        // TODO add your handling code here:
//        String typeTemp = null;
//        try{
//            Con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=qlbh_onl;encrypt=true;trustServerCertificate=true;", "kubi", "28112001");
//            St = (Statement) Con.createStatement();
//
//            if (fillterBox.getSelectedItem() == "Stationery"){
//                typeTemp = "01";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            } else if (fillterBox.getSelectedItem() == "Electric Appliances"){
//                typeTemp = "02";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            } else if (fillterBox.getSelectedItem() == "Kitchen Utensils & Appliances"){
//                typeTemp = "03";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            } else if (fillterBox.getSelectedItem() == "Phone Accessories"){
//                typeTemp = "04";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            } else if (fillterBox.getSelectedItem() == "Detergents"){
//                typeTemp = "05";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            } else if (fillterBox.getSelectedItem() == "Beauty & Personal Care"){
//                typeTemp = "05";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            }else if (fillterBox.getSelectedItem() == "Food"){
//                typeTemp = "07";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            }else if (fillterBox.getSelectedItem() == "Beverage"){
//                typeTemp = "08";
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            }else if (fillterBox.getSelectedItem() == "Lower 50k"){
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE Price <" + 50000 + "Order by Price ASC");
//            }else if (fillterBox.getSelectedItem() == "50k to 500k"){
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE Price >=" + 50000 + " AND Price <="+ 500000 + "Order by Price ASC");
//            }else if (fillterBox.getSelectedItem() == "Higher 200k"){
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE Price >" + 200000 + "Order by Price ASC");
//            }else if (fillterBox.getSelectedItem() == "All"){
//                Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT Order by Price ASC");
//            }
//            //            Rs = St.executeQuery("select ProductName, NoInventory, Price from dbo.PRODUCT WHERE ProdTypeID =" + typeTemp);
//            BillTable.setModel(DbUtils.resultSetToTableModel(Rs));
//            BillTable.getColumnModel().getColumn(0).setPreferredWidth(150);
//            BillTable.setRowHeight(25);
//        } catch (Exception e){
//            e.printStackTrace();
//        }

    }//GEN-LAST:event_RefreshBtnMouseClicked

    private void RefreshBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_RefreshBtnActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_RefreshBtnActionPerformed

    private void confirmBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_confirmBtnMouseClicked
        // TODO add your handling code here:
        int input = JOptionPane.showConfirmDialog(null,"Do you want to reverse !!!", "Reverse", JOptionPane.YES_NO_OPTION);
        // 0=yes, 1=no
    }//GEN-LAST:event_confirmBtnMouseClicked
    
    public void SelectReceipt() {
        Con = JDBCConnection.getConnection("sa", "123456");
        String sql = "EXEC pr_getReceipt";
        try{
            Ps = Con.prepareStatement(sql);
            Rs = Ps.executeQuery();
            receiptTable.setModel(DbUtils.resultSetToTableModel(Rs));
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    
    public void SelectDelivery() {
        try{
            Con = JDBCConnection.getConnection("sa", "123456");
            St = (Statement) Con.createStatement();
            String shipper = "TX0001";
            Rs = St.executeQuery("select * from Delivery_Note where ShipperID = 'TX0001'");
//            add.setString(1, shipper);
//            add.execute();
            deliveryTable.setModel(DbUtils.resultSetToTableModel(Rs));
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
            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Take_Delivery().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton RefreshBtn;
    private javax.swing.JButton confirmBtn;
    private javax.swing.JTable deliveryTable;
    private javax.swing.JComboBox<String> fillterBox;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable receiptTable;
    // End of variables declaration//GEN-END:variables
}
