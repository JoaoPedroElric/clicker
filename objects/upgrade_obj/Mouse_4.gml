with(cliker_obj) {
	if(global.reciclagem >= other.valor) {
		global.reciclagem -= other.valor;
		global.click ++;
		other.comprado = true;
		
		var index = -1;
		for (var i = 0; i < array_length(upgrades); i++) {
		    if (upgrades[i] == other.id) {
		        index = i;
		        break;
		    }
		}

		// remover este objeto do array
		if (index != -1) {
		    upgrades = array_delete_custom(upgrades, index);
		}
		
		with(other) {
			instance_destroy();
		}
		
		gerencia_upgrades();
	}
}