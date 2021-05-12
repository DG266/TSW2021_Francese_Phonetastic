<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	Cart cart = (Cart) request.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.math.BigDecimal,it.unisa.phonetastic.model.beans.ProductBean,it.unisa.phonetastic.model.Cart,it.unisa.phonetastic.model.CartItem"%>
	<head>
		<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Il tuo carrello</title>
	</head>
	<body>
		<a href="catalog">Catalogo</a>
		<% if(cart != null && cart.getProducts().size() != 0) { %>
		<h2>Carrello</h2>
		<table border="1">
			<tr>
				<th>Nome</th>
				<th>Quantità</th>
				<th>Prezzo</th>
				<th>Azione</th>
			</tr>
			<% List<CartItem> products = cart.getProducts(); 	
			   for(CartItem item : products) {
			%>
			<tr>
				<td><%=item.getProduct().getName()%></td>
				<td>
					<form action="cart" method="GET">
						<input type="text" name="quantity" size="2" value="<%=item.getQuantity()%>">
						<input type="hidden" name="id" value="<%=item.getProduct().getId()%>">
						<input type="submit" value="Aggiorna ordine">
					</form>
				</td>
				<td><%=item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()))%></td>
				<td><a href="cart?action=deleteCart&id=<%=item.getProduct().getId()%>">Rimuovi dal carrello</a></td>
			</tr>
			<%} %>
		</table>
		<br>	
		<form action="checkout" method="GET">
			<input type="submit" value="Procedi con il pagamento">
		</form>	
		<% } else {%>	
		<h2>Carrello vuoto</h2>
		<%} %>
	</body>
</html>