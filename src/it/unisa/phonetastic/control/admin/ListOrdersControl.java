package it.unisa.phonetastic.control.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.OrderDAO;

public class ListOrdersControl extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	private static OrderDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getOrderDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String sort = request.getParameter("sort");
		
		try {
			request.removeAttribute("orders");
			request.setAttribute("orders", model.retrieveAllOrders(sort));
		}
		catch(SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/listOrders.jsp");
		dispatcher.forward(request, response);
		
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String startDate = request.getParameter("start-date");
		String endDate = request.getParameter("end-date");
		
		String customerId = request.getParameter("customer-id");

		try {
			request.removeAttribute("orders");
			if(startDate != null && endDate != null) {
				request.setAttribute("orders", model.retrieveAllOrders(null, Date.valueOf(startDate), Date.valueOf(endDate)));
			}
			else if(customerId != null){
				request.setAttribute("orders", model.retrieveOrdersByUserID(Integer.parseInt(customerId)));
			}
		}
		catch(NumberFormatException e) {
			System.out.println("Error: " + e.getMessage());
		}
		catch(SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
		
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/listOrders.jsp");
		dispatcher.forward(request, response);
	}

}
