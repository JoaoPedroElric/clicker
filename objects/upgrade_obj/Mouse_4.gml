//atribuindo upgrade
with(cliker_obj) {
	if(global.reciclagem >= other.valor && other.disponivel) {
		global.reciclagem -= other.valor;
		global.click ++;
		other.comprado = true;
		
		show_debug_message(other.index);	
		
		// pegando o index
		var p = produtos[other.index];
		p.rps *= upgrade_obj.mult;
		p.rps_t = p.rps;
		p.descricao = "Gera " + string(p.rps_t) + " rps";
		global.cps = 0;
		//calculando o rps total e atribuindo no cps
		for (var i = 0; i < array_length(produtos); i++) {
		    global.cps += (produtos[i].rps_t * produtos[i].quantidade);
		}
				
		//ideia de fazer uma copia da array para re ordenar ela
			
		//var index = -1;
		//for (var i = 0; i < array_length(upgrades); i++) {
		//    if (upgrades[i] == other.id) {
		//        index = i;
		//        break;
		//    }
		//}

		// remover este objeto do array
		//if (index != -1) {
		    //upgrades = array_delete_custom(upgrades, index);
			
		//}
		
		with(other) {
			visible = false;
		}
		
		gerencia_upgrades();
	}
}