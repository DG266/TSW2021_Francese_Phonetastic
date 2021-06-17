package it.unisa.phonetastic.control.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class ListProductsControl extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		try {
			request.setAttribute("products", model.retrieveAllProducts(null));
		}
		catch(SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/listProducts.jsp");
		dispatcher.forward(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
	}
	
}
