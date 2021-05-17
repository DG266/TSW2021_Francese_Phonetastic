package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class ProductInfoControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String id = request.getParameter("id");
		int productId = -1;
		
		try {
			productId = Integer.parseInt(id);
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		try {
			request.setAttribute("product", model.retrieveProductByID(productId));
			
			String action = request.getParameter("action");
			
			if(action != null) {
				if(action.equalsIgnoreCase("addCart"));
				Cart cart = (Cart) request.getSession().getAttribute("cart");
				if(cart == null) {
					cart = new Cart();
				}
				cart.addProduct(model.retrieveProductByID(productId));
				request.getSession().setAttribute("cart", cart);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		// TODO Remember to use the real jsp
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockProductInfo.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
