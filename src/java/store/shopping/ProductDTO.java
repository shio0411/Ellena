package store.shopping;

public class ProductDTO {

    private int productID;
    private String productName;
    private String image;
    private String description;
    private String size;
    private String color;
    private int price;
    private Double discount;
    private int quantity;
    private int lowStockLimit;
    private int categoryID;
    private String categoryName;
    private Double rating;
    private boolean status;

    public ProductDTO() {
        this.productID = 0;
        this.productName = "";
        this.image = "";
        this.description = "";
        this.size = "";
        this.color = "";
        this.price = 0;
        this.discount = 0.0;
        this.quantity = 0;
        this.lowStockLimit = 0;
        this.categoryID = 0;
        this.categoryName = "";
        this.rating = 0.0;
        this.status = false;
    }

    public ProductDTO(int productID, String productName, String image, String description, String size, String color, int price, Double discount, int quantity, int lowStockLimit, int categoryID, String categoryName, Double rating, boolean status) {
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

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getLowStockLimit() {
        return lowStockLimit;
    }

    public void setLowStockLimit(int lowStockLimit) {
        this.lowStockLimit = lowStockLimit;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
