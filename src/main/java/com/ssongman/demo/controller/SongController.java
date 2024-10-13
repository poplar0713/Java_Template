package com.ssongman.demo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SongController {
	
    @GetMapping("/health")
    public ResponseEntity<String> healthCheck() {
    	System.out.println("API Call health");
        return ResponseEntity.ok("Server is running");
    }

}
