package store.shopping;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private List<CartProduct> cartList = new ArrayList<>();

    public List<CartProduct> getCartList() {
        return cartList;
    }

    public void setCartList(List<CartProduct> cartList) {
        this.cartList = cartList;
    }

    public CartProduct getProductInfo(int productID, String color, String sizeKey, int quantity) throws SQLException {
        CartProduct item = new CartProduct();
        ProductDAO dao = new ProductDAO();
        ProductDTO product = dao.getProductDetail(productID);
        item.setProductID(productID);
        item.setProductName(product.getProductName());
        item.setColor(color);
        item.setImage(product.getColorImage().get(color).get(0));
        item.setSize(sizeKey);
        item.setPrice(product.getPrice());
        item.setQuantity(quantity);
        item.setDiscount(product.getDiscount());
        item.setLowStockLimit(product.getLowStockLimit());

        return item;
    }

    public int getTotalAmount(List<CartProduct> cart) {
        int result = 0;
        for (CartProduct item : cart) {
            result += (int) (item.getPrice() * (1 - item.getDiscount()) * item.getQuantity());
        }
        return result;
    }
    
    
}
