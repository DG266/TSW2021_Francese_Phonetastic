package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;
import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class CartControl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		String productId = request.getParameter("id");
		
		try {
			if(action != null && productId != null) {
				
				int id = Integer.parseInt(request.getParameter("id"));
				ProductBean bean = model.retrieveProductByID(id);
				
				// check if the user deleted a product
				if (action.equalsIgnoreCase("deleteCart")) {
					cart.deleteProduct(bean);
				} 
				// check if the user changed the quantity of a specific product
				else if(action.equalsIgnoreCase("changeQuantity")) {
					String productQuantity = request.getParameter("quantity");
					if(productQuantity != null) {
						// check if there are enough products in stock
						int quantity = Integer.parseInt(productQuantity);
						if(quantity <= bean.getQuantity()) {
							cart.setQuantity(id, quantity);
							//bean.setQuantity(bean.getQuantity() - quantity);   
							//model.updateProduct(bean);
						}
						else {
							// TODO error: "you're asking too much"
						}
					}
				}
			}
		}
		catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		catch(NumberFormatException e) {
			System.out.println("Error:" + e.getMessage());
		}	
		
		request.setAttribute("cart", cart);
		
		// TODO Remember to use the real jsp
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockCart.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doGet(request, response);
	}
}
