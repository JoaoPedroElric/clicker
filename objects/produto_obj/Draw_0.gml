draw_self();
draw_set_font(fonte);

draw_set_valign(1);
draw_set_halign(1);

if(exibir){
	draw_set_color(c_black);
	draw_sprite_stretched(info_spr, 0, 480-160, mouse_y - 20, 160, 64);
	draw_text_ext_transformed(produto_obj.x - 120, mouse_y -10, descricao, 20, sprite_width, 0.6, 0.6, 0);
	draw_set_color(-1);
}

draw_sprite(quantidade_spr, 1, x + 110, y);
draw_text(x + 110, y, quantidade);
draw_text(x + 45, y, valor);

draw_set_valign(-1);
draw_set_halign(-1);
draw_set_font(-1);