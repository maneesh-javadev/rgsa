package gov.in.rgsa;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;



@SpringBootApplication
public class RGSAWebApp extends SpringBootServletInitializer {
    static Logger logger = LoggerFactory.getLogger(RGSAWebApp.class);

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        logger.debug("@@@@Spring Servlet starting .... ");
        return application.sources(RGSAWebApp.class);
    }

    public static void main(String[] args) {
        logger.debug("##### Spring Application starting .... ");
        SpringApplication.run(RGSAWebApp.class, args);
    }

}

