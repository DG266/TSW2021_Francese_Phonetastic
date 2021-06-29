package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.cart.Cart;
import it.unisa.phonetastic.model.cart.CartItem;
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
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(ajax) {
		    List<CartItem> items = cart.getProducts();
		    String json = new Gson().toJson(items);
		    
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
		}
		else {
			request.setAttribute("cart", cart);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/cart.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String productId = request.getParameter("id");
		String action = request.getParameter("action");
		String productQuantity = request.getParameter("quantity");
		
		try {
			if(productId != null && action != null) {
				
				//System.out.println("PRODUCT ID: " + request.getParameter("id") + "\tACTION: " + request.getParameter("action") + "\tQUANTITY: " + request.getParameter("quantity"));
				
				int id = Integer.parseInt(request.getParameter("id"));
				ProductBean bean = model.retrieveProductByID(id);
				
				// check if the user added a product
				if (action.equalsIgnoreCase("addCart")) {
					cart.addProduct(model.retrieveProductByID(id));
				} 
				// check if the user deleted a product
				else if (action.equalsIgnoreCase("deleteCart")) {
					cart.deleteProduct(bean);
				} 
				// check if the user changed the quantity of a specific product
				else if(action.equalsIgnoreCase("changeQuantity")) {
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
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(ajax) {
			// DO NOTHING
		}
		else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/cart.jsp");
			dispatcher.forward(request, response);
		}
		
	}
}
