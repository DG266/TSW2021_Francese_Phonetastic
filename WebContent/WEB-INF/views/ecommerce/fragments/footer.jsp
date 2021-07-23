<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.phonetastic.model.cart.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

        <footer>
            <div class="container">
                <section class="footer-grid">
                    <div class="footer-grid-item">
                        <h3>Categorie</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/catalog?category=Smartphone">Smartphone</a></li>
                            <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch">Smartwatch</a></li>
                            <li><a href="${pageContext.request.contextPath}/catalog?category=Accessori">Accessori</a></li>
                            <!--  <li><a href="#">Usato</a></li> -->
                        </ul>
                    </div>
                    <div class="footer-grid-item">
                        <h3>UNISA - Progetto TSW 2021</h3>
                        <ul>
                            <!-- <li><a href="#">Chi siamo</a></li>  -->
                            <!-- <li><a href="#">Ordini</a></li> -->
                            <!-- <li><a href="#">Pagamenti</a></li> -->
                            <!-- <li><a href="#">Spedizioni</a></li> -->
                            <!-- <li><a href="#">Contattaci</a></li> -->
                            <li></li>
                            <li>Ferdinando Esposito 0512108686</li>
							<li>Daniele Galloppo 0512106955</li>
							<li>Antonio F. Monetti 0512108617</li>
                        </ul>
                    </div>
                    <div class="footer-grid-item">
                        <h3>Il tuo account</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/my-orders">I tuoi ordini</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-payment-methods">Metodi di pagamento</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-addresses">Indirizzi</a></li>
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
        <c:set var = "currentURL" value = "${requestScope['javax.servlet.forward.request_uri']}"/>
        
        <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/ecommerce.js"></script>
	    <c:if test="${fn:contains(currentURL, '/info')}">
	    	<script src="${pageContext.request.contextPath}/resources/js/zoom.js"></script>
	    </c:if>
	    <script src="${pageContext.request.contextPath}/resources/js/loginFormValidation.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/paymentMethodValidation.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/addressValidation.js"></script>
    </body>
</html>