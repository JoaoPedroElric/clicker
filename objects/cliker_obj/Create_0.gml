reciclagem = 0;
click = 1;
cps = 0;


escala_x = image_xscale;
escala_y = image_yscale;

global.gcps = false;
g_cps = global.gcps;

alarm[0] = room_speed * 3;

// criação dos produtos
produtos = [];

base_y = 10;
produtos_y = 0 + base_y;

// criando produtos
function cria_produtos(_qtd = 1) {
	for(var i = 0; i < _qtd; i++ ) {
		produtos[i] = instance_create_layer(0, 0, layer, produto_obj);
	}
}

function iniciar_produtos() {
	var lista = [
		[10, 0, 0],
		[100, 0, 0.5],
		[1500, 0, 8.5]
	];
	
	for(var i = 0; i < array_length(lista); i ++) {
		if(i < array_length(produtos)) {
			with(produtos[i]) {
				valor = lista[i][0];
				quantidade = lista[i][1];
				rps = lista[i][2];
			}
		}
	}
}

function rolagem() {
	//scroll os produtos 
	if(mouse_check_button(mouse_wheel_down())) {
		produtos_y += 20;	
	}
	if(mouse_check_button(mouse_wheel_up())) {
		produtos_y -= 20;
	}
	
	var _qtd = array_length(produtos);
	var _max = (64 * _qtd) + (20 * _qtd) + 20 - room_height;
	
	produtos_y = clamp(produtos_y, -_max, base_y);
}

// fazendo eles aparecer na tela
function gerencia_produtos() {
	
	rolagem();
	
	for(var i = 0; i < array_length(produtos); i++) {
		var _marg = 20;
		var _x = 480;	
		var _y = produtos_y + _marg + ((i * 60) + (i * _marg));
		produtos[i].x = _x;
		produtos[i].y = _y;
		
		with(produtos[i]) {
			x = _x;
			y = _y + sprite_height / 2;
		}
	}
}

cria_produtos(3);
iniciar_produtos();