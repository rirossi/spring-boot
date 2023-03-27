# spring-boot
A spring boot java example

@Configuration: Tags the class as a source of bean definitions for the application context.
@EnableAutoConfiguration: Tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings. For example, if spring-webmvc is on the classpath, this annotation flags the application as a web application and activates key behaviors, such as setting up a DispatcherServlet. s
@ComponentScan: Tells Spring to look for other components, configurations, and services in the root package, letting it find the controllers.

Run the Application
To run the application, run the following command in a terminal window (in the complete) directory:

```
./mvnw spring-boot:run
```


References:
https://github.com/spring-guides/gs-spring-boot
https://github.com/rirossi/spring-boot
