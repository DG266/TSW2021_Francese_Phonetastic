package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.OrderBean;
import it.unisa.phonetastic.model.bean.OrderCompositionBean;
import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.AddressDAO;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.PaymentMethodDAO;
import it.unisa.phonetastic.model.dao.ProductDAO;

/**
 * Retrieves the products belonging to a specific order.
 * @author DG266
 *
 */
public class OrderDetailsControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static ProductDAO productModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();
	private static AddressDAO addressModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getAddressDAO();
	private static PaymentMethodDAO paymentMethodModel = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getPaymentMethodDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		OrderBean orderInfo = (OrderBean) request.getAttribute("orderInfo");
		
		try {
			for(OrderCompositionBean comp : orderInfo.getElements()) {
				ProductBean bean = new ProductBean();
				bean = productModel.retrieveProductByID(comp.getProductId());
				comp.setProductName(bean.getName());
			}
			
			request.setAttribute("orderAddress", addressModel.retrieveAddressByID(orderInfo.getCustomerId(), orderInfo.getAddressId()));
			request.setAttribute("orderPaymentMethod", paymentMethodModel.retrievePaymentMethodByID(orderInfo.getCustomerId(), orderInfo.getPaymentMethodId()));
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/orderDetails.jsp");
		dispatcher.forward(request, response);
	}
}
