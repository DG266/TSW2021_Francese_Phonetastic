<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./catalog");	
		return;
	}
%>
    
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.phonetastic.model.beans.*"%>
	<%@ include file="mockHeader.jsp" %>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
		<title>Catalogo Phonetastic</title>
	</head>
	<body>
		<h2> <div class="b"> <p class="b">🐕🐕🐕Prodotti🐕🐕🐕</p> </div> </h2> 
		<table border="1">
			<tr>
				<th>ID <a href="catalog?sort=id">Ordina</a></th>
				<th>Nome <a href="catalog?sort=name">Ordina</a></th>
				<th>Descrizione <a href="catalog?sort=description">Ordina</a></th>
				<th>Azione</th>
			</tr>
			<%
				if (products != null && products.size() != 0) {
					Iterator<?> it = products.iterator();
					while (it.hasNext()) {
						ProductBean bean = (ProductBean) it.next();
			%>
			<tr>
				<td><%=bean.getId()%></td>
				<td><%=bean.getName()%></td>
				<td><%=bean.getDescription()%></td>
				<td>
					<a href="info?id=<%=bean.getId()%>">Dettagli</a><br>
					<a href="catalog?action=addCart&id=<%=bean.getId()%>">Aggiungi al carrello</a>
				</td>
			</tr>
			<%
					}
				} else {
			%>
			<tr>
				<td colspan="6">Non ci sono prodotti disponibili.</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
	<%@ include file="mockFooter.jsp" %>
</html>