package it.unisa.phonetastic.control.admin;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.phonetastic.model.bean.ProductBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.ProductDAO;

public class AddProductControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static String SAVE_DIR = "";
	
	private static ProductDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getProductDAO();

	public void init() {
		SAVE_DIR = getServletConfig().getInitParameter("image-upload");
	}
	
	private String extractFileName(Part part) {
		// content-disposition: form-data; name="file"; filename="file.txt";
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for(String s : items) {
			if(s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/addProduct.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("name") != null 
				&& request.getParameter("manufacturer") != null 
				&& request.getParameter("description") != null 
				&& request.getParameter("quantity") != null 
				&& request.getParameter("price") != null 
				&& request.getParameter("iva") != null 
				&& request.getParameter("discount") != null
				&& request.getPart("image") != null) {
			
			ProductBean newProduct = new ProductBean();
			try {
				newProduct.setName(request.getParameter("name"));
				newProduct.setManufacturer(request.getParameter("manufacturer"));
				newProduct.setDescription(request.getParameter("description"));
				newProduct.setQuantity(Integer.parseInt(request.getParameter("quantity")));
				newProduct.setPrice(new BigDecimal(request.getParameter("price")));
				newProduct.setIva(new BigDecimal(request.getParameter("iva"))); 
				newProduct.setDiscount(new BigDecimal(request.getParameter("discount")));
				
				// insertionDate, lastUpdateDate and isDeleted will be handled by the model
				// (well, they'll have default values: current_timestamp x 2 + false)
				
				// get the product images folder path (we need to save the image of the new product)
				String savePath = request.getServletContext().getRealPath("") + SAVE_DIR;
				//System.out.println(Save path = savePath);
				
				File fileSaveDir = new File(savePath);
				if(!fileSaveDir.exists()) {
					fileSaveDir.mkdir();
				}
				
				Part filePart = request.getPart("image");
				String fileName = extractFileName(filePart);
				
				if(fileName != null && !fileName.equals("")) {
					String fullPath = savePath + File.separator + fileName;
					filePart.write(fullPath);
					
					String imagePath = "." + File.separator + fullPath.substring(fullPath.indexOf("resources"), fullPath.length());
					newProduct.setImagePath(imagePath);
					
					//System.out.println(Full path = fullPath);
				}	
				
				model.insertProduct(newProduct);
				
				request.setAttribute("message", "Il prodotto è stato aggiunto con successo!");
				
				// TODO Handle more product pics
				
				/*
				for(Part part : request.getParts()) {
					String fileName = extractFileName(part);
					if(fileName != null && !fileName.equals("")) {
						String fullPath = savePath + File.separator + fileName;
						part.write(fullPath);
						
						String imagePath = "." + File.separator + fullPath.substring(fullPath.indexOf("resources"), fullPath.length());
						newProduct.setImagePath(imagePath);
						
						//System.out.println(Full path = fullPath);
					}			
				}
				*/
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/admin/addProduct.jsp");
		dispatcher.forward(request, response);
	}
	
}
