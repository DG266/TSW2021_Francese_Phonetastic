<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="mockHeader.jsp" %>
    
<%
	Collection<?> orders = (Collection<?>) request.getAttribute("orders");
	if(orders == null) {
		// do something
	}
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.phonetastic.model.beans.*"%>
	<head>
		<meta charset="UTF-8">
		<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
		<title>I tuoi ordini</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Data</th>
				<th>Importo complessivo</th>
			</tr>
			<%
				if (orders != null && orders.size() != 0) {
					Iterator<?> it = orders.iterator();
					while (it.hasNext()) {
						OrderBean bean = (OrderBean) it.next();
			%>
			<tr>
				<td><%=bean.getId()%></td>
				<td><%=bean.getLastUpdateDate()%></td>
				<td><%=bean.getTotal()%></td>
				<td>
					<form action="my-orders" method="POST">
						<input type="hidden" name="id" value="<%=bean.getId()%>">
						<input type="submit" value="Dettagli">
					</form>
				</td>
			</tr>
			<%
					}
				} else {
			%>
			<tr>
				<td colspan="6">Non hai effettuato alcun ordine.</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>
<%@ include file="mockFooter.jsp" %>