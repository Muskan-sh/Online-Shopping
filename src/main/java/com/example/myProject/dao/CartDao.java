package com.example.myProject.dao;

import com.example.myProject.entities.Cart;
import com.example.myProject.entities.Category;
import com.example.myProject.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CartDao {

    private SessionFactory factory;

    public CartDao(SessionFactory factory) {
        this.factory = factory;
    }

    public void saveItemInCart(Cart cart) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(cart);
        tx.commit();
        session.close();
    }

    public void increseAmountBy1(Cart cart) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        cart.setAmount(cart.getAmount() + 1);
        session.update(cart);
        tx.commit();
        session.close();
    }

    public void decreaseAmountBy1(Cart cart) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        cart.setAmount(cart.getAmount() - 1);
        session.update(cart);
        tx.commit();
        session.close();
    }

    public void removeItem(int pid, int uid) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        session.createQuery(" delete from Cart where cartPK.productId=: pi and cartPK.userId =: ui")
                .setParameter("ui", uid).setParameter("pi",pid).executeUpdate();
        tx.commit();
        session.close();

    }

    public List<Cart> getAllCartItems() {
        Session session = this.factory.openSession();
        Query<Cart> q = session.createQuery("from Cart ", Cart.class);
        return q.list();
    }

    public List<Cart> getCartItemsByUserId(int userId) {
        Session session = this.factory.openSession();
        Query<Cart> query = session.createQuery("from Cart where cartPK.userId=: ui", Cart.class);
        query.setParameter("ui", userId);
        return query.list();
    }


}
