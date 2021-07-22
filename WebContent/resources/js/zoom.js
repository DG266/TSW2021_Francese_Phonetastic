function imageZoom(imgID, resultID) {
	
	var img, lens, result, cx, cy;
	
	img = document.getElementById(imgID);
	result = document.getElementById(resultID);
	
	/* Crea la lente: */
	lens = document.createElement("DIV");
	lens.setAttribute("class", "img-zoom-lens");
	
	/* Inserisci la lente: */
	img.parentElement.insertBefore(lens, img);
	
	/* Calcola il ratio tra il DIV del risultato e la lente: */
	cx = result.offsetWidth / lens.offsetWidth;
	cy = result.offsetHeight / lens.offsetHeight;
	
	/* Imposta le proprietà del background relative al DIV risultato */
	result.style.backgroundImage = "url('" + img.src + "')";
	result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";
	
	/* Esegui una funzione quando l'utente muove il cursore sopra l'immagine o sopra la lente*/
	lens.addEventListener("mousemove", moveLens);
	img.addEventListener("mousemove", moveLens);
	
	/* Fai la stessa cosa per i touch screen: */
	lens.addEventListener("touchmove", moveLens);
	img.addEventListener("touchmove", moveLens);
	

	img.addEventListener("mouseleave", function(){
		result.style.visibility = "hidden";
	});
	
	lens.addEventListener("mouseleave", function(){
		result.style.visibility = "hidden";
	});
	
	function moveLens(e) {
				
		var pos, x, y;
		
		/* Evita l'esecuzione di altre azioni che potrebbero avvenire passando con il mouse sull'img */
		e.preventDefault();
		
		/* Salva le coordinate x e y del cursore: */
		pos = getCursorPos(e);
		
		/* Calcola la posizione della lente: */
		x = pos.x - (lens.offsetWidth / 2);
		y = pos.y - (lens.offsetHeight / 2);
		
		/* Evita che la lente venga posizionata fuori dall'immagine: */
		if (x > img.width - lens.offsetWidth) { x = img.width - lens.offsetWidth; }
		if (x < 0) { x = 0; }
		if (y > img.height - lens.offsetHeight) { y = img.height - lens.offsetHeight; }
		if (y < 0) { y = 0; }
		
		//console.log("Lens(x,y): " + x + ", " + y);
		
		/* Imposta la posizione della lente: */
		lens.style.left = x + "px";
		lens.style.top = y + "px";
		
		/* Mostra ciò che la lente "vede": */
		result.style.backgroundPosition = "-" + (x * cx) + "px -" + (y * cy) + "px";
		result.style.visibility = "visible";
	}
	
	function getCursorPos(e) {
		
		var a, x = 0, y = 0;
		
		e = e || window.event;
		
		/* Ottieni le coordinate x e y dell'immagine: */
		a = img.getBoundingClientRect();
		
		/* Calcola le coordinate x e y (relative all'immagine) del cursore: */
		x = e.pageX - a.left;
		y = e.pageY - a.top;
		
		//console.log("Cursor(x,y): " + x + ", " + y);
		
		/* Tieni conto del page scrolling: */
		x = x - window.pageXOffset;
		y = y - window.pageYOffset;
		return { x: x, y: y };
	}
}

$(document).ready(function(){
	
	imageZoom("productImage", "zoomContainer"); 
});


