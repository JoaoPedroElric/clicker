var clicker = instance_find(cliker_obj, 0);
// vou ficar louco fazendo isso pqp
// tentar fazer o upgrade passar por baixo do teste_obj e do info_obj

//upgrade_obj < teste_obj < info_obj

//problema 1, como o info_obj ta sendo instanciado na upgrade ele fica com a sobreposição do upgrade
//por ser so um spr

if (clicker != noone) {
    //pega o produto que este upgrade precis
	
	// fazer o upgrade aparecer em ordem quando estiver disponivel
	
    var p = clicker.produtos[pdt_alvo];

    if (p.quantidade >= qtd_necessaria) {
		disponivel = true;
		with(cliker_obj) {
			gerencia_upgrades();
		}
        //habilitado
        draw_self();
        draw_set_font(fonte);
        draw_set_color(c_black);

        if (exibir) {
            var _x = bloco.x - 160;
            var _y = 0;
			
            draw_sprite_stretched(info_spr, 0, _x, _y, 160, 64); // aqui o problema 1
            draw_text_ext_transformed(bloco.x - 150, bloco.y - sprite_height / 2, info, 20, bloco.sprite_width , 0.7, 0.7, 0);
			draw_text_ext_transformed(bloco.x - 30, bloco.y - sprite_height / 2, converter(valor), 20, bloco.sprite_width, 0.6, 0.6 ,0);
        }

        draw_set_color(-1);
        draw_set_font(-1);
    }
    else {
        //desabilitado
        //draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_gray, 0.8);
    }
}
