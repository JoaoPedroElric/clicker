image_xscale = lerp(image_xscale, escala_x, .1);
image_yscale = lerp(image_yscale, escala_y, .1);

if(keyboard_check(vk_space)) {
	//reciclagem += click;
}

if(keyboard_check(ord("S"))) {
	save_game();	
}