<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.phonetastic.model.cart.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

        <footer>
            <div class="container">
                <section class="footer-grid">
                    <div class="footer-grid-item">
                        <h3>Categorie</h3>
                        <ul>
                            <li><a href="#">Smartphone</a></li>
                            <li><a href="#">Smartwatch</a></li>
                            <li><a href="#">Accessori</a></li>
                            <li><a href="#">Usato</a></li>
                        </ul>
                    </div>
                    <div class="footer-grid-item">
                        <h3>La nostra azienda</h3>
                        <ul>
                            <li><a href="#">Chi siamo</a></li>
                            <li><a href="#">Ordini</a></li>
                            <li><a href="#">Pagamenti</a></li>
                            <li><a href="#">Spedizioni</a></li>
                            <li><a href="#">Contattaci</a></li>
                        </ul>
                    </div>
                    <div class="footer-grid-item">
                        <h3>Il tuo account</h3>
                        <ul>
                            <li><a href="#">Informazioni personali</a></li>
                            <li><a href="#">Restituzione prodotto</a></li>
                            <li><a href="#">Indirizzi</a></li>
                        </ul>
                    </div>
                    <div class="footer-grid-item">
                        <div class="contact">
                            <h3>Phonetastic</h3>
                            <ul class="contact-socials">
                                <li><a href="#">
                                        <i class='bx bxl-facebook-circle'></i>
                                    </a></li>
                                <li><a href="#">
                                        <i class='bx bxl-instagram-alt'></i>
                                    </a></li>
                                <li><a href="#">
                                        <i class='bx bxl-youtube'></i>
                                    </a></li>
                                <li><a href="#">
                                        <i class='bx bxl-twitter'></i>
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </section>
            </div>
        </footer>
        <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/ecommerce.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/loginFormValidation.js"></script>
    </body>
</html>