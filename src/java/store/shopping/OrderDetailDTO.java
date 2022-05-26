
package store.shopping;

public class OrderDetailDTO {
    private String productName;
    private int price;
    private int quantity;
    private String size;
    private String color;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String productName, int price, int quantity, String size, String color) {
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
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
    
}
