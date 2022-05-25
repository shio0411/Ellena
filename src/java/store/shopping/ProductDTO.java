package store.shopping;

import java.util.Date;


public class ProductDTO {
    private int productID;
    private String productName;
    private String image;
    private String description;
    private String size;
    private String color;
    private int price;
    private int quantity;
    private int categoryID;
    private Date importDate;
    private boolean status;

    public ProductDTO() {
        this.productID = 0;
        this.productName = "";
        this.image = "";
        this.description = "";
        this.size = "";
        this.color = "";
        this.price = 0;
        this.quantity = 0;
        this.categoryID = 0;
        this.importDate = new Date();
        this.status = false;
    }

    public ProductDTO(int productID, String productName, String image, String description, String size, String color, int price, int quantity, int categoryID, Date importDate, boolean status) {
        this.productID = productID;
        this.productName = productName;
        this.image = image;
        this.description = description;
        this.size = size;
        this.color = color;
        this.price = price;
        this.quantity = quantity;
        this.categoryID = categoryID;
        this.importDate = importDate;
        this.status = status;
    }
    
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
