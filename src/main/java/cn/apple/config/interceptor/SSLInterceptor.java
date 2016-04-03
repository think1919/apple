package cn.apple.config.interceptor;

import cn.apple.config.adapter.HandlerAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by THINK on 2016/3/10.
 */
public class SSLInterceptor extends HandlerAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		boolean secure = request.isSecure();
		if(!secure){
			response.setStatus(403);
		}
		return secure;
	}
}
