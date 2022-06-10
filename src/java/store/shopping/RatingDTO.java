/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.shopping;

/**
 *
 * @author vankh
 */
public class RatingDTO {
    
    private int star;
    private String content;
    private String fullName;
    private int productID;

    public RatingDTO() {
    }

    public RatingDTO(int star, String content, String fullName, int productID) {
        this.star = star;
        this.content = content;
        this.fullName = fullName;
        this.productID = productID;
    }

    
    
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    
    
    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    
}
