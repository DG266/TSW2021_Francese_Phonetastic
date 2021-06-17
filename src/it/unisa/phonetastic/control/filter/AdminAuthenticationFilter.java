package it.unisa.phonetastic.control.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.phonetastic.model.bean.UserBean;

public class AdminAuthenticationFilter implements Filter{

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);
 
        boolean isLoggedIn = (session != null && session.getAttribute("currentSessionUser") != null
        					 && ((UserBean) session.getAttribute("currentSessionUser")).isValid()
        					 && ((UserBean) session.getAttribute("currentSessionUser")).isAdmin());
 
        String loginURI = httpRequest.getContextPath() + "/login";    // Remember to use "/admin/login" if you decide to use the admin login page
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("loginPage.jsp");
 
		/*
		System.out.println("***********************\nADMIN LOGIN FILTER\ncontextPath = " + httpRequest.getRequestURI() + "\nisLoggedIn = " 
						   + isLoggedIn + "\nisLoginRequest = " + isLoginRequest
						   + "\nisLoginPage = " + isLoginPage);
		*/
        
        if (isLoggedIn && (isLoginRequest || isLoginPage)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin");
            dispatcher.forward(request, response);
 
        } else if (isLoggedIn || isLoginRequest) {
            chain.doFilter(request, response);
 
        } else {
        	/*
            RequestDispatcher dispatcher = request.getRequestDispatcher("../WEB-INF/views/ecommerce/loginPage.jsp");
            dispatcher.forward(request, response);
            */
        	
        	((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/login");  
        }
	}
}
