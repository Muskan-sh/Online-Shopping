package com.example.myProject.entities;

import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.io.Serializable;

@Entity
public class Cart implements Serializable {

    @EmbeddedId
    private CartPK cartPK;
    private int amount;

    public Cart() {
    }

    public Cart(CartPK cartPK) {
        this.cartPK = cartPK;
        this.amount = 1;
    }

    public CartPK getCartPK() {
        return cartPK;
    }

    public void setCartPK(CartPK cartPK) {
        this.cartPK = cartPK;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    @Embeddable
    public static class CartPK implements Serializable {

        private int userId;
        private int productId;

        public CartPK() {

        }

        public CartPK(int userId, int productId) {
            this.userId = userId;
            this.productId = productId;
        }

        public int getUserId() {
            return userId;
        }

        public void setUserId(int userId) {
            this.userId = userId;
        }

        public int getProductId() {
            return productId;
        }

        public void setProductId(int productId) {
            this.productId = productId;
        }

        @Override
        public int hashCode() {
            return String.valueOf(this.productId + this.userId).hashCode();
        }

        @Override
        public boolean equals(Object obj) {
            if (obj == this) {
                return true;
            } else if (obj instanceof CartPK) {
                CartPK o1 = (CartPK) obj;
                return this.userId == o1.userId && this.productId == o1.productId;
            } else {
                return false;
            }
        }


    }
}
