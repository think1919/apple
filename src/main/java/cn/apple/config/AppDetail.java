package cn.apple.config;

import cn.apple.config.sample.Props;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

/**
 * Created by THINK on 2016/3/14.
 */

@Configurable
public class AppDetail {
	@Autowired
	private Props props;

	public Props getProps() {
		return props;
	}
}
