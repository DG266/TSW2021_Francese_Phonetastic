package it.unisa.phonetastic.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.phonetastic.model.beans.UserBean;
import it.unisa.phonetastic.model.dao.DAOFactory;
import it.unisa.phonetastic.model.dao.UserDAO;

public class LoginControl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static UserDAO model = DAOFactory.getDAOFactory(DAOFactory.MYSQL).getUserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// CODE FOR TESTING PURPOSES ---- WILL BE FIXED
		// TODO clean up the code
		
		UserBean currentUser = (UserBean) request.getSession().getAttribute("currentSessionUser");
		
		String action = request.getParameter("action");
		
		if (action != null) {
			// if the user wants to logout, invalidate the session and go back to the
			// catalog page
			if (action.equalsIgnoreCase("logout")) {
				request.getSession().invalidate();
				response.sendRedirect("catalog");
			} 
			// if the user wants to log in, check if email and pwd are correct
			else if (action.equalsIgnoreCase("login")) {
				UserBean user = new UserBean();
				try {
					user = model.retrieveUserByEmailPwd(request.getParameter("email"), request.getParameter("pwd"));
					if (user.isValid()) {
						HttpSession session = request.getSession(true);
						session.setAttribute("currentSessionUser", user);
					} 
					response.sendRedirect("catalog");
				} catch (SQLException e) {
					System.out.println("Error: " + e.getMessage());
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
				try {
					model.insertUser(newUser);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				response.sendRedirect("login");
			}
		} 
		else if(currentUser != null && currentUser.isValid()) {
				response.sendRedirect("catalog");    // should be an error
		}
		else {
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockLoginPage.jsp");
				dispatcher.forward(request, response);
		}
	}
}

