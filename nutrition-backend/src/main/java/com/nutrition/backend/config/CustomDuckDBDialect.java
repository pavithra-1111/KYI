package com.nutrition.backend.config;

import org.hibernate.dialect.PostgreSQLDialect;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;

public class CustomDuckDBDialect extends PostgreSQLDialect {

    public CustomDuckDBDialect() {
        super();
    }

    @Override
    public String getQuerySequencesString() {
        // DuckDB might not support standard sequence queries in information_schema the
        // way Postgres does
        // Return null or empty to avoid startup checks failing
        return null;
    }

    @Override
    public boolean supportsSequences() {
        return false;
    }
}
