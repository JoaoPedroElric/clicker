with(cliker_obj) {
	if(global.reciclagem >= other.valor) {
		global.reciclagem -= other.valor;
		other.valor *= 1.15;
		other.quantidade ++;
		global.cps += other.rps;
		
		
	}
}