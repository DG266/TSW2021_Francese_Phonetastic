package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.AddressBean;
import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.AddressDAO;
import it.unisa.phonetastic.model.dao.DAOFactory;

public class AddressControl extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	private static AddressDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getAddressDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	
		try {
			int userId = ((UserBean) request.getSession().getAttribute("currentSessionUser")).getId();
			request.removeAttribute("addresses");
			request.setAttribute("addresses", model.retrieveAddressesByUserID(userId));
		} catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/address.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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
				
				model.insertAddress(newAddress);
				
				request.removeAttribute("addresses");
				request.setAttribute("addresses", model.retrieveAddressesByUserID(userId));
				
			} catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
				e.printStackTrace();
			}
		
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/address.jsp");
		dispatcher.forward(request, response);
	}
}
