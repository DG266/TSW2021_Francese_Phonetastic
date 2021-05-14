<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="mockHeader.jsp" %>

<%
	OrderBean order = (OrderBean) request.getAttribute("orderInfo");
	ArrayList<?> products = (ArrayList<?>)request.getAttribute("orderProducts");
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.phonetastic.model.beans.*"%>
	<head>
		<meta charset="UTF-8">
		<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
		<title>Dettagli ordine</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>Nome prodotto</th>
				<th>Costo</th>
				<th>Quantità</th>
				<th>IVA</th>
				
			</tr>
			<%
				for(OrderCompositionBean bean : order.getElements()){
			%>
			<tr>
				<%
					for(int i = 0; i < products.size(); i++){	
						ProductBean prod = (ProductBean) products.get(i);
						if(prod.getId() == bean.getProductId()){
							
				%>
						<td><%=prod.getName()%></td>			
				<%			
						}
					}
				%>
				<td><%=bean.getPrice()%></td>
				<td><%=bean.getQuantity()%></td>
				<td><%=bean.getIva()%></td>
			</tr>
			<%	
				}
			%>
		</table>
	</body>
</html>
<%@ include file="mockFooter.jsp" %>