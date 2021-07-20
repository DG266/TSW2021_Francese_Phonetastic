package it.unisa.phonetastic.control.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class UpdateProductControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String id = request.getParameter("id");
		if(id != null) {
			try {
				request.setAttribute("productToUpdate", model.retrieveProductByID(Integer.parseInt(id)));
			}
			catch(SQLException e) {
				System.out.println("Database error: " + e.getMessage());
			}
			catch(NumberFormatException e) {
				System.out.println("Parsing error: " + e.getMessage());
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/updateProduct.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		request.setAttribute("success", false);
		
		if(request.getParameter("id") != null 
				&& request.getParameter("name") != null
				&& request.getParameter("manufacturer") != null 
				&& request.getParameter("description") != null 
				&& request.getParameter("quantity") != null 
				&& request.getParameter("price") != null 
				&& request.getParameter("iva") != null 
				&& request.getParameter("discount") != null
				&& request.getParameter("insertion-date") != null
				&& request.getParameter("image") != null) {
			
			ProductBean updatedProduct = new ProductBean();
			try {
				updatedProduct.setId(Integer.parseInt(request.getParameter("id")));
				updatedProduct.setName(request.getParameter("name"));
				updatedProduct.setManufacturer(request.getParameter("manufacturer"));
				updatedProduct.setDescription(request.getParameter("description"));
				updatedProduct.setQuantity(Integer.parseInt(request.getParameter("quantity")));
				updatedProduct.setPrice(new BigDecimal(request.getParameter("price")));
				updatedProduct.setIva(new BigDecimal(request.getParameter("iva")));   
				updatedProduct.setDiscount(new BigDecimal(request.getParameter("discount")));
				updatedProduct.setInsertionDate(Timestamp.valueOf(request.getParameter("insertion-date")));
				updatedProduct.setImagePath(request.getParameter("image"));
				if(request.getParameter("is-deleted") != null) {
					updatedProduct.setDeleted(true);
				}
				else {
					updatedProduct.setDeleted(false);
				}
				
				model.updateProduct(updatedProduct);
				
				request.setAttribute("success", true);
			}
			catch(SQLException e) {
				System.out.println("Database error: " + e.getMessage());
				e.printStackTrace();
			}
			catch(NumberFormatException e) {
				System.out.println("Parsing error: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/updateProduct.jsp");
		dispatcher.forward(request, response);
	}
}
