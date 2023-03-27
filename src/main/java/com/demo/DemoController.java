package com.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
// @RestController combines @Controller and @ResponseBody, two annotations that results in web requests returning data rather than a view.
public class DemoController {

    @GetMapping("/demo/get")
    public String index() {
        return "Greetings from Spring Boot!";
    }

}