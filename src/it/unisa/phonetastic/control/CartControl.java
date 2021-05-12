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

public class CartControl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		
		try {
			if(action != null) {
				// check if the user deleted a product
				if (action.equalsIgnoreCase("deleteCart")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.retrieveProductByID(id));
				} 
			}
		}
		catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		// check if the user changed the quantity of a specific product
		String productId = request.getParameter("id");
		if(productId != null) {
			String productQuantity = request.getParameter("quantity");
			if(productQuantity != null) {
				int id = Integer.parseInt(productId);
				int quantity;
				try {
					quantity = Integer.parseInt(productQuantity);
				}
				catch(NumberFormatException e) {
					quantity = 1;
				}
				cart.setQuantity(id, quantity);
			}
		}
		
		request.setAttribute("cart", cart);
		
		// TODO Remember to use the real jsp
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockCart.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
