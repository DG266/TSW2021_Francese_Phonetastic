package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.AddressBean;
import it.unisa.phonetastic.model.bean.PaymentMethodBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.AddressDAO;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.PaymentMethodDAO;

public class FinalizeOrderControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static AddressDAO addressModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getAddressDAO();
	private static PaymentMethodDAO paymentMethodModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getPaymentMethodDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		if(user != null && user.isValid()) {
			
			try {
				Collection<AddressBean> addresses = addressModel.retrieveAddressesByUserID(user.getId());
				request.setAttribute("userAddresses", addresses);
				
				Collection<PaymentMethodBean> paymentMethods = paymentMethodModel.retrievePaymentMethodsByUserID(user.getId());
				request.setAttribute("userPaymentMethods", paymentMethods);
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/checkout.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		// Check if the user filled the address form (this happens when the user wants to
		// finalize an order but he has no address saved)
		if(request.getParameter("state") != null 
				&& request.getParameter("city") != null 
				&& request.getParameter("province") != null 
				&& request.getParameter("cap") != null 
				&& request.getParameter("address") != null) {
			
			AddressBean newAddress = new AddressBean();
			
			try{
				int userId = ((UserBean) request.getSession().getAttribute("currentSessionUser")).getId();
				
				newAddress.setUserId(userId);
				
				newAddress.setState(request.getParameter("state"));
				newAddress.setCity(request.getParameter("city"));
				newAddress.setProvince(request.getParameter("province"));
				newAddress.setCap(request.getParameter("cap"));
				newAddress.setAddress(request.getParameter("address"));
				
				addressModel.insertAddress(newAddress);
				
				request.setAttribute("new-address", 1);
				
			} catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		
		// Check if the user filled the payment method form (this happens when the user wants to
		// finalize an order but he has no payment method saved)
		if(request.getParameter("card-number") != null 
				&& request.getParameter("exp-month") != null 
				&& request.getParameter("exp-year") != null 
				&& request.getParameter("cvv") != null) {
			
			PaymentMethodBean newPaymentMethod = new PaymentMethodBean();
			
			try{
				int userId = ((UserBean) request.getSession().getAttribute("currentSessionUser")).getId();
				
				newPaymentMethod.setUserId(userId);
				
				String expMonth = request.getParameter("exp-month");
				String expYear = request.getParameter("exp-year");
				
				newPaymentMethod.setCardNumber(request.getParameter("card-number"));
				newPaymentMethod.setExpiryDate(Date.valueOf("20" + expYear + "-" + expMonth + "-01"));   // THIS IS SO BAD, FORGIVE ME -DG266
				newPaymentMethod.setCvv(Integer.parseInt(request.getParameter("cvv")));
				
				paymentMethodModel.insertPaymentMethod(newPaymentMethod);
				
				request.setAttribute("new-payment-method", 1);
				
			} catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			} catch (NumberFormatException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/checkout");
		dispatcher.forward(request, response);
	}
}
