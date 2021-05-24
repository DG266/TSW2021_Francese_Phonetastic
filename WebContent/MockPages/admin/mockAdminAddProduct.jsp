<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Aggiungi un prodotto</title>
</head>
<body>
	<%@ include file="/MockPages/mockHeader.jsp" %>
	
	<h2>Aggiungi un prodotto</h2>
	
	<form action="" method="POST">
	
		<input type="text" name="name" placeholder="Nome" />
		<input type="number" name="price" placeholder="Prezzo" />
		<br><br>
		<textarea name="description" rows="5" cols="48" placeholder="Aggiungi una descrizione del prodotto..."></textarea>
		<br><br>
		<input type="number" name="quantity" placeholder="Quantità" />
		<input type="text" name="imagePath" placeholder="Percorso dell'immagine" />
		<br><br>
		<input type="submit" value="Aggiungi al catalogo">
	</form>
	
	<%@ include file="/MockPages/mockFooter.jsp"%>
</body>
</html>