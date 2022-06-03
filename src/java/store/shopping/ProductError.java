/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.shopping;

/**
 *
 * @author ASUS
 */
public class ProductError {

    private String productID;
    private String productName;
    private String image;
    private String description;
    private String size;
    private String color;
    private String price;
    private String discount;
    private String quantity;
    private String lowStockLimit;
    private String categoryID;
    private String categoryName;
    private String rating;
    private String status;
    private String errorMessage;

    public ProductError() {
        this.productID = "";
        this.productName = "";
        this.image = "";
        this.description = "";
        this.size = "";
        this.color = "";
        this.price = "";
        this.discount = "";
        this.quantity = "";
        this.lowStockLimit = "";
        this.categoryID = "";
        this.categoryName = "";
        this.rating = "";
        this.status = "";
        this.errorMessage = "";
    }

    public ProductError(String productID, String productName, String image, String description, String size, String color, String price, String discount, String quantity, String lowStockLimit, String categoryID, String categoryName, String rating, String status, String errorMessage) {
        this.productID = productID;
        this.productName = productName;
        this.image = image;
        this.description = description;
        this.size = size;
        this.color = color;
        this.price = price;
        this.discount = discount;
        this.quantity = quantity;
        this.lowStockLimit = lowStockLimit;
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.rating = rating;
        this.status = status;
        this.errorMessage = errorMessage;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getLowStockLimit() {
        return lowStockLimit;
    }

    public void setLowStockLimit(String lowStockLimit) {
        this.lowStockLimit = lowStockLimit;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

}
