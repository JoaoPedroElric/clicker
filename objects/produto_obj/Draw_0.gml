draw_self();
draw_set_font(fonte);

draw_set_valign(1);
draw_set_halign(1);

draw_sprite(quantidade_spr, 1, x + 110, y);
draw_text(x + 110, y, quantidade);
draw_text(x + 45, y, valor);

draw_set_valign(-1);
draw_set_halign(-1);
draw_set_font(-1);