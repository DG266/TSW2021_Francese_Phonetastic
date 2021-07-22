package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.PaymentMethodBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.PaymentMethodDAO;

public class PaymentMethodControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static PaymentMethodDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getPaymentMethodDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try {
			int userId = ((UserBean) request.getSession().getAttribute("currentSessionUser")).getId();
			request.removeAttribute("paymentMethods");
			request.setAttribute("paymentMethods", model.retrievePaymentMethodsByUserID(userId));
		} catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/paymentMethod.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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
				
				model.insertPaymentMethod(newPaymentMethod);
				
				request.removeAttribute("paymentMethods");
				request.setAttribute("paymentMethods", model.retrievePaymentMethodsByUserID(userId));
				
			} catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			} catch (NumberFormatException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/paymentMethod.jsp");
		dispatcher.forward(request, response);
	}
}
