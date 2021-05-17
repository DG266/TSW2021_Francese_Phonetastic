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
		if(currentUser != null) {
			if(currentUser.isValid()) {
				response.sendRedirect("catalog");
			}
		}
		else {
			UserBean user = new UserBean();
			
			// if the user wants to logout, invalidate the session and go back to the
			// catalog page
			String action = request.getParameter("action");
			if (action != null) {
				if (action.equalsIgnoreCase("logout")) {
					request.getSession().invalidate();
					response.sendRedirect("catalog");
				} else if (action.equalsIgnoreCase("login")) {
					try {
						user = model.retrieveUserByEmailPwd(request.getParameter("email"), request.getParameter("pwd"));
						if (user.isValid()) {
							HttpSession session = request.getSession(true);
							session.setAttribute("currentSessionUser", user);
							response.sendRedirect("catalog");
						} else {
							response.sendRedirect("catalog");
						}
					} catch (SQLException e) {
						System.out.println("Error: " + e.getMessage());
					}
				} else if (action.equalsIgnoreCase("register")) {
					UserBean b = new UserBean();

					String name = request.getParameter("firstName");
					String surname = request.getParameter("lastName");
					String email = request.getParameter("email");
					String pass = request.getParameter("pwd");

					b.setFirstName(name);
					b.setLastName(surname);
					b.setEmail(email);
					b.setPassword(pass);
					try {
						model.insertUser(b);
					} catch (SQLException e) {
						e.printStackTrace();
					}
					response.sendRedirect("login");
				}
			} else {
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockLoginPage.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
}
