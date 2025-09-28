package com.miran.retail.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public Map<String, String> hello() {
        return Map.of("message", "Hello from Retail Demo App");
    }
    @GetMapping("/")
    public Map<String, String> index() {
        return Map.of("message", "Welcome to Retail Demo App");
    }
}
