package com.nutrition.backend.service;

import com.nutrition.backend.model.Product;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Arrays;

@Service
public class NovaService {

    private static final List<String> ULTRA_PROCESSED_KEYWORDS = Arrays.asList(
            "high fructose corn syrup", "hydrogenated", "hydrolyzed", "msg", "aspartame", "sucralose",
            "flavor enhancer", "color");

    private static final List<String> PROCESSED_CULINARY_KEYWORDS = Arrays.asList(
            "sugar", "oil", "butter", "salt", "vinegar");

    public int calculateNovaGroup(Product product) {
        if (product.getIngredients() == null || product.getIngredients().isEmpty())
            return 1;

        List<String> ingredientsList = Arrays.asList(product.getIngredients().split(","));

        boolean hasUltraProcessed = ingredientsList.stream()
                .anyMatch(ing -> ULTRA_PROCESSED_KEYWORDS.stream().anyMatch(k -> ing.toLowerCase().contains(k)));

        if (hasUltraProcessed)
            return 4;

        boolean hasCulinary = ingredientsList.stream()
                .anyMatch(ing -> PROCESSED_CULINARY_KEYWORDS.stream().anyMatch(k -> ing.toLowerCase().contains(k)));

        // If it has added sugar/oil/salt and comes in a can/jar (implied), it's likely
        // Group 3
        // But for simplified logic, if it has many ingredients > 5 and culinary
        // ingredients, assume 3.
        if (hasCulinary && ingredientsList.size() > 5)
            return 3;

        if (hasCulinary)
            return 2;

        return 1; // Unprocessed
    }
}
