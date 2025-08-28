global.reciclagem = 0;
total_produtos = 3;

reciclagem_total = global.reciclagem;
global.click = 1;
global.cps = 0;

alarm[1] = room_speed * 30;

escala_x = image_xscale;
escala_y = image_yscale;


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
		[10, 0, 0.1],
		[100, 0, 1],
		[1000, 0, 8]
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


function save_game() {
	var _file = file_text_open_write("save.json");
	
	// saber oq salvar
	var _struct = 
	{
		reciclagem  : global.reciclagem,
		click		: global.click,
		cps			: global.cps,
		produtos    : []
	};
	//show_message(_struct);
	
	for(var _i = 0; _i < total_produtos; _i++) {
		with(produtos[_i]) {
			array_push(_struct.produtos, {
				valor		: valor,
				quantidade  : quantidade,
				rps			: rps
			});
		}
	}
	
	//convertendo em string
	var _string = json_stringify(_struct);
	
	file_text_write_string(_file, _string);
	
	file_text_close(_file);
	
}

function load_game() {
	if(!file_exists("save.json")) {
		iniciar_produtos();
		return;	
	}
	
	var _file = file_text_open_read("save.json");
	var _string = file_text_read_string(_file);
	var _struct = json_parse(_string);
	
	// atribuindo valores
	global.reciclagem = _struct.reciclagem;
	global.click	  = _struct.click;
	global.cps		  = _struct.cps;
	
	for(var _i = 0; _i < total_produtos; _i++) {
		with(produtos[_i]) {
			valor	   = _struct.produtos[_i].valor;
			quantidade = _struct.produtos[_i].quantidade;
			rps		   = _struct.produtos[_i].rps;
		}
	}
	
	file_text_close(_file);
}

function rolagem() {
	//scroll os produtos 
	if(mouse_check_button(mouse_wheel_down())) {
		produtos_y += 20;	
	}
	if(mouse_check_button(mouse_wheel_up())) {
		produtos_y -= 20;
	}
	
	var _max = (64 * total_produtos) + (20 * total_produtos) + 20 - room_height;
	
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

cria_produtos(total_produtos);
load_game();

