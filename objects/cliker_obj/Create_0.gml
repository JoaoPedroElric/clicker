global.reciclagem = 0;
total_produtos = 3;
total_upgrades = 3; // quantidade de upgrades

reciclagem_total = global.reciclagem;
global.click = 1;
global.cps = 0;

global.save = false;

alarm[1] = room_speed * 60;

escala_x = image_xscale;
escala_y = image_yscale;


alarm[0] = room_speed * 3;

// criação dos produtos
produtos = [];

base_y = 60;
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
	
	global.save = true;
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
	
	for(var _i = 0; _i < array_length(produtos); _i++) {
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

function deletar_save() {
	if(file_exists("save.json")){
		file_delete("save.json");
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
	
	var _max = (64 * total_produtos) + (20 * total_produtos) + 20 - room_height;
	
	produtos_y = clamp(produtos_y, -_max, base_y);
}

// fazendo eles aparecer na tela
function gerencia_produtos() {
	
	rolagem();
	
	for(var i = 0; i < array_length(produtos); i++) {
		var _marg = 10;
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

//===================================================================================


upgrades = [];

base_y_up = 20; // posição inicial (pode mudar)
upgrades_y = 0 + base_y_up;

function cria_upgrades(_qtd = 1) {
	for (var i = 0; i < _qtd; i++) {
		upgrades[i] = instance_create_layer(0, 0, layer, upgrade_obj);
	}
}

function iniciar_upgrades() {
	var lista = [
		[100, false, "Aumenta a eficiencia do clique em x2"],
		[500, false, "Multiplica a eficiencia dos funcionarios em x2"],
		[2000, false, "Dobra o cps"]
	];
	
	for (var i = 0; i < array_length(lista); i++) {
		if (i < array_length(upgrades)) {
			with (upgrades[i]) {
				valor    = lista[i][0];
				comprado = lista[i][1];
				info   = lista[i][2];
			}
		}
	}
}

function gerencia_upgrades() {
	
	for (var i = 0; i < array_length(upgrades); i++) {
		var _marg = 5;
		var _x = 480 + upgrades_y + _marg + ((i * 32) + (i * _marg)); // lado direito da tela
		var _y = base_y_up;
		
		with (upgrades[i]) {
			x = _x;
			y = _y + sprite_height / 2;
		}
	}
}


//deletar_save();
cria_produtos(total_produtos);
cria_upgrades(total_upgrades);
iniciar_upgrades();
load_game();

