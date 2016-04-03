package cn.apple.config;

import cn.apple.config.sample.Props;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.SecureRandom;

/**
 * Created by THINK on 2016/3/9.
 */
@Configuration
public class SimpleBeans {

	public static final PasswordEncoder BCRYPT_ENCODER=new BCryptPasswordEncoder(10, new SecureRandom());


	@Bean
	@Qualifier("appUtil")
	public Props appUtil(Props props){
		return props;
	}


	public static void main(String[] args) {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder(10, new SecureRandom());
		String encode = bCryptPasswordEncoder.encode("1234");
		System.out.println(encode);
		int a=' ';
		System.out.println(a=='\u0020');
	}
}
