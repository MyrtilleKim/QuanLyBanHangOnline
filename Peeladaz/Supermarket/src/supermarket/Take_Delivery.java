/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package supermarket;

import java.awt.event.ItemEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.table.DefaultTableModel;
import net.proteanit.sql.DbUtils;

/**
 *
 * @author ranco
 */
public class Take_Delivery extends javax.swing.JFrame {

    /**
     * Creates new form Take_Delivery
     */
    public Take_Delivery(String ID) {
        id = ID;
        initComponents();
        SelectReceipt();
        SelectDelivery();
    }  
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
        receiptTable = new javax.swing.JTable(){
            public boolean editCellAt(int row, int column, java.util.EventObject e) {
                return false;}
        };
        jScrollPane2 = new javax.swing.JScrollPane();
        deliveryTable = new javax.swing.JTable(){
            public boolean editCellAt(int row, int column, java.util.EventObject e) {
                return false;
            }};
            jLabel6 = new javax.swing.JLabel();
            fillterBox = new javax.swing.JComboBox<>();
            confirmBtn = new javax.swing.JButton();
            jLabel2 = new javax.swing.JLabel();
            jLabel3 = new javax.swing.JLabel();
            returnBtn = new javax.swing.JButton();
            jLabel12 = new javax.swing.JLabel();

            setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

            jPanel1.setBackground(new java.awt.Color(153, 153, 255));
            jPanel1.setPreferredSize(new java.awt.Dimension(1165, 720));

            jPanel2.setBackground(new java.awt.Color(255, 255, 255));
            jPanel2.setPreferredSize(new java.awt.Dimension(1005, 667));

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
            ) {
                boolean[] canEdit = new boolean [] {
                    false, false, false, false, false
                };

                public boolean isCellEditable(int rowIndex, int columnIndex) {
                    return canEdit [columnIndex];
                }
            });
            receiptTable.addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    receiptTableMouseClicked(evt);
                }
            });
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
            ) {
                boolean[] canEdit = new boolean [] {
                    false, false, false, false, false
                };

                public boolean isCellEditable(int rowIndex, int columnIndex) {
                    return canEdit [columnIndex];
                }
            });
            deliveryTable.addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    deliveryTableMouseClicked(evt);
                }
            });
            jScrollPane2.setViewportView(deliveryTable);

            jLabel6.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
            jLabel6.setForeground(new java.awt.Color(153, 153, 255));
            jLabel6.setText("Fillter by:");

            fillterBox.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
            fillterBox.setForeground(new java.awt.Color(153, 153, 255));
            fillterBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] {"ALL", "District 1", "District 2", "District 3", "District 4", "District 5", "District 6", "District 7", "District 8", "District 9", "District 10", "District 11", "District 12", " Binh Tan District", "Binh Thanh District", "Go Vap District", "Phu Nhuan District", "Tan Binh District", "Tan Phu District"}));
            fillterBox.addItemListener(new java.awt.event.ItemListener() {
                public void itemStateChanged(java.awt.event.ItemEvent evt) {
                    fillterBoxItemStateChanged(evt);
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

            jLabel2.setBackground(new java.awt.Color(255, 255, 255));
            jLabel2.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
            jLabel2.setForeground(new java.awt.Color(153, 153, 255));
            jLabel2.setText("Delivery Notes");

            jLabel3.setBackground(new java.awt.Color(255, 255, 255));
            jLabel3.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
            jLabel3.setForeground(new java.awt.Color(153, 153, 255));
            jLabel3.setText("Notes can be recieved");

            returnBtn.setBackground(new java.awt.Color(255, 51, 51));
            returnBtn.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
            returnBtn.setText("Return Delivery");
            returnBtn.addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    returnBtnMouseClicked(evt);
                }
            });

            javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
            jPanel2.setLayout(jPanel2Layout);
            jPanel2Layout.setHorizontalGroup(
                jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                    .addGap(0, 0, Short.MAX_VALUE)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 840, Short.MAX_VALUE)
                                .addComponent(jScrollPane1)
                                .addGroup(jPanel2Layout.createSequentialGroup()
                                    .addComponent(jLabel6)
                                    .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                    .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, 170, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGap(71, 71, 71)))
                            .addGap(86, 86, 86))
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 284, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGap(359, 359, 359))))
                .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                    .addContainerGap(417, Short.MAX_VALUE)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 284, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGap(304, 304, 304))
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addComponent(confirmBtn)
                            .addGap(442, 442, 442))
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                            .addComponent(returnBtn)
                            .addGap(448, 448, 448))))
            );
            jPanel2Layout.setVerticalGroup(
                jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel2Layout.createSequentialGroup()
                    .addGap(23, 23, 23)
                    .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGap(18, 18, 18)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 132, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGap(18, 18, 18)
                    .addComponent(returnBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGap(61, 61, 61)
                    .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel6)
                        .addComponent(fillterBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGap(18, 18, 18)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 195, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGap(18, 18, 18)
                    .addComponent(confirmBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addContainerGap())
            );

            jLabel12.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
            jLabel12.setForeground(new java.awt.Color(255, 255, 255));
            jLabel12.setText("X");
            jLabel12.addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    jLabel12MouseClicked(evt);
                }
            });

            javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
            jPanel1.setLayout(jPanel1Layout);
            jPanel1Layout.setHorizontalGroup(
                jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel1Layout.createSequentialGroup()
                    .addContainerGap(140, Short.MAX_VALUE)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGap(20, 20, 20))
                .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                    .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jLabel12)
                    .addContainerGap())
            );
            jPanel1Layout.setVerticalGroup(
                jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel1Layout.createSequentialGroup()
                    .addComponent(jLabel12)
                    .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, 665, Short.MAX_VALUE)
                    .addGap(20, 20, 20))
            );

            javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
            getContentPane().setLayout(layout);
            layout.setHorizontalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            );
            layout.setVerticalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            );

            pack();
            setLocationRelativeTo(null);
        }// </editor-fold>//GEN-END:initComponents

    private void returnBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_returnBtnMouseClicked
        // TODO add your handling code here:
        Con = JDBCConnection.getConnection(user, pass);
        String sql = "DELETE DELIVERY_NOTE WHERE ReceiptID = ?";
        try{
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            Ps = Con.prepareStatement(sql);
            Ps.setString(1,ReceiptID1);
            Ps.execute();
            SelectReceipt();
            SelectDelivery();
        } catch (Exception e){
            e.printStackTrace();
        }
    }//GEN-LAST:event_returnBtnMouseClicked

    private void confirmBtnMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_confirmBtnMouseClicked
        // TODO add your handling code here:
        Con = JDBCConnection.getConnection(user, pass);
        String sql = "INSERT INTO DELIVERY_NOTE (ReceiptID, ShipperID) VALUES(?,?)";
        try{
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            Ps = Con.prepareStatement(sql);
            Ps.setString(1,ReceiptID);
            Ps.setString(2,id);
            Ps.execute();
            SelectReceipt();
            SelectDelivery();
        } catch (Exception e){
            e.printStackTrace();
        }
        // 0=yes, 1=no
    }//GEN-LAST:event_confirmBtnMouseClicked

    private void deliveryTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_deliveryTableMouseClicked
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel)deliveryTable.getModel ();
        int Myindex = deliveryTable.getSelectedRow();
        ReceiptID1 = model.getValueAt(Myindex, 0).toString();
    }//GEN-LAST:event_deliveryTableMouseClicked

//Khi bấm vào dòng nào thì data sẽ được truyền vào những biến trên
    private void receiptTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_receiptTableMouseClicked
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel)receiptTable.getModel ();
        int Myindex = receiptTable.getSelectedRow();
        ReceiptID = model.getValueAt(Myindex, 0).toString();
    }//GEN-LAST:event_receiptTableMouseClicked

    private void jLabel12MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel12MouseClicked
        // TODO add your handling code here:
        System.exit(0);
    }//GEN-LAST:event_jLabel12MouseClicked

    private void fillterBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_fillterBoxItemStateChanged
        // TODO add your handling code here:
        Con = JDBCConnection.getConnection(user, pass);
        String item = (String) evt.getItem();
        if (evt.getStateChange() == ItemEvent.SELECTED) {
            System.out.println(item);
            try{      
                Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
                if(item == "ALL")
                    Ps = Con.prepareStatement("EXEC pr_getReceipt");
                else{
                    Ps = Con.prepareStatement("EXEC pr_getReceiptByDistrict ?");
                    Ps.setString(1, (String)fillterBox.getSelectedItem());
                }
                Rs = Ps.executeQuery();
                receiptTable.setModel(DbUtils.resultSetToTableModel(Rs));
            } catch (Exception e){
                e.printStackTrace();
            }
        }         
    }//GEN-LAST:event_fillterBoxItemStateChanged
    ArrayList<String> numdata = new ArrayList<String>();String ReceiptID,ReceiptID1;    
    public void SelectReceipt() {
        Con = JDBCConnection.getConnection(user, pass);
        String sql = "EXEC pr_getReceipt";
        try{
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            Ps = Con.prepareStatement(sql);
            Rs = Ps.executeQuery();
            receiptTable.setModel(DbUtils.resultSetToTableModel(Rs));
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    
    public void SelectDelivery() {
        Con = JDBCConnection.getConnection(user, pass);
        String sql = "EXEC pr_getDeliveryNote ?";
        try{
            Con.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
            Ps = Con.prepareStatement(sql);
            Ps.setString(1,id);
            Rs = Ps.executeQuery();
            deliveryTable.setModel(DbUtils.resultSetToTableModel(Rs));
        } catch (Exception e){
            e.printStackTrace();
        }
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
//            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (InstantiationException ex) {
//            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (IllegalAccessException ex) {
//            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
//            java.util.logging.Logger.getLogger(Take_Delivery.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
//        }
//        //</editor-fold>
//
//        /* Create and display the form */
//        java.awt.EventQueue.invokeLater(new Runnable() {
//            public void run() {
//                new Take_Delivery().setVisible(true);
//            }
//        });
//    }
    private Connection Con = null;
    private PreparedStatement Ps = null;
    private ResultSet Rs = null;
    private String user = "TX", pass = "TX";
    private String id;
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton confirmBtn;
    private javax.swing.JTable deliveryTable;
    private javax.swing.JComboBox<String> fillterBox;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable receiptTable;
    private javax.swing.JButton returnBtn;
    // End of variables declaration//GEN-END:variables
}
