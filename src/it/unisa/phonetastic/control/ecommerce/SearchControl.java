package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class SearchControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(ajax) {
			//JsonArray productsJson = new JsonArray();
			String productsJson = "";
			String query = request.getParameter("partialName");
			Collection<ProductBean> products = new ArrayList<>();
			
			if(query != null) {
				
				//System.out.println("SEARCH QUERY: " + query);
				
				try {
					products = model.retrieveProductsByPartialName(query);
				} catch(SQLException e) {
					e.printStackTrace();
				}
				
				/*
				for(ProductBean bean : products) {
					productsJson.add(bean.getName());
				}
				*/
				
				productsJson = new Gson().toJson(products);
			}
			
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(productsJson);
		}
		else {
			String query = request.getParameter("keyword");
			Collection<ProductBean> products = new ArrayList<>();
			
			if(query != null) {
				try {
					products = model.retrieveProductsByPartialName(query);
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
			
			request.setAttribute("foundProducts", products);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/searchProducts.jsp");
			dispatcher.forward(request, response);
		}
		
	}
}
