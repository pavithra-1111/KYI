package com.nutrition.backend.service;

import com.nutrition.backend.model.Product;
import com.nutrition.backend.model.User;
import com.nutrition.backend.repository.ProductRepository;
import com.nutrition.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private NutriScoreService nutriScoreService;

    @Autowired
    private NovaService novaService;

    @Autowired
    private HealthEngineService healthEngineService;

    public Product analyzeProduct(String productName, Long userId) {
        // 1. Mock Lookup / DB Lookup
        // For MVP, if not exists, create a dummy one based on name
        Optional<Product> existing = productRepository.findByNameContainingIgnoreCase(productName);
        Product product = existing.orElseGet(() -> createMockProduct(productName));

        // 2. Calculate scores (if not already set or re-calculate)
        product.setNutriScore(nutriScoreService.calculateNutriScore(product));
        product.setNovaGroup(novaService.calculateNovaGroup(product));

        // Save/Update
        productRepository.save(product);

        // 3. User Context Analysis (Returns analysis, doesn't modify product)
        User user = null;
        if (userId != null) {
            user = userRepository.findById(userId).orElse(null);
        }

        // Note: For MVP we might want to return a DTO that includes the analysis result
        // But here we return the enriched Product entity.
        // Real implementation would map to a ProductAnalysisResponseDTO

        return product;
    }

    public HealthEngineService.AnalysisResult getAnalysis(Product product, Long userId) {
        User user = (userId != null) ? userRepository.findById(userId).orElse(null) : null;
        return healthEngineService.analyze(product, user);
    }

    private Product createMockProduct(String name) {
        Product p = new Product();
        p.setName(name);
        p.setBrand("Unknown Brand");
        p.setIngredients("Water, Sugar, Flavouring"); // Default mock
        p.setProtein(1.0);
        p.setCarbs(12.0);
        p.setSugar(12.0);
        p.setFat(0.5);
        p.setFiber(0.0);
        p.setSalt(0.01);
        return p;
    }
}
