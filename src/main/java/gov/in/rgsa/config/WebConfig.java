package gov.in.rgsa.config;

import gov.in.rgsa.intercepter.Captcha;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

@Configuration
//@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Value("${rgsa.captcha.height}")
    private String captchaHeight;
    @Value("${rgsa.captcha.width}")
    private String captchaWidth;
//    @Value("${rgsa.captcha.height}")
//    private String captchaHeight;
//    @Value("${rgsa.captcha.height}")
//    private String captchaHeight;
//    @Value("${rgsa.captcha.height}")
//    private String captchaHeight;
//    @Value("${rgsa.captcha.height}")
//    private String captchaHeight;


    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources", "classpath:/static/")
                .setCachePeriod(31556926);
    }

    // Servlets
    @Bean
    public ServletRegistrationBean<HttpServlet> captchaServlet() {
        ServletRegistrationBean<HttpServlet> servRegBean = new ServletRegistrationBean<>(new Captcha(), "/captchaImage");
        Map<String, String> initParams = new HashMap<>(2);
        initParams.put("height", captchaHeight);
        initParams.put("width", captchaWidth);
        servRegBean.setInitParameters(initParams);
        servRegBean.setLoadOnStartup(1);
        return servRegBean;
    }

    // Locale Support
//    @Bean
//    public LocaleResolver localeResolver() {
//        SessionLocaleResolver slr = new SessionLocaleResolver();
//        slr.setDefaultLocale(new Locale("en", "IN"));
//        return slr;
//    }



    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver()  {
        CookieLocaleResolver resolver= new CookieLocaleResolver();
        resolver.setCookieDomain("myAppLocaleCookie");
        // 60 minutes
        resolver.setCookieMaxAge(60*60);
        return resolver;
    }

    @Bean(name = "messageSource")
    public MessageSource getMessageResource()  {
        ReloadableResourceBundleMessageSource messageResource= new ReloadableResourceBundleMessageSource();

        // Read i18n/messages_xxx.properties file.
        // For example: i18n/messages_en.properties
        messageResource.setBasename("classpath:i18n/messages");
        messageResource.setDefaultEncoding("UTF-8");
        messageResource.setUseCodeAsDefaultMessage(true);
        return messageResource;
    }

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        LocaleChangeInterceptor localeInterceptor = new LocaleChangeInterceptor();
//        localeInterceptor.setParamName("lang");
//
//
//        registry.addInterceptor(localeInterceptor).addPathPatterns("/*");
//    }

    @Bean
    public ServletContextInitializer initializer() {
        return new ServletContextInitializer() {

            @Override
            public void onStartup(ServletContext servletContext) throws ServletException {

                servletContext.addListener(org.owasp.csrfguard.CsrfGuardServletContextListener.class);
                servletContext.addListener(org.owasp.csrfguard.CsrfGuardHttpSessionListener.class);

                // Context Params
                servletContext.setInitParameter("Owasp.CsrfGuard.Config", "WEB-INF/Owasp.CsrfGuard.properties");
                servletContext.setInitParameter("Owasp.CsrfGuard.Config.Print", "true");

                // Filters
                // -> Encoding filter
                FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("endcodingFilter", new CharacterEncodingFilter());
                encodingFilter.setInitParameter("encoding", "UTF-8");
                encodingFilter.setInitParameter("forceEncoding", "true");
            }

        };
    }

    @Bean
    public FilterRegistrationBean<org.owasp.csrfguard.CsrfGuardFilter> csrfGuardFilter() {

        FilterRegistrationBean<org.owasp.csrfguard.CsrfGuardFilter> registration = new FilterRegistrationBean<>();
        org.owasp.csrfguard.CsrfGuardFilter csrfGF = new org.owasp.csrfguard.CsrfGuardFilter();
        registration.setFilter(csrfGF);
        registration.addUrlPatterns("*.html");
        // registration.addInitParameter("paramName", "paramValue");
        registration.setName("CSRFGuard");
        // registration.setOrder(1);
        return registration;
    }

    @Bean
    public FilterRegistrationBean<org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter> hibernateFilter() {

        FilterRegistrationBean<org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter> registration = new FilterRegistrationBean<>();
        org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter openEntityManagerInViewFilter
                = new org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter();
        registration.setFilter(openEntityManagerInViewFilter);
        registration.addUrlPatterns("*.html", "/file/*");
        registration.setDispatcherTypes(EnumSet.of(DispatcherType.FORWARD, DispatcherType.REQUEST));
        registration.setName("hibernate");
        return registration;
    }
}
