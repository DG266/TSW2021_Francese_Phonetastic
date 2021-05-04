<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.phonetastic.model.ProductBean"%>
<%
    ProductBean p = (ProductBean) request.getAttribute("pInfo");
%>

<!DOCTYPE html>
<html>
    <head>
        <link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
        <meta charset="ISO-8859-1">
        <title>Dettagli Prodotto</title>
    </head>
    <body>
         <% 
             if(p.getId() != -1) {
         %>
        <h2>Nome: <%=p.getName()%></h2>
        <h2>Descrizione: <%=p.getDescription()%></h2>
        <h2>Prezzo: <%=p.getPrice()%></h2>
        <h2>Disponibili: <%=p.getQuantity()%></h2>
         <a href="info?action=addCart&id=<%=p.getId()%>" > Aggiungi al Carrello </a>
           <%
             } else{
           %>
           <h2>Prodotto non trovato</h2>
           <%
               }
           %>
        <h2> <a href="catalog"> Torna al Catalogo </a> </h2>

    </body>
</html>