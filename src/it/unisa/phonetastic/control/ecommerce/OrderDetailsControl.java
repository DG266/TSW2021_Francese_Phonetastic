package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.OrderBean;
import it.unisa.phonetastic.model.bean.OrderCompositionBean;
import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

/**
 * Retrieves the products belonging to a specific order.
 * @author DG266
 *
 */
public class OrderDetailsControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		OrderBean orderInfo = (OrderBean) request.getAttribute("orderInfo");
		ArrayList<ProductBean> products = new ArrayList<>();
		
		for(OrderCompositionBean comp : orderInfo.getElements()) {
			ProductBean bean = new ProductBean();
			try {
				bean = model.retrieveProductByID(comp.getProductId());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			products.add(bean);
		}
		request.setAttribute("orderProducts", products);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/orderDetails.jsp");
		dispatcher.forward(request, response);
	}
}