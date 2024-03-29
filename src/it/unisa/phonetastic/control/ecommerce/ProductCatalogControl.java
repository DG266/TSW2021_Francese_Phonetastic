package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class ProductCatalogControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {		
		String sort = request.getParameter("sort");
		String category = request.getParameter("category");
		String manufacturer = request.getParameter("manufacturer");
		
		try {
			if(category != null && manufacturer != null) {
				request.removeAttribute("products");
				request.setAttribute("products", model.retrieveProductsByCategoryAndManufacturer(category, manufacturer));
			}
			else if(category != null) {
				request.removeAttribute("products");
				request.setAttribute("products", model.retrieveProductsByCategoryName(category));
			}
			else if(manufacturer != null) {
				request.removeAttribute("products");
				request.setAttribute("products", model.retrieveProductsByManufacturer(manufacturer));
			}
			else {
				request.removeAttribute("products");
				request.setAttribute("products", model.retrieveAllProducts(sort));
			}
		}
		catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/productsCatalog.jsp");
		dispatcher.forward(request, response);
	}
}
