package com.demo;


import java.util.Arrays;
import java.util.stream.IntStream;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(Application.class, args);

        System.out.println("Loaded Bean Context:");

        String[] beanNames = ctx.getBeanDefinitionNames();
        Arrays.sort(beanNames);
        IntStream.range(1, beanNames.length).forEach(index -> {
            System.out.print( String.format(" #%d: %s", index, beanNames[index]) );
        });
    }

}