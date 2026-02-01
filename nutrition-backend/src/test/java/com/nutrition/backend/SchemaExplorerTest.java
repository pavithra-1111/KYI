package com.nutrition.backend;

import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SchemaExplorerTest {
    @Test
    public void printSchema() throws Exception {
        Class.forName("org.duckdb.DuckDBDriver");
        try (Connection conn = DriverManager.getConnection("jdbc:duckdb:");
                Statement stmt = conn.createStatement()) {

            // Query the parquet file directly
            String parquetPath = "/Users/pavithra/repos/KYI-FE/food.parquet";
            ResultSet rs = stmt.executeQuery("DESCRIBE SELECT * FROM '" + parquetPath + "'");

            System.out.println("COLUMN_NAME | COLUMN_TYPE");
            System.out.println("--- | ---");
            while (rs.next()) {
                String name = rs.getString("column_name"); // DuckDB describe returns column_name, column_type, etc.
                String type = rs.getString("column_type");
                System.out.println(name + " | " + type);
            }
        }
    }
}
