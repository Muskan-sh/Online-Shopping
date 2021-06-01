package com.example.myProject.dao;

import com.example.myProject.entities.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CategoryDao {
    private final SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int saveCategory(Category category) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(category);
        tx.commit();
        session.close();
        return catId;
    }

    public List<Category> getAllCategories() {
        Session session = this.factory.openSession();
        Query<Category> q = session.createQuery("from Category ", Category.class);
        return q.list();
    }

    public Category getCategoryById(int catId) {

        Category category = null;
        try {
            Session session = this.factory.openSession();
//            String query="from Category where categoryID =: c";
//            Query<Category> q=session.createQuery(query,Category.class);
//            q.setParameter("c",catId);
//            category= q.uniqueResult();
//            category=session.get
            category = session.get(Category.class, catId);
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }

    public int getTotalCategories() {
        return getAllCategories().size();
    }
}
