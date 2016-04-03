package cn.apple.config.sample;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.SessionScope;

/**
 * Created by THINK on 2016/3/15.
 */
@Component
public class Props {
	private String appName;
	private String servletPath;

	SessionScope sessionScope;

	public String getServletPath() {
		return servletPath;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public void setServletPath(String servletPath) {
		this.servletPath = servletPath;
	}
}
