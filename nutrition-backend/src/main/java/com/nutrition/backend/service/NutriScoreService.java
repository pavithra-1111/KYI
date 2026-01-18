package com.nutrition.backend.service;

import com.nutrition.backend.model.Product;
import org.springframework.stereotype.Service;

@Service
public class NutriScoreService {

    // Simplified calculation based on negative (energy, sugar, sat-fat, salt) vs
    // positive (fiber, protein) points
    public String calculateNutriScore(Product product) {
        int negativePoints = calculateNegativePoints(product);
        int positivePoints = calculatePositivePoints(product);
        int score = negativePoints - positivePoints;

        if (score <= -1)
            return "A";
        if (score <= 2)
            return "B";
        if (score <= 10)
            return "C";
        if (score <= 18)
            return "D";
        return "E";
    }

    private int calculateNegativePoints(Product p) {
        int points = 0;
        // Energy (kJ) - Mock logic: 1 point per 335kJ
        // Sugar (g) - 1 point per 4.5g
        if (p.getSugar() > 45)
            points += 10;
        else if (p.getSugar() > 0)
            points += (int) (p.getSugar() / 4.5);

        // Saturated Fat
        if (p.getFat() > 10)
            points += 10; // Simplified

        // Salt
        if (p.getSalt() > 0.9)
            points += 10; // Simplified

        return points;
    }

    private int calculatePositivePoints(Product p) {
        int points = 0;
        // Fiber
        if (p.getFiber() > 4.7)
            points += 5;
        else if (p.getFiber() > 0)
            points += (int) (p.getFiber());

        // Protein
        if (p.getProtein() > 8)
            points += 5;
        else if (p.getProtein() > 0)
            points += (int) (p.getProtein() / 1.6);

        return points;
    }
}
