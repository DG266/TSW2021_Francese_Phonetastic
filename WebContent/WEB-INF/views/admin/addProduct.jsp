<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<c:import url="/WEB-INF/views/admin/header.jsp" />

	<!-- MAIN CONTENT -->
	<div class="main">
		<div class="main-header">
			<div class="mobile-toggle" id="mobile-toggle">
				<i class='bx bx-menu-alt-right'></i>
			</div>
			<div class="main-title">
				dashboard
			</div>
		</div>
		<div class="main-content">
			<br><br>
			<h2>Aggiungi un prodotto</h2>
			<form action="add-product" method="POST" enctype="multipart/form-data">
				<br><br>
				<input type="text" name="name" placeholder="Nome" autofocus required/>
				<br><br>
				<input type="number" name="price" placeholder="Prezzo" step="any" min="1" autofocus required/>
				<br><br>
				<input type="number" name="discount" placeholder="% Sconto" min="0" autofocus required/>
				<br><br>
				<input type="number" name="iva" placeholder="IVA" min="1" autofocus required/>
				<br><br>
				<textarea name="description" rows="5" cols="48" placeholder="Aggiungi una descrizione del prodotto..." autofocus required></textarea>
				<br><br>
				<input type="number" name="quantity" placeholder="Quantità" min="1" autofocus required/>
				<br><br>
				<label>Immagine:</label>
				<input type="file" name="image" autofocus required/>
				<br><br>
				<input type="submit" value="Aggiungi al catalogo">
			</form>
		</div>
	</div>

<c:import url="/WEB-INF/views/admin/footer.jsp" />
