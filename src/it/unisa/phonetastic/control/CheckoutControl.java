package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;
import it.unisa.phonetastic.model.CartItem;
import it.unisa.phonetastic.model.beans.OrderBean;
import it.unisa.phonetastic.model.beans.OrderCompositionBean;
import it.unisa.phonetastic.model.beans.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;

public class CheckoutControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		Logger logger = Logger.getLogger("CheckoutControl.class");
		logger.setLevel(Level.OFF);
		
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
	
		logger.info("Cart: " + cart + "\tUser: " + user);
		
		if(user != null && cart != null) {
			
			logger.info("User and cart are existent.");
			
			// If the user (attribute of session) is valid and the cart has something in it, the cart (also an attribute of session)
			// gets "analyzed" and an order is created (and saved)
			if(user.isValid() && cart.getProducts().size() > 0) {
				
				logger.info("User is valid and cart has " + cart.getProducts().size() + " products in it.");
				
				OrderBean bean = new OrderBean();
				bean.setCustomer_id(user.getId()); 
				
				List<OrderCompositionBean> elements = new ArrayList<OrderCompositionBean>();
				for(CartItem item : cart.getProducts()) {
					OrderCompositionBean comp = new OrderCompositionBean();
					comp.setProductId(item.getProduct().getId());
					comp.setQuantity(item.getQuantity());
					comp.setPrice(item.getProduct().getPrice());
					comp.setIva(item.getProduct().getIva());
					comp.setDiscount(item.getProduct().getDiscount());  // TODO Should consider coupon discount + product discount etc. Will fix later
					elements.add(comp);
				}
				
				bean.setElements(elements);
				
				// save data
				try {
					model.insertOrder(bean);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				// empties the cart
				cart.emptyCart();
				
				// TODO Remember to use the real jsp
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockCheckout.jsp");
				dispatcher.forward(request, response);
			}
			else {
				response.sendRedirect("catalog");
			}
		}
		else {
			response.sendRedirect("login");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
