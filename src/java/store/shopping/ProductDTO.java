package store.shopping;


public class ProductDTO {
    private int productID;
    private String productName;
    private String image;
    private String description;
    private String size;
    private String color;
    private int price;
    private int quantity;
    private float discount;
    private int lowStockLimit;
    private String categoryName;
    private boolean status;

    public ProductDTO() {
        
    }

    public ProductDTO(int productID, String productName, int price, float discount, int lowStockLimit, String categoryName, boolean status) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.categoryName = categoryName;
        this.status = status;
    }
    
    

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
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

    public int getLowStockLimit() {
        return lowStockLimit;
    }

    public void setLowStockLimit(int lowStockLimit) {
        this.lowStockLimit = lowStockLimit;
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
