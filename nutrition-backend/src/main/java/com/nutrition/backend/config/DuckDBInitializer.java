package com.nutrition.backend.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@Component
public class DuckDBInitializer implements CommandLineRunner {

    private static final Logger logger = LoggerFactory.getLogger(DuckDBInitializer.class);

    @Override
    public void run(String... args) throws Exception {
        logger.info("Initializing DuckDB with Parquet Views...");
        Class.forName("org.duckdb.DuckDBDriver");

        // Create View over Parquet file.
        // We map columns to match the Product entity fields roughly.
        // Product Entity: code(barcode), name, brand, etc.
        // Parquet: code, product_name, brands...

        // Note: For complex fields like ingredients (List<String>), we might need to
        // cast or leave them for now.
        // DuckDB can query parquet directly, but to expose it as 'product' table for
        // JPA, we need a View.
        // However, JPA expects a real table usually or a View that behaves like one.
        // Read-only access should work fine with a View.

        String createViewSql = "CREATE OR REPLACE VIEW product AS SELECT " +
                "code, " +
                "brands AS brand, " +
                "nutriscore_grade AS nutri_score, " +
                "nova_group, " +
                "product_name[1].text AS name, " +
                "ingredients_text AS ingredients, " +
                "NULL AS image_url, " +
                // Nutrients placehodlers
                "0.0 AS protein, " +
                "0.0 AS carbs, " +
                "0.0 AS fat, " +
                "0.0 AS fiber, " +
                "0.0 AS sugar, " +
                "0.0 AS salt " +
                "FROM '/Users/pavithra/repos/KYI-FE/food.parquet'";

        // Improved View with some extraction if possible using DuckDB JSON/Struct
        // functions
        // But for stability, let's keep it simple first and iterate.
        // IMPORTANT: We need to match the Entity column names.
        // Entity: barcode (mapped to 'code' column via @Column), brand, name,
        // nutriScore, etc.

        try (Connection conn = DriverManager.getConnection("jdbc:duckdb:nutrition.db");
                Statement stmt = conn.createStatement()) {

            stmt.execute(createViewSql);
            logger.info("Created 'product' view over food.parquet");

            // Verify
            try (var rs = stmt.executeQuery("SELECT count(*) FROM product")) {
                if (rs.next()) {
                    logger.info("View contains {} rows", rs.getLong(1));
                }
            }
        }
    }
}
