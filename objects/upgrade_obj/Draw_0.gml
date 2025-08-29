draw_self();
draw_set_font(fonte);
draw_set_color(c_black);

if(exibir) {
	var _x = bloco.x - 160;
	var _y = 0;
	draw_sprite_stretched(info_spr, 0, _x, _y, 160, 64);
	draw_text_ext_transformed(bloco.x -150, bloco.y - sprite_height / 2, info, 20, bloco.sprite_width , 0.7, 0.7, 0);
	
}



draw_set_color(-1);
draw_set_font(-1);
