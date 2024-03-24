/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class Cart {

    private Product product;
    private int quantity;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Cart() {
    }

    public Cart(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object obj) {
        Cart ex = (Cart) obj;
        return this.getProduct().getId() == ex.getProduct().getId();
    }

    @Override
    public int hashCode() {
        int result = 17;
        result = 31 * result + product.getId();
        return result;
    }
}
