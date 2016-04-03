package cn.apple.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by THINK on 2016/3/9.
 */
@Controller
@RequestMapping("/public")
public class PublicController {
	@RequestMapping("/hello")
	public String hello(){
		return "welcome! xx";
	}
}
