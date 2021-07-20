package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.cart.Cart;
import it.unisa.phonetastic.model.cart.CartItem;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class CartControl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	private static int MAX_QUANTITY = -1;
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	public void init() {
		MAX_QUANTITY = Integer.parseInt(getServletContext().getInitParameter("max-quantity"));
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(ajax) {
			
			if(request.getParameter("updatePrice") != null) {
				
				BigDecimal totalWithIva = cart.getTotalWithIva();
				BigDecimal totalDiscount = cart.getTotalDiscount();
				BigDecimal totalWithDiscountAndIva = cart.getTotalWithDiscountAndIva();
				
				NumberFormat currency = NumberFormat.getCurrencyInstance();
	
				JsonObject json = new JsonObject();
				
				json.addProperty("cartSize", cart.getProducts().size());
				json.addProperty("totalWithIva", currency.format(totalWithIva));
				json.addProperty("totalDiscount", currency.format(totalDiscount));
				json.addProperty("totalWithDiscountAndIva", currency.format(totalWithDiscountAndIva));

				
				response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json.toString());
			}
			else {
			    List<CartItem> items = cart.getProducts();
			    String json = new Gson().toJson(items);
			    
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			}
		}
		else {
			//request.setAttribute("cart", cart);
			
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
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		boolean inStock = true;
		
		// check if the user wants to empty the cart
		if (action.equalsIgnoreCase("deleteCart")) {
			cart.emptyCart();
		} 
		
		try {
			if(productId != null && action != null && productQuantity != null) {
				
				//System.out.println("PRODUCT ID: " + request.getParameter("id") + "\tACTION: " + request.getParameter("action") + "\tQUANTITY: " + request.getParameter("quantity"));
				
				int id = Integer.parseInt(request.getParameter("id"));
				int quantity = Integer.parseInt(productQuantity);
				ProductBean bean = model.retrieveProductByID(id);
				
				// check if the user added a product
				if (action.equalsIgnoreCase("addCart")) {
					
					int ordered = cart.getOrderedProductQuantity(id);  
					if(ordered + quantity <= bean.getQuantity() && ordered + quantity <= MAX_QUANTITY) {				
						cart.addProduct(bean);
					}
					else {
						inStock = false;
					}
				} 
				// check if the user changed the quantity of a specific product
				else if(action.equalsIgnoreCase("changeQuantity")) {
					
					if(quantity <= 0) {
						cart.deleteProduct(bean);
					}
					
					// check if there are enough products in stock
					if(quantity <= bean.getQuantity() && quantity <= MAX_QUANTITY) {
						cart.setQuantity(id, quantity);
					}
					else {
						inStock = false;
					}
				}
				
				// after everything is done, update the cart
				request.getSession().setAttribute("cart", cart);
			}
		}
		catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		catch(NumberFormatException e) {
			System.out.println("Error:" + e.getMessage());
		}	
		
		//request.setAttribute("cart", cart); 
		
		// if this is an ajax request...
		if(ajax) {
			// If there aren't enough products in stock...
			if(!inStock) {
				response.setStatus(400);
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write("La quantità richiesta non è disponibile.");
			}
			// DO NOTHING
		}
		else {
			if(!inStock) {
				request.setAttribute("errorMessage", "La quantità richiesta non è disponibile.");
			}
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/cart.jsp");
				dispatcher.forward(request, response);
		}
	}
}
