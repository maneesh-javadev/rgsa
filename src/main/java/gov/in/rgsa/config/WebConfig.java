package gov.in.rgsa.config;

import gov.in.rgsa.intercepter.AuditTrailIntercepter;
import gov.in.rgsa.intercepter.Captcha;
import gov.in.rgsa.intercepter.DevQuirksInterceptor;
import gov.in.rgsa.intercepter.VisitorCountInterceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.MappedInterceptor;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import javax.servlet.DispatcherType;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableAspectJAutoProxy
//@EnableWebMvc
// @ImportResource({"Props/ApplicationContext.xml"})
public class WebConfig implements WebMvcConfigurer {

    @Value("${rgsa.captcha.height}")
    private String captchaHeight;
    @Value("${rgsa.captcha.width}")
    private String captchaWidth;

    static Logger logger = LoggerFactory.getLogger(WebConfig.class);


    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(getAuditTrailIntercepter());
        registry.addInterceptor(getVisitorCountInterceptor());
        registry.addInterceptor(getLocaleChangeInterceptor());
    }

    // Resource pointer == mvc:resources
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources", "classpath:/static/")
                .setCachePeriod(31556926);
    }

    // Welcome page pointer
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.html");
    }

    // ApplicationContext.xml loader
//    @Bean(name = "ContextLoaderListenerBean")
//    public ServletListenerRegistrationBean<ContextLoaderListener> appContextLoaderListener() {
//        ServletListenerRegistrationBean<ContextLoaderListener> listenerRegBean = new ServletListenerRegistrationBean<>();
//        listenerRegBean.setListener(new ContextLoaderListener());
//        return listenerRegBean;
//    }

    // Dispatcher servlet to map urls to html
    @Bean(name = "rgsaDispatcherServletBean")
    public ServletRegistrationBean<HttpServlet> rgsaDispatcherServlet() {
        DispatcherServlet dispatcherServlet = new DispatcherServlet();
        ServletRegistrationBean<HttpServlet> dispatcherBean
                = new ServletRegistrationBean<>(dispatcherServlet, "*.html", "/file/*");
        dispatcherBean.setName("rgsa");
        dispatcherBean.setLoadOnStartup(1);
        Map<String, String> initMap = new HashMap<>(1);
        initMap.put("contextConfigLocation", "/WEB-INF/configs/rgsa-servlet.xml");
        dispatcherBean.setInitParameters(initMap);
        return dispatcherBean;
    }

    // Captcha Servlet
    @Bean(name = "CaptchaServletBean")
    public ServletRegistrationBean<HttpServlet> captchaServlet() {
        ServletRegistrationBean<HttpServlet> servRegBean = new ServletRegistrationBean<>(new Captcha(), "/captchaImage");
        Map<String, String> initParams = new HashMap<>(2);
        initParams.put("height", captchaHeight);
        initParams.put("width", captchaWidth);
        servRegBean.setInitParameters(initParams);
        servRegBean.setLoadOnStartup(1);
        return servRegBean;
    }

    // Owasp context params
    @Bean
    public ServletContextInitializer initializer() {
        return (ServletContext servletContext) -> {
            servletContext.setInitParameter("Owasp.CsrfGuard.Config", "WEB-INF/configs/Owasp.CsrfGuard.properties");
            servletContext.setInitParameter("Owasp.CsrfGuard.Config.Print", "true");
        };
    }

    @Bean(name = "EncodingFilterBean")
    public FilterRegistrationBean<CharacterEncodingFilter> charEncodeFilter() {

        FilterRegistrationBean<CharacterEncodingFilter> registration = new FilterRegistrationBean<>();
        CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
        registration.setFilter(encodingFilter);
        registration.addInitParameter("encoding", "UTF-8");
        registration.addInitParameter("forceEncoding", "true");
        registration.setName("EncodingFilter");
        return registration;
    }

    // Owasp servlet context listener
    @Bean(name = "CSRFGuardServletListenerBean")
    public ServletListenerRegistrationBean<org.owasp.csrfguard.CsrfGuardServletContextListener> csrfGuardServletContextListener() {
        ServletListenerRegistrationBean<org.owasp.csrfguard.CsrfGuardServletContextListener> listenerRegBean = new ServletListenerRegistrationBean<>();
        listenerRegBean.setListener(new org.owasp.csrfguard.CsrfGuardServletContextListener());
        return listenerRegBean;
    }

    // Owasp http session listener
    @Bean(name = "CSRFGuardHttpListenerBean")
    public ServletListenerRegistrationBean<org.owasp.csrfguard.CsrfGuardHttpSessionListener> csrfGuardHttpSessionListener() {
        ServletListenerRegistrationBean<org.owasp.csrfguard.CsrfGuardHttpSessionListener> listenerRegBean = new ServletListenerRegistrationBean<>();
        listenerRegBean.setListener(new org.owasp.csrfguard.CsrfGuardHttpSessionListener());
        return listenerRegBean;
    }

    // Owasp CSRF guard filter
    @Bean(name = "CSRFGuardFilterBean")
    public FilterRegistrationBean<org.owasp.csrfguard.CsrfGuardFilter> csrfGuardFilter() {

        FilterRegistrationBean<org.owasp.csrfguard.CsrfGuardFilter> registration = new FilterRegistrationBean<>();
        org.owasp.csrfguard.CsrfGuardFilter csrfGF = new org.owasp.csrfguard.CsrfGuardFilter();
        registration.setFilter(csrfGF);
        registration.addUrlPatterns("*.html");
        // registration.addInitParameter("Owasp.CsrfGuard.Config", "WEB-INF/Owasp.CsrfGuard.properties");
        // registration.addInitParameter("Owasp.CsrfGuard.Config.Print", "true");
        // registration.addInitParameter("paramName", "paramValue");
        registration.setName("CSRFGuard");
        // registration.setOrder(1);
        return registration;
    }

    // Hibernate filter
    @Bean(name = "HibernateFilterBean")
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

    // Tiles Configuration
//    @Bean(name = "viewResolver")
//    public ViewResolver getViewResolver() {
//        UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
//
//        // TilesView 3
//        viewResolver.setViewClass(TilesView.class);
//
//        return viewResolver;
//    }
//
//    @Bean(name = "tilesConfigurer")
//    public TilesConfigurer getTilesConfigurer() {
//        TilesConfigurer tilesConfigurer = new TilesConfigurer();
//
//        // TilesView 3
//        tilesConfigurer.setDefinitions("/WEB-INF/tiles.xml");
//
//        return tilesConfigurer;
//    }

    // Interceptors
    @Bean(name = "VisitorCountInterceptorBean")
    public VisitorCountInterceptor getVisitorCountInterceptor(){
        return new VisitorCountInterceptor();
    }

    @Bean(name = "AuditTrailIntercepterBean")
    public AuditTrailIntercepter getAuditTrailIntercepter(){
        return new AuditTrailIntercepter();
    }

    @Bean(name = "LocaleChangeInterceptorBean")
    public LocaleChangeInterceptor getLocaleChangeInterceptor(){
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        return localeChangeInterceptor;
    }

    @Bean(name = "DevQuirksInterceptorBean")
    @ConditionalOnProperty(prefix = "rgsa.dev.user", name = "auto_inject")
    public DevQuirksInterceptor getDevQuirksInterceptor(){
        return new DevQuirksInterceptor();
    }

    @Bean(name = "MappedDevQuirksInterceptorBean")
    @ConditionalOnProperty(prefix = "rgsa.dev.user", name = "auto_inject")
    public MappedInterceptor devQuirksInterceptor() {
        logger.info("Dev interceptor hooked-in.");
        return new MappedInterceptor(new String[] {"/**"}, getDevQuirksInterceptor());
    }

}
