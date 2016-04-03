package cn.apple.config.sample;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

/**
 * Created by THINK on 2016/3/17.
 */
@Component
@Scope(value = "session",proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Welcome {
	private String oops="oops!";

	public String getOops() {
		return oops;
	}
}
