package cn.apple.action;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by THINK on 2016/3/11.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	@RequestMapping("/hello")
	@Secured("ROLE_dev")
	public String hello(){
		return "hello world!!";
	}
}
