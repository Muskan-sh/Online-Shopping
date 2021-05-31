package com.example.myProject.dao;

import com.example.myProject.entities.Category;
import com.example.myProject.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
    public int saveProduct(Product product){

        Session session= factory.openSession();
        Transaction tx= session.beginTransaction();
        int pId= (int)session.save(product);
        tx.commit();
        session.close();
        return pId;
    }

    public Product getProductById(int pId){

        Product product=null;
        try{
            Session session= this.factory.openSession();
            product=session.get(Product.class,pId);
            session.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return product;
    }

    public void updateProductPhoto(Product product,String pPhoto){
        Session session= factory.openSession();
        Transaction tx= session.beginTransaction();
        product.setpPhoto(pPhoto);
        session.update(product);
        tx.commit();
        session.close();
    }

    public List<Product> getAllProducts(){
        Session session=this.factory.openSession();
        Query<Product> query= session.createQuery("from Product ",Product.class);
        return query.list();
    }

    public List<Product> getProductsByCategoryId(int cId){
        Session session=this.factory.openSession();
        Query<Product> query= session.createQuery("from Product where category.categoryID =: c",Product.class);
        query.setParameter("c",cId);
        List<Product> list=query.list();
        return list;
    }

    public int getTotalProducts(){
        return getAllProducts().size();
    }
}
