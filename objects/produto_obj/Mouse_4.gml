with(cliker_obj) {
	if(reciclagem >= other.valor) {
		reciclagem -= other.valor;
		click += 1;
		other.valor *= 1.2;
		other.quantidade ++;
		cps += other.rps;
	}
}