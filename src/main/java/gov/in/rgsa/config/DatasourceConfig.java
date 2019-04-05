package gov.in.rgsa.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateExceptionTranslator;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.persistenceunit.MutablePersistenceUnitInfo;
import org.springframework.orm.jpa.persistenceunit.PersistenceUnitManager;
import org.springframework.orm.jpa.persistenceunit.PersistenceUnitPostProcessor;
import org.springframework.orm.jpa.vendor.HibernateJpaDialect;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManagerFactory;
import javax.persistence.spi.PersistenceUnitInfo;
import javax.sql.DataSource;
import java.util.Properties;

@Configuration
public class DatasourceConfig {

    @Value("${spring.jpa.mapping-resources}")
    private String resources;

    @Value("${spring.jpa.hibernate.ddl-auto}")
    private String ddlAuto;

    @Value("${spring.jpa.database-platform}")
    private String databasePlatform;

    @Value("${spring.jpa.properties.hibernate.default_schema}")
    private String defaultSchema;

    @Value("${spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation}")
    private String nonContextualCreation;

    @Value("${spring.jpa.properties.hibernate.format_sql}")
    private String formatSQL;

    @Value("${spring.jpa.hibernate.naming.physical-strategy}")
    private String strategy;

    @Value("${spring.datasource.driver-class-name}")
    private String driverClassName;

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Bean(name = "jpaVendorAdapter")
    public JpaVendorAdapter getJpaVendorAdapter(){
        //noinspection UnnecessaryLocalVariable
        JpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        return vendorAdapter;
    }

    @Bean(name = "entityManagerFactory")
    public LocalContainerEntityManagerFactoryBean getEntityManagerFactory() {
        LocalContainerEntityManagerFactoryBean em
                = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(getDataSource());
        em.setPersistenceUnitName("persistenceUnit");
        em.setJpaVendorAdapter(getJpaVendorAdapter());
        // @NOTICE: If you add `@entity` anywhere other than these locations
        //          remember to add that package here as well.
        em.setPackagesToScan(
                "gov.in.rgsa.entity",
                "gov.in.rgsa.outbound",
                "gov.in.rgsa.inbound"
        );
        em.setMappingResources(this.resources);

        Properties properties = new Properties();
        properties.setProperty("hibernate.hbm2ddl.auto", this.ddlAuto);
        properties.setProperty("hibernate.dialect", this.databasePlatform);

        properties.setProperty("hibernate.default_schema", this.defaultSchema);
        properties.setProperty("hibernate.jdbc.lob.non_contextual_creation", this.nonContextualCreation);
        properties.setProperty("hibernate.format_sql", this.formatSQL);
        properties.setProperty("hibernate.naming.physical-strategy", this.strategy);

        em.setJpaProperties(properties);
        return em;
    }

    @Bean(name = "transactionManager")
    public PlatformTransactionManager getTransactionManager(
            EntityManagerFactory emf){
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(emf);
        // blah blah for compilation error if included
        return transactionManager;
    }

    @Bean(name = "dataSource")
    public DataSource getDataSource(){
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        // dataSource.setDriverClassName("org.postgresql.Driver");

        dataSource.setDriverClassName(this.driverClassName);
        dataSource.setUrl(this.url);
        dataSource.setUsername(this.username);
        dataSource.setPassword(this.password);
        return dataSource;
    }

    @Bean(name = "hibernateJpaDialect")
    public HibernateJpaDialect hibernateJpaDialect() {
        return new HibernateJpaDialect();
    }

    @Bean(name = "hibernateExceptionTranslator")
    public HibernateExceptionTranslator hibernateExceptionTranslator() {
        return new HibernateExceptionTranslator();
    }

//    // @WARN: Enabling below code will automatically enable Spring Exception Translation.
//    @Bean(name = "springAOPExceptionTranslator")
//    public PersistenceExceptionTranslationPostProcessor exceptionTranslation(){
//        return new PersistenceExceptionTranslationPostProcessor();
//    }
}
