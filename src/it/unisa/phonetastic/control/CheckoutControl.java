package it.unisa.phonetastic.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.phonetastic.model.Cart;

public class CheckoutControl extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		// this servlet does nothing special, it empties the cart (if present)
		
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if(cart != null) {
			cart.emptyCart();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MockPages/mockCheckout.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
