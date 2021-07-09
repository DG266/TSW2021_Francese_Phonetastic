package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.OrderBean;
import it.unisa.phonetastic.model.bean.OrderCompositionBean;
import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.cart.Cart;
import it.unisa.phonetastic.model.cart.CartItem;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class CheckoutControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
	private static ProductDAO productModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/checkout.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		
		boolean error = false;
		
		if(cart != null) {
			// If the cart has something in it, analyze it and create a new order (and save it)
			if(cart.getProducts().size() > 0) {		
							
				try {
					// STEP 1: CHECK IF THE DESIRED QUANTITIES ARE AVAILABLE
					for(CartItem item : cart.getProducts()) {
						ProductBean product = productModel.retrieveProductByID(item.getProduct().getId());
	
						if(item.getQuantity() > product.getQuantity()) {
							error = true;
							response.sendError(500, "La quantità richiesta del prodotto con ID: " + item.getProduct().getId() + " non è più disponibile.");
						}
					}
					
					// STEP 2: MANAGE SHIPPING ADDRESS + PAYMENT METHOD
					OrderBean bean = new OrderBean();
					bean.setCustomerId(user.getId()); 
					
					if(request.getParameter("chosen-address") != null) {
						bean.setAddressId(Integer.parseInt(request.getParameter("chosen-address")));
					}
					// IMPORTANT: This happens when the user doesn't have any addresses saved inside the db
					// and he inserts data during the checkout phase.
					// Long story short, if he gave address data during checkout, this means that this is 
					// his first address. (happens in POST in FinalizeOrderControl)
					else if(request.getAttribute("new-address") != null) {
						bean.setAddressId(1);
					}
					else {
						error = true;
						response.sendError(500, "C'è stato un problema con la scelta dell'indirizzo di spedizione.");
					}
					
					if(request.getParameter("chosen-payment-method") != null) {
						bean.setPaymentMethodId(Integer.parseInt(request.getParameter("chosen-payment-method")));
					}
					else if(request.getAttribute("new-payment-method") != null) {
						bean.setPaymentMethodId(1);
					}
					else {
						error = true;
						response.sendError(500, "C'è stato un problema con la scelta del metodo di pagamento.");
					}
					
					// if something goes wrong, nothing will be updated inside the db
					if(!error) {
						// STEP 3: PREPARE THE ORDER AND DECREASE THE QUANTITIES
						List<OrderCompositionBean> elements = new ArrayList<OrderCompositionBean>();
						for(CartItem item : cart.getProducts()) {
							OrderCompositionBean comp = new OrderCompositionBean();
							comp.setProductId(item.getProduct().getId());
							comp.setQuantity(item.getQuantity());
							comp.setPrice(item.getProduct().getPrice());
							comp.setIva(item.getProduct().getIva());
							comp.setDiscount(item.getProduct().getDiscount());  // TODO Should consider coupon discount + product discount etc. Will fix later
							elements.add(comp);
								
							ProductBean toUp = productModel.retrieveProductByID(item.getProduct().getId());
							toUp.setQuantity(toUp.getQuantity() - item.getQuantity());
							productModel.updateProduct(toUp);
						}
						
						// STEP 4: SAVE DATA
						bean.setElements(elements);
						model.insertOrder(bean);
					
		
						// STEP 5: REMOVE ALL PRODUCTS FROM CART
						cart.emptyCart();
			
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/purchaseCompleted.jsp");
						dispatcher.forward(request, response);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} catch(NumberFormatException e) {
					e.printStackTrace();
				}
			}
			else {
				request.setAttribute("errorMessage", "Non puoi ordinare nulla, il tuo carrello è vuoto.");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/cart.jsp");
				dispatcher.forward(request, response);
			}
		}
		else {
			response.sendRedirect("login");
		}
	}
}
