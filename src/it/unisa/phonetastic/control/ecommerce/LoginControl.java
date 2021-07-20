package it.unisa.phonetastic.control.ecommerce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.UserDAO;

public class LoginControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static UserDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getUserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(ajax) {
			
			JsonObject json = new JsonObject();
			try {
				json.addProperty("isPresent", model.isEmailPresent(request.getParameter("email")));
			} catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
			}
		
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json.toString());
		}
		else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/loginPage.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String action = request.getParameter("action");
		
		if (action != null) {
			// if the user wants to log in, check if email and pwd are correct
			try {
				if (action.equalsIgnoreCase("login")) {
				
					UserBean user = new UserBean();
					user = model.retrieveUserByEmailPwd(request.getParameter("email"), request.getParameter("pwd"));
					if (user.isValid()) {
						//System.out.println("User found (isAdmin = " + user.isAdmin() + "): " + user.toString());
						HttpSession session = request.getSession(true);
						session.setAttribute("currentSessionUser", user);
						
						if(user.isAdmin()) {
							response.sendRedirect("admin");
						}
						else {
							response.sendRedirect("./");
						}	
					} 
					else {
						request.setAttribute("message", "L'indirizzo email e/o la password che hai inserito non corrispondono a nessunt account, riprova.");
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/loginPage.jsp");
						dispatcher.forward(request, response);
					}
				} 
				// if the user wants to register, create a new user and save the data (inside the db)
				else if (action.equalsIgnoreCase("register")) {
					UserBean newUser = new UserBean();
	
					String name = request.getParameter("firstName");
					String surname = request.getParameter("lastName");
					String email = request.getParameter("email");
					String pass = request.getParameter("pwd");
	
					newUser.setFirstName(name);
					newUser.setLastName(surname);
					newUser.setEmail(email);
					newUser.setPassword(pass);
					
					newUser.getRoles().add("Registered");
					
					boolean emailAlreadyPresent = model.isEmailPresent(email);
					
					if(!emailAlreadyPresent) {
						model.insertUser(newUser);
						request.setAttribute("message", "Adesso puoi effettuare il login con i tuoi dati.");
					}
					else {
						request.setAttribute("message", "L'email inserita è già presente.");
					}
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/loginPage.jsp");
					dispatcher.forward(request, response);
				}
				
			}catch (SQLException e) {
				System.out.println("Error: " + e.getMessage());
			}
		} 
		else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/ecommerce/loginPage.jsp");
			dispatcher.forward(request, response);
		}
	}
}

