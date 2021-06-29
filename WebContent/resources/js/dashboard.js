// Commenterò in italiano per essere chiaro

document.querySelectorAll('.sidebar-submenu').forEach(e => {
    e.querySelector('.sidebar-menu-dropdown').onclick = (event) => {
    	
        event.preventDefault()  // fa in modo che cliccando sull'intestazione del menu non succeda nulla (ricorda che comunque è un href)
        e.querySelector('.sidebar-menu-dropdown .dropdown-icon').classList.toggle('active')  // cambia lo stato dell'intestazione del menu in active (inclusa la freccetta

        let dropdown_content = e.querySelector('.sidebar-menu-dropdown-content')   // selezione tutti gli elementi del menu in questione
        let dropdown_content_lis = dropdown_content.querySelectorAll('li')  // crea la lista di tutti gli elementi del menu in questione

        // calcola altezza del sottomenu (ovviamente se ho 4 elementi nel sottomenu, l'altezza avrà un valore,
        // se ne ho 5 ne avrà un altro...)
        let active_height = dropdown_content_lis[0].clientHeight * dropdown_content_lis.length

        // cambia lo stato della <ul> che compone il menu in attiva
        dropdown_content.classList.toggle('active')

        // se il menu è "attivo" imposta l'altezza appena calcolata, sennò settala a 0 (menu chiuso)
        dropdown_content.style.height = dropdown_content.classList.contains('active') ? active_height + 'px' : '0'
    }
})

let overlay = document.querySelector('.overlay')
let sidebar = document.querySelector('.sidebar')

document.querySelector('#mobile-toggle').onclick = () => {
    sidebar.classList.toggle('active')
    overlay.classList.toggle('active')
}

document.querySelector('#sidebar-close').onclick = () => {
    sidebar.classList.toggle('active')
    overlay.classList.toggle('active')
}

$(document).ready(function(){
	$('#open').trigger('click');
});