package com.nutrition.backend.controller;

import com.nutrition.backend.model.Product;
import com.nutrition.backend.service.HealthEngineService;
import com.nutrition.backend.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/analyze")
@CrossOrigin(origins = "*")
public class AnalysisController {

    @Autowired
    private ProductService productService;

    @PostMapping("/product")
    public ResponseEntity<AnalysisResponse> analyzeProduct(
            @RequestParam String productName,
            @RequestParam(required = false) Long userId) {

        // 1. Get or Create Product with Scores
        Product product = productService.analyzeProduct(productName, userId);

        // 2. Run Health Analysis
        HealthEngineService.AnalysisResult analysis = productService.getAnalysis(product, userId);

        // 3. Construct Response
        AnalysisResponse response = new AnalysisResponse(product, analysis);
        return ResponseEntity.ok(response);
    }

    // DTO for Response
    public record AnalysisResponse(Product product, HealthEngineService.AnalysisResult analysis) {
    }
}
