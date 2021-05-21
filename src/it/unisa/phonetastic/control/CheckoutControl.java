package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;
import it.unisa.phonetastic.model.CartItem;
import it.unisa.phonetastic.model.bean.OrderBean;
import it.unisa.phonetastic.model.bean.OrderCompositionBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;

public class CheckoutControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		
		if(cart != null) {
			// If the cart has something in it, analyze it and create a new order (and save it)
			if(cart.getProducts().size() > 0) {		
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
			
				// TODO Update database quantities
				
				// empties the cart
				cart.emptyCart();
			
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
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doGet(request, response);
	}
}
