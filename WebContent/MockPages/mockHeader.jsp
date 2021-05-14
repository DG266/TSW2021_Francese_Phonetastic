<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="it.unisa.phonetastic.model.beans.UserBean"%>

<header>
	<a href="catalog"> <img class="a" border="0" alt="doggo"
		src="./Images/LogoImage/pp.gif" width="300" height="300"></a>

	<h2>
		<div class="c">
			<p class="c">BENVENUTI SU PHONETASTIC!</p>
			<a href="cart"> <img class="" border="0" alt="cart"
				src="./Images/LogoImage/cart.png" width="80" height="80"></a>


			<%
				UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
				if (currentUser == null || !currentUser.isValid()) {
			%>
			<a href="login"> 
				<img class="" border="0" alt="login" src="./Images/LogoImage/dani.png" width="200" height="80">
			</a>

			<%
				} else {
			%>
			<a href="my-orders"> 
				<img class="" border="0" alt="my-orders" src="./Images/myOrders.png" width="70" height="70">
			</a>
			<a href="login?action=logout"> 
				<img class="" border="0" alt="logout" src="./Images/LogoImage/logout.png" width="80" height="80">
			</a>
			<%
				}
			%>
		</div>
	</h2>
</header>
