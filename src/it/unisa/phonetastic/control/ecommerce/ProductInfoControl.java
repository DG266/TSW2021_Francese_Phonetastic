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

public class ProductInfoControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String id = request.getParameter("id");
		int productId = -1;
		
		try {
			productId = Integer.parseInt(id);
			request.setAttribute("product", model.retrieveProductByID(productId));
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/productInfo.jsp");
		dispatcher.forward(request, response);
	}
}
