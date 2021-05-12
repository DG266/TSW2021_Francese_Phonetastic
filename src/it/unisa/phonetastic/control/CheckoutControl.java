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
import it.unisa.phonetastic.model.beans.OrderBean;
import it.unisa.phonetastic.model.beans.OrderCompositionBean;
import it.unisa.phonetastic.model.beans.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;

public class CheckoutControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		// TODO
		// This part needs A LOT of fixes + checks (it's just code for testing purposes)
		// If the user is not present/not valid, nothing happens to the cart(but the user still sees the checkout page)
		// We should "force" the user to register (in case he desires to buy something)
		
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
	
		if(cart != null && user != null) {
			// If the user (attribute of session) is valid, the cart (also an attribute of session)
			// gets "analyzed" and an order is created (and saved)
			if(user.isValid()) {
				OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
				OrderBean bean = new OrderBean();
				bean.setState('N');      // 'N' for "Not paid" (we will probably not use this field)
				bean.setCustomer_id(user.getId()); 
				
				List<OrderCompositionBean> elements = new ArrayList<OrderCompositionBean>();
				for(CartItem item : cart.getProducts()) {
					OrderCompositionBean comp = new OrderCompositionBean();
					comp.setProduct_id(item.getProduct().getId());
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
			}
		}
		
		// TODO Remember to use the real jsp
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockCheckout.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
