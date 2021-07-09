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

public class AuthenticationFilter implements Filter{

	private HttpServletRequest httpRequest;
	
	private static final String[] loginRequiredURLs = {
			"my-account", "my-addresses", "my-orders", "finalize-order", "checkout"
	};
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		httpRequest = (HttpServletRequest) request;
		
		String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
		
		if (path.startsWith("/admin/")) {
            chain.doFilter(request, response);
            return;
        }
		
		HttpSession session = httpRequest.getSession(false);
		
		boolean isLoggedIn = (session != null && session.getAttribute("currentSessionUser") != null 
							 && ((UserBean) session.getAttribute("currentSessionUser")).isValid());
		
		String loginURI = httpRequest.getContextPath() + "/login";
		boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
		boolean isLoginPage = httpRequest.getRequestURI().endsWith("loginPage.jsp");   // TODO Remember to modify this one
		
		/*
		System.out.println("***********************\nUSER LOGIN FILTER\ncontextPath = " + httpRequest.getRequestURI() + "\nisLoggedIn = " 
						   + isLoggedIn + "\nisLoginRequest = " + isLoginRequest
						   + "\nisLoginPage = " + isLoginPage);
		*/
		
		if(isLoggedIn && (isLoginRequest || isLoginPage)) {
			//System.out.println("AUTHENTICATION FILTER: User wants to login, but he's already logged in. Back to homepage.");
			//httpRequest.getRequestDispatcher("/").forward(request, response);
			((HttpServletResponse) response).sendRedirect("./");
		}
		else if(!isLoggedIn && isLoginRequired()) {
			//System.out.println("AUTHENTICATION FILTER: User must login to see this page. Going to login page.");
            RequestDispatcher dispatcher = httpRequest.getRequestDispatcher("/WEB-INF/views/ecommerce/loginPage.jsp");
            dispatcher.forward(request, response);
		}
		else {
			//System.out.println("AUTHENTICATION FILTER: Everything's okay.");
			chain.doFilter(request, response);
		}
	}
	
    private boolean isLoginRequired() {
        String requestURL = httpRequest.getRequestURL().toString();
        //System.out.println("REQUEST -----> " + requestURL);
 
        for (String loginRequiredURL : loginRequiredURLs) {
            if (requestURL.contains(loginRequiredURL)) {
                return true;
            }
        }
 
        return false;
    }
}
