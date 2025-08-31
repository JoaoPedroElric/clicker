

if(global.reciclagem > valor / 5 or quantidade >= 1 or r_total ) {
	desenhando_produto();
	
	r_total = true;

} else {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_gray, 0.8);	
}