package com.example.myProject;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {
    private static SessionFactory factory;

    public static SessionFactory getFactory() {
        try {
            if (factory == null) {
                Configuration config = new Configuration()
                        .configure("hibernate.cfg.xml");
                factory = config.buildSessionFactory();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return factory;
    }

}