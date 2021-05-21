package it.unisa.phonetastic.control;

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

public class OrderListControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		OrderBean order = new OrderBean();
		String id = request.getParameter("id");

		if(id != null) {
			try {
				order = model.retrieveOrderByID(Integer.parseInt(id));
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
			}
			request.setAttribute("orderInfo", order);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/order-details");
			dispatcher.forward(request, response);
		}
		else {
			try {
				request.setAttribute("orders", model.retrieveOrdersByUserID(user.getId()));
			} catch (SQLException e) {
				e.printStackTrace();
			}
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockMyOrders.jsp");
			dispatcher.forward(request, response);
		}
	}
}
