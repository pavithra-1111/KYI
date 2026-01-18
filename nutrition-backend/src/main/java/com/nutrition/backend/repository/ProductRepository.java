package com.nutrition.backend.repository;

import com.nutrition.backend.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Optional<Product> findByNameContainingIgnoreCase(String name);

    Optional<Product> findByBarcode(String barcode);
}
