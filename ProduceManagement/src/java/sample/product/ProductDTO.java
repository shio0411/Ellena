/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

import java.util.Date;

/**
 *
 * @author giama
 */
public class ProductDTO {
    private String id;
    private String name;
    private String img;
    private double currentPrice;
    private double unitInStock;
    private String categoryID;
    private Date   importDate;
    private Date   expiryDate;
    private boolean status;

    public ProductDTO() {
        this.id = "";
        this.name = "";
        this.img = null;
        this.currentPrice = 0;
        this.unitInStock = 0;
        this.categoryID = "";
        this.importDate = null;
        this.expiryDate = null;
        this.status = false;
    }

    public ProductDTO(String id, String name, String img, double currentPrice, double unitInStock, String categoryID, Date importDate, Date expiryDate, boolean status) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.currentPrice = currentPrice;
        this.unitInStock = unitInStock;
        this.categoryID = categoryID;
        this.importDate = importDate;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public double getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }

    public double getUnitInStock() {
        return unitInStock;
    }

    public void setUnitInStock(double unitInStock) {
        this.unitInStock = unitInStock;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public java.util.Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public java.util.Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    
}