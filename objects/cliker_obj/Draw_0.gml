draw_self();
draw_set_font(fonte);
var inst = instance_create_layer(x, y - sprite_height / 2, "Instances", popup_obj);

inst.vel_x = random_range(-10,10);
inst.vel_y = random_range(-3,-4);

draw_set_valign(1);
draw_set_halign(1);

draw_text(x, y - 90, global.reciclagem);
draw_text(x, y - 60, string_format(global.cps,1 , 2 ));

draw_set_font(-1);

randomize();

draw_set_valign(-1);
draw_set_halign(-1);
draw_set_font(-1);