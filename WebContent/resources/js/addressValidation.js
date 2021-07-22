function allLetter(name) {
	
	var letters = /^[A-Za-z]+$/;
	
	if(name.val().match(letters)) {
		return true;
	}
	else {
		name.focus();
		return false;
	}
}

function validateCap(cap) {
	
	var capRegexp = /^\d{5}[-\s]?(?:\d{4})?$/gm;
	
	if(cap.val().match(capRegexp)){
		return true;
	}
	else{
		cap.focus();
		return false;
	}
}

function alphanumeric(uadd) {
	//var letters = /^[0-9a-zA-Z]+$/
	var letters = /^\w+(\s\w+){2,}/;
	if(uadd.val().match(letters)) {
		return true;
	}
	else {
		uadd.focus();
		return false;
	}
}

function validateProvince(province) {
	var provinceRegexp = /^[A-Z]{2}$/;
	if(province.val().match(provinceRegexp)) {
		return true;
	}
	else {
		province.focus();
		return false;
	}
}


$(document).ready(function(){
	
	$(".addressForm").submit(function(event){
		
		$("#addressError").empty();
		
		var stateValid = allLetter($(".addressForm input[name=state]"));
		var cityValid = allLetter($(".addressForm input[name=city]"));
		var provinceValid = validateProvince($(".addressForm input[name=province]"));
		var capValid = validateCap($(".addressForm input[name=cap]"));
		var addressValid = alphanumeric($(".addressForm input[name=address]"));
		
		if(!stateValid || !cityValid || !provinceValid || !capValid || !addressValid) {
			
			var error = "";
			
			if(!stateValid){
				error = error + "Stato";
			}
			
			if(!cityValid){
				error = error + " Città";
			}
			
			if(!provinceValid){
				error = error + " Provincia";
			}
			
			if(!capValid){
				error = error + " CAP";
			}
			
			if(!addressValid){
				error = error + " Indirizzo";
			}
			
			$("#addressError").append("<h2>Ricontrolla i dati relativi all'indirizzo inseriti. (" + error +")<h2>");
			return false;
		}
	});
	
});