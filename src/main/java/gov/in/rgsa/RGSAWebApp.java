package gov.in.rgsa;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactoryUtils;
import org.springframework.beans.factory.ListableBeanFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.dao.support.PersistenceExceptionTranslator;

import javax.persistence.NoResultException;
import java.util.Map;


@SpringBootApplication
public class RGSAWebApp extends SpringBootServletInitializer {
    static Logger logger = LoggerFactory.getLogger(RGSAWebApp.class);

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        logger.debug(">> RGSAWebApp Servlet starting .... ");
        return application.sources(RGSAWebApp.class);
    }

    public static void main(String[] args) {
        logger.debug(">> RGSAWebApp Application starting .... ");
        ApplicationContext applicationContext = SpringApplication.run(RGSAWebApp.class, args);
        postMainDebugs(applicationContext);
    }

    public static void postMainDebugs(ApplicationContext applicationContext){
        ListableBeanFactory listableBeanFactory = ((ConfigurableApplicationContext) applicationContext).getBeanFactory();
        Map<String, PersistenceExceptionTranslator> pets = BeanFactoryUtils.beansOfTypeIncludingAncestors(
                listableBeanFactory, PersistenceExceptionTranslator.class, false, false);
        pets.forEach((String name, PersistenceExceptionTranslator pet) -> {
            RuntimeException runtimeException = pet.translateExceptionIfPossible(new NoResultException("Whatever"));
            logger.info(String.format("Interceptor: name(%s) , class(%s), Exception(%s)", name, pet, runtimeException));
        });
        for (String name : applicationContext.getBeanDefinitionNames()) {
            logger.info("Loaded Bean: " + name);
        }
    }

}

