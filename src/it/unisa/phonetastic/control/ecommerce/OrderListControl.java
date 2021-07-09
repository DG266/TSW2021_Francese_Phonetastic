package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.OrderBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;

/**
 * Retrieves the orders of a specific user.
 * @author DG266
 *
 */
public class OrderListControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		
		// prepare everything to show the details of a specific order
		if(request.getParameter("id") != null) {
			
			OrderBean order = new OrderBean();
			String id = request.getParameter("id");
			
			try {
				order = model.retrieveOrderByID(Integer.parseInt(id));
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
			}
			
			// This is needed, a customer should be able to check ONLY his orders
			if(order.getCustomerId() == user.getId()) {
				request.setAttribute("orderInfo", order);
			}
			else {
				request.setAttribute("orderInfo", new OrderBean());   // an empty OrderBean
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/order-details");
			dispatcher.forward(request, response);
		}
		// show the orders list
		else {
			try {
				request.setAttribute("orders", model.retrieveOrdersByUserID(user.getId()));
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/myOrders.jsp");
			dispatcher.forward(request, response);
		}
	}
}
