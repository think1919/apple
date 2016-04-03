package cn.apple.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.ignoreAcceptHeader(true).defaultContentType(
				MediaType.APPLICATION_JSON_UTF8);
	}

	@Bean(name = "viewResolver")
	public ViewResolver contentNegotiatingViewResolver(
			ContentNegotiationManager manager,
			ViewResolver jsonViewResolver,
			ViewResolver jspViewResolver
	) {
		ContentNegotiatingViewResolver resolver = new ContentNegotiatingViewResolver();
		resolver.setContentNegotiationManager(manager);
		List<ViewResolver> resolvers = new ArrayList<ViewResolver>();
		resolvers.add(jsonViewResolver);
		resolvers.add(jspViewResolver);
		resolver.setViewResolvers(resolvers);
		return resolver;
	}
	@Bean
	public ViewResolver jsonViewResolver() {
		return new JsonViewResolver();
	}
	@Bean
	public ViewResolver jspViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/jsp/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}
	public static class JsonViewResolver implements ViewResolver{

		@Override
		public View resolveViewName(String viewName, Locale locale) throws Exception {
			MappingJackson2JsonView view = new MappingJackson2JsonView();
			view.setPrettyPrint(true);
			return view;
		}

	}
}
