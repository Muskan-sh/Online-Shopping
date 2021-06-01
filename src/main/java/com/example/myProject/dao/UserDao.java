package com.example.myProject.dao;

import com.example.myProject.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserDao {
    private final SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    //get user by email and password
    public int saveUser(User user) {

        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        int userId = (int) session.save(user);
        tx.commit();
        session.close();
        return userId;
    }

    public User getUserByEmailAndPassword(String email, String password) {

        User user = null;
        try {
            String query = "from User where userEmail =: e and userPassword =: p";
            Session session = this.factory.openSession();
            Query<User> q = session.createQuery(query, User.class);
            q.setParameter("e", email);
            q.setParameter("p", password);
            user = q.uniqueResult();

            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public int getTotalUsers() {
        Session session = this.factory.openSession();
        Query<User> q = session.createQuery("from User", User.class);
        return q.list().size();
    }
}
