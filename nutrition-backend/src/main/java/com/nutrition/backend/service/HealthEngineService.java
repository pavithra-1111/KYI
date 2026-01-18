package com.nutrition.backend.service;

import com.nutrition.backend.model.Product;
import com.nutrition.backend.model.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HealthEngineService {

    public AnalysisResult analyze(Product product, User user) {
        List<String> riskFlags = new ArrayList<>();
        String recommendation = "MODERATE";

        // 1. Allergies Check
        if (user != null && user.getAllergies() != null) {
            for (String allergy : user.getAllergies()) {
                if (product.getIngredients().stream()
                        .anyMatch(ing -> ing.toLowerCase().contains(allergy.toLowerCase()))) {
                    riskFlags.add("CONTAINS ALLERGEN: " + allergy.toUpperCase());
                    recommendation = "AVOID";
                }
            }
        }

        // 2. Health Goals Check
        if (user != null && user.getHealthGoals() != null) {
            if (user.getHealthGoals().contains("Diabetes Management")) {
                if (product.getSugar() > 10) {
                    riskFlags.add("High Sugar Content");
                    if (!recommendation.equals("AVOID"))
                        recommendation = "AVOID";
                }
            }
            if (user.getHealthGoals().contains("Heart Health")) {
                if (product.getSalt() > 1.5 || product.getFat() > 20) {
                    riskFlags.add("High Sodium/Fat for Heart Health");
                    if (!recommendation.equals("AVOID"))
                        recommendation = "MODERATE";
                }
            }
        }

        // 3. General Global Rules
        if (product.getNovaGroup() == 4) {
            riskFlags.add("Ultra-Processed Food");
            if (recommendation.equals("GOOD"))
                recommendation = "MODERATE";
        }

        if (product.getNutriScore().equals("A") || product.getNutriScore().equals("B")) {
            if (!recommendation.equals("AVOID"))
                recommendation = "GOOD";
        }

        return new AnalysisResult(recommendation, riskFlags, generateExplanation(product, recommendation, riskFlags));
    }

    private String generateExplanation(Product p, String rec, List<String> risks) {
        StringBuilder sb = new StringBuilder();
        sb.append("This product is rated ").append(rec).append(". ");
        if (!risks.isEmpty()) {
            sb.append("Be aware of: ").append(String.join(", ", risks)).append(". ");
        }
        if (p.getNutriScore().equals("A")) {
            sb.append("It has a great nutritional balance. ");
        }
        return sb.toString();
    }

    // Inner DTO for internal use
    public record AnalysisResult(String recommendation, List<String> risks, String explanation) {
    }
}
