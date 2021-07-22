<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
	<div class="my-account-pages-title">
		<h2>Lista degli ordini effettuati</h2>
	</div>
	<div class="container">
		<div class="order-table-container">
			<table border="1">
				<tr>
					<th>Codice</th>
					<th>Data</th>
					<th>Importo complessivo</th>
					<th>Maggiori dettagli</th>
				</tr>
				<c:choose>
					<c:when test="${orders != null && orders.size() != 0}">
						<c:forEach var="bean" items="${orders}">
							<tr>
								<td>${bean.id}</td>
								<td><fmt:formatDate type="both" timeZone="UTC" value="${bean.lastUpdateDate}"/></td>
								<td>${bean.total} &euro;</td>
								<td>
									<form action="my-orders" method="GET">
										<input type="hidden" name="id" value="${bean.id}"> 
										<button type="submit" class="button-flat button-hover button-order-page">Dettagli</button>
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
		</div>
		
	</div>
		
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
