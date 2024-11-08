package com.com.com.Config;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CorsFilter implements Filter {
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 초기화 작업
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // CORS 설정
        httpResponse.setHeader("Access-Control-Allow-Origin", "http://localhost:3000"); // 허용할 도메인
        httpResponse.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS"); // 허용할 메서드
        httpResponse.setHeader("Access-Control-Allow-Headers", "*"); // 허용할 헤더
        httpResponse.setHeader("Access-Control-Allow-Credentials", "true"); // 쿠키 인증 허용 여부
        
        // 다음 필터로 요청 전달
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 정리 작업
    }
}
