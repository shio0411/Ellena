/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.shopping;

/**
 *
 * @author giama
 */
public class Product {
    private String id;
    private String name;
    private String img;
    private double price;
    private double quantity;

    public Product() {
        this.id = "";
        this.name = "";
        this.img = "";
        this.price = 0;
        this.quantity = 0;
    }

    public Product(String id, String name, String img, double price, double quantity) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.price = price;
        this.quantity = quantity;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }
    
    
}
