<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header>
	<a href="catalog"> 
		<img class="a" border="0" alt="doggo"src="./Images/LogoImage/logo.gif" width="300" height="300">
	</a>
	<div class="c">
		<p class="c">BENVENUTI SU PHONETASTIC!</p>
		<a href="cart"> 
			<img class="" border="0" alt="cart" src="./Images/cart.png" width="80" height="80">
		</a>
		<c:choose>
			<c:when test="${currentSessionUser == null || !currentSessionUser.valid}">
				<a href="login"> 
					<img class="" border="0" alt="login" src="./Images/loginButton.png" width="200" height="80">
				</a>
			</c:when>
			<c:otherwise>
				<a href="my-orders"> 
					<img class="" border="0" alt="my-orders" src="./Images/myOrders.png" width="70" height="70">
				</a>
				<a href="login?action=logout"> 
					<img class="" border="0" alt="logout" src="./Images/logoutButton.png" width="80" height="80">
				</a>
			</c:otherwise>
		</c:choose>
	</div>
</header>
