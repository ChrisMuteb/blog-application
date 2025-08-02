package com.springmvcproject.blogApplication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;

@Component
public class DatabaseConnectionVerifier implements CommandLineRunner {
    private final DataSource dataSource;
    // Obtain a logger instance for this class
    private static final Logger log = LoggerFactory.getLogger(DatabaseConnectionVerifier.class);

    public DatabaseConnectionVerifier(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void run(String... args) throws Exception {
        log.info("Attempting to connect to the configured H2 database...");

        try(Connection connection = dataSource.getConnection()){
            // logging lovels: info, debug, error, trace
            log.info("Successfully established a connection to the database!"); // general information about the application's flow
            log.debug("Connection details: URL = {}", connection.getMetaData().getURL()); // details information useful for developers
            log.trace("Connection object: {}", connection); // extremely detailed information

        }catch (Exception e){
            log.error("Failed to connect to the H2 database!.", e); // serious issues that prevent the app from functioning.
            e.printStackTrace();
        }
    }
}
