package cn.apple.action;

import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by THINK on 2016/3/9.
 */
@RestController
@RequestMapping("/rest")
public class IndexController {
	@RequestMapping("/hello")
	@Secured("ROLE_dev")
	public String hello(){
		return "hello world!!";
	}
}
