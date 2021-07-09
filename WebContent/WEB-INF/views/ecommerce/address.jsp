<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
		<c:choose>
			<c:when test="${addresses != null && addresses.size() != 0}">
				<c:forEach var="addr" items="${addresses}">
					<p>Stato: ${addr.state}</p>
					<p>Città: ${addr.city}</p>
					<p>Provincia: ${addr.province}</p>
					<p>CAP: ${addr.cap}</p>
					<p>Indirizzo: ${addr.address}</p>
					<br><br>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<p>Non hai inserito alcun indirizzo.</p>
			</c:otherwise>
		</c:choose>
		
		<form action="${pageContext.request.contextPath}/my-addresses" method="POST">
			<input type="text" name="state" placeholder="Stato" autofocus required/>
			<br><br>
			<input type="text" name="city" placeholder="Città" autofocus required/>
			<br><br>
			<input type="text" name="province" placeholder="Provincia" autofocus required/>
			<br><br>
			<input type="text" name="cap" placeholder="CAP" autofocus required/>
			<br><br>
			<input type="text" name="address" placeholder="Indirizzo" autofocus required/>
			<br><br>
			<input type="submit" value="Aggiungi indirizzo">
		</form>
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>