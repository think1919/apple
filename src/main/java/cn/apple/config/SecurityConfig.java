package cn.apple.config;

import cn.apple.config.interceptor.SSLInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.provisioning.JdbcUserDetailsManagerConfigurer;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.code.JdbcAuthorizationCodeServices;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.JdbcTokenStore;

import javax.sql.DataSource;

/**
 *
 * */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
@Order(Integer.MAX_VALUE)
public class SecurityConfig extends WebSecurityConfigurerAdapter {


	@Autowired
	DataSource dataSource;



	private int port=80;
	private int sslPort=443;

	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}



	@Override
	public void configure(HttpSecurity http) throws Exception {
		/*http
				.requestMatchers().antMatchers("*//**")
				.and()
				.formLogin()
				.and()
				.authorizeRequests()
				.anyRequest().authenticated();
		;
		http.requiresChannel()
				.anyRequest().requiresSecure()
				.and()
				.sessionManagement()
				.sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
				.maximumSessions(1);
		http.portMapper().http(port).mapsTo(sslPort);*/

	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		JdbcUserDetailsManagerConfigurer<AuthenticationManagerBuilder>
				configurer = auth.jdbcAuthentication();
		configurer
				.dataSource(dataSource)
				.usersByUsernameQuery("SELECT username,password,enabled  FROM sys_users where username = ?")
				.authoritiesByUsernameQuery("select u.username username,a.authorities_authority authority " +
						"from sys_users u,group_has_sys_users g,group_has_authorities a  " +
						"where u.username = g.sys_users_username " +
						"and g.group_id = a.group_id " +
						"and u.username = ?")
				.passwordEncoder(SimpleBeans.BCRYPT_ENCODER);
	}


	@Configuration
	@Order(1)
	@EnableResourceServer
	protected static class ResourceServer extends ResourceServerConfigurerAdapter {

		@Autowired
		private TokenStore tokenStore;


		@Override
		public void configure(ResourceServerSecurityConfigurer resources)
				throws Exception {
			resources.tokenStore(tokenStore);
		}

		@Override
		public void configure(HttpSecurity http) throws Exception {
			http
					.requestMatchers().antMatchers("/rest/**")
					.and().authorizeRequests()
					.anyRequest()
					.authenticated()
					.and().requiresChannel()
					.anyRequest().requiresSecure()
					.and()
					.sessionManagement()
					.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
					.maximumSessions(1);
		}
	}

	@Configuration
	@EnableAuthorizationServer
	protected static class OAuth2Config extends AuthorizationServerConfigurerAdapter {


		@Autowired
		private AuthenticationManager auth;
		@Autowired
		private DataSource dataSource;

		@Bean
		public JdbcTokenStore tokenStore() {
			return new JdbcTokenStore(dataSource);
		}

		@Bean
		protected AuthorizationCodeServices authorizationCodeServices() {
			return new JdbcAuthorizationCodeServices(dataSource);
		}


		@Override
		public void configure(AuthorizationServerSecurityConfigurer security)
				throws Exception {
			security.passwordEncoder(SimpleBeans.BCRYPT_ENCODER);
		}

		@Override
		public void configure(AuthorizationServerEndpointsConfigurer endpoints)
				throws Exception {
			endpoints.authorizationCodeServices(authorizationCodeServices())
					.authenticationManager(auth).tokenStore(tokenStore())
					.approvalStoreDisabled();
			endpoints.addInterceptor(new SSLInterceptor());
		}


		@Override
		public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
			clients.inMemory()
					.withClient("apple2003")
					.authorizedGrantTypes("refresh_token", "password")
					.accessTokenValiditySeconds(7200)
					.refreshTokenValiditySeconds(3600 * 24 * 7)
					.authorities("ROLE_CLIENT").scopes("read")
					.resourceIds("oauth2-resource")
					.secret("$2a$10$swGWt04PHMNgCq3oMXyYFuHNCUfxYRMmClEsqg7TVpqLkg8aOP8mq");
		}
	}
}
