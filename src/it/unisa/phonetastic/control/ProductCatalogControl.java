package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class ProductCatalogControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Logger logger = Logger.getLogger("ProductCatalogControl.class");
		logger.setLevel(Level.OFF);
		
		// check if the cart already exists
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			logger.info("Cart doesn't exist. It will be created now.");
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		else logger.info("Cart already exists. Number of items (before doing anything): " + cart.getProducts().size());
		
		String action = request.getParameter("action");
		
		try {
			if(action != null) {
				if (action.equalsIgnoreCase("addCart")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.addProduct(model.retrieveProductByID(id));
				} 
				else if (action.equalsIgnoreCase("deleteCart")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.retrieveProductByID(id));
				} 
				// add more actions...
			}
		}
		catch(SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		logger.info("Number of items after action(" + action + "): " + cart.getProducts().size());
		
		// update the cart (in case "action" did something)
		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		
		String sort = request.getParameter("sort");
		
		try {
			request.removeAttribute("products");
			request.setAttribute("products", model.retrieveAllProducts(sort));
		} catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		// TODO Remember to use the real jsp
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockProductsCatalog.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doGet(request, response);
	}
}
