image_xscale = lerp(image_xscale, escala_x, .1);
image_yscale = lerp(image_yscale, escala_y, .1);



if(keyboard_check(vk_space)) {
	global.reciclagem += global.click;
}

if(keyboard_check(ord("S"))) {
	save_game();	
}

