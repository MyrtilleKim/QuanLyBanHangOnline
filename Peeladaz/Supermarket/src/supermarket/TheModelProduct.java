/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package supermarket;

import javax.swing.Icon;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author ranco
 */
public class TheModelProduct extends AbstractTableModel{

    private String[] columns;
    private Object [][] rows;
    public TheModelProduct () {}
    public TheModelProduct (Object[][] data, String[] columnName){
        this.columns = columnName;
        this.rows = data;
    }
    
    public Class getColumnClass (int column) {
        if (column == 4) {
            return String.class;
        }
        else{
            return getValueAt (0, column).getClass();
        }
    }
    public int getRowCount() {
        return this.rows.length;
    }

    
    public int getColumnCount() {
        return this.columns.length;
    }

    
    public Object getValueAt(int rowIndex, int columnIndex) {
        return this.rows[rowIndex][columnIndex];
    }
    
    public String getColumnName (int col) {
        return this.columns[col];
    }
}
