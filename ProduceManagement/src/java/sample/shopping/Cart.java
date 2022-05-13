/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.shopping;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author giama
 */
public class Cart {
    private Map<String, Product> cart;

    public Cart() {
    }

    public Cart(Map<String, Product> cart) {
        this.cart = cart;
    }

    public Map<String, Product> getCart() {
        return cart;
    }

    public void setCart(Map<String, Product> cart) {
        this.cart = cart;
    }
    
    public void add(Product product) {
        if(this.cart == null) {
            this.cart = new HashMap<>();
        }
        if(this.cart.containsKey(product.getId())) {
            double currentQuantity = this.cart.get(product.getId()).getQuantity();
            product.setQuantity(currentQuantity + product.getQuantity());
            
        }
        cart.put(product.getId(), product);
    }
    
    public void delete(String id) {
        if(this.cart == null) {
            return;
        }
        if(this.cart.containsKey(id)) {
            this.cart.remove(id);    
        }
        
    }
    
    public void update(String id, Product newProduct) {
        if(this.cart == null) {
            return;
        }
        
        if(this.cart.containsKey(id)) {
            this.cart.replace(id, newProduct);  
        }
    } 
}
