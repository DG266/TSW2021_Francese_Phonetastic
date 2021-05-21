package it.unisa.phonetastic.control.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AdminAuthenticationFilter implements Filter{

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);
 
        boolean isLoggedIn = (session != null && session.getAttribute("currentSessionAdminUser") != null);
 
        String loginURI = httpRequest.getContextPath() + "/admin/login";
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("mockAdminLoginPage.jsp");
 
        if (isLoggedIn && (isLoginRequest || isLoginPage)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
            dispatcher.forward(request, response);
 
        } else if (isLoggedIn || isLoginRequest) {
            chain.doFilter(request, response);
 
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/MockPages/admin/mockAdminLoginPage.jsp");
            dispatcher.forward(request, response);
        }
	}
}
