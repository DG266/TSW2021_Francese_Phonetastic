package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.phonetastic.model.bean.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.UserDAO;

public class LoginControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static UserDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getUserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		// CODE FOR TESTING PURPOSES ---- WILL BE FIXED
		// TODO clean up the code

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
							response.sendRedirect("catalog");
						}	
					} 
					else {
						response.sendRedirect("login");  // + error (bad pwd or email), try again
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
					
					model.insertUser(newUser);
					
					response.sendRedirect("login");
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

