package com.example.myProject.entities;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryID;
    private String categoryTitle;
    @Column(length = 3000)
    private String categoryDescription;
    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();

    public Category() {
    }

    public Category(int categoryID,
                    String categoryTitle, String categoryDescription) {
        this.categoryID = categoryID;
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
    }

    public Category(String categoryTitle, String categoryDescription,
                    List<Product> products) {
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
        this.products = products;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryTitle() {
        return categoryTitle;
    }

    public void setCategoryTitle(String categoryTitle) {
        this.categoryTitle = categoryTitle;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Category{" +
                "categoryID=" + categoryID +
                ", categoryTitle='" + categoryTitle + '\'' +
                ", categoryDescription='" + categoryDescription + '\'' +
                '}';
    }

}
