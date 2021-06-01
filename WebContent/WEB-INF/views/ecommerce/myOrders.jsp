<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="resources/css/style.css" rel="stylesheet" type="text/css">
<title>I tuoi ordini</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Data</th>
			<th>Importo complessivo</th>
		</tr>
		<c:choose>
			<c:when test="${orders != null && orders.size() != 0}">
				<c:forEach var="bean" items="${orders}">
					<tr>
						<td>${bean.id}</td>
						<td><fmt:formatDate type="both" timeZone="UTC" value="${bean.lastUpdateDate}"/></td>
						<td>${bean.total}</td>
						<td>
							<form action="my-orders" method="POST">
								<input type="hidden" name="id" value="${bean.id}"> 
								<input type="submit" value="Dettagli">
							</form>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="6">Non hai effettuato alcun ordine.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	<%@ include file="footer.jsp"%>
</body>
</html>
