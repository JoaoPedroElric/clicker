global.reciclagem = 0;
total_produtos = 6; // qauntidade de produtos
total_upgrades = 7; // quantidade de upgrades



reciclagem_total = global.reciclagem;
global.click = 1;
global.cps = 0;

// save automatico
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
		[10, 0, 0.1, "Gera 0.10 rps", 0],
		[100, 0, 1, "Gera 1 rps", 0],
		[1100, 0, 12, "Gera 12 rps", 0],
		[12000, 0, 55, "Gera 50 rps", 0],
		[150000, 0, 290, "Gera 290 rps", 0],
		[1400000, 0, 1500, "Gera 1500 rps", 0]
	];   
	
	for(var i = 0; i < array_length(lista); i ++) {
		if(i < array_length(produtos)) {
			with(produtos[i]) {
				valor		= lista[i][0];
				quantidade  = lista[i][1];
				rps			= lista[i][2];
				descricao	= lista[i][3];
				rps_t		= lista[i][4]; 
			}
		}
	}
}


function save_game() {
	
	global.save = true;
	var _file = file_text_open_write("save.json");
	
	var _tempo_atual = date_current_datetime();

	
	// saber oq salvar
	var _struct = 
	{
		reciclagem  : global.reciclagem,
		click		: global.click,
		cps			: global.cps,
		produtos    : [],
		upgrades	: [],
		tempo       : _tempo_atual
	};
	//show_message(_struct);
	
	for(var _i = 0; _i < array_length(produtos); _i++) {
		with(produtos[_i]) {
			array_push(_struct.produtos, {
				valor		: valor,
				quantidade  : quantidade,
				rps			: rps,
				descricao	: descricao,
				rps_t		: rps_t,
				r_total     : r_total,
				index       : index
				
			});
		}
	}
	
	for(var _i = 0; _i < array_length(upgrades); _i++) {
		with(upgrades[_i]) {
			array_push(_struct.upgrades, {
				//valor				: valor,
				comprado			: comprado,
				//info				: info,
				//mult				: mult,
				//index				: index,
				//exibir			: exibir,
				//disponivel		: disponivel,
				//pdt_alvo			: pdt_alvo,
				//qtd_necessaria	: qtd_necessaria	
				
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
	
	var _tempo = date_current_datetime();
	var _dif = date_second_span(_struct.tempo, _tempo);
	
	
	
	//atribuindo valores
	global.reciclagem = _struct.reciclagem;
	global.click	  = _struct.click;
	global.cps		  = _struct.cps;
	
	for(var _i = 0; _i < total_produtos; _i++) {
		with(produtos[_i]) {
			valor	   = _struct.produtos[_i].valor;
			quantidade = _struct.produtos[_i].quantidade;
			rps		   = _struct.produtos[_i].rps;
			descricao  = _struct.produtos[_i].descricao;
			rps_t	   = _struct.produtos[_i].rps_t;
			r_total	   = _struct.produtos[_i].r_total;
			index	   = _struct.produtos[_i].index;
		}
	}
	
	

	// percorre upgrades existentes
	for (var i = 0; i < array_length(upgrades); i++) {
	    with (upgrades[i]) {
	       	//valor			= _struct.upgrades[i].valor;			
			comprado		= _struct.upgrades[i].comprado; 
			//info			= lista[i][2];
			//mult			= lista[i][3];
			//index			= lista[i][4];
			//exibir			= lista[i][5];
			//disponivel		= lista[i][6];
			//pdt_alvo		= lista[i][7];
			//qtd_necessaria	= lista[i][8];
	    }
	}
	

	// aplica os dados salvos

	
	global.reciclagem += _dif * global.cps;
	var teste = (_dif / 5) * global.cps;
	
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

function rolagem_u() {
	
    // Rolagem do mouse
    if (mouse_check_button(mouse_wheel_down())) {
        upgrades_y += 20;  
    }
    if (mouse_check_button(mouse_wheel_up())) {
        upgrades_y -= 20;
    }

  
	var _max = (32 * total_upgrades) + (32 * total_upgrades) + 20 - room_height;
	
	upgrades_y = clamp(upgrades_y, -_max, base_y_up);
}

// fazendo eles aparecer na tela
function gerencia_produtos() {
	if(mouse_x > 480 && mouse_y > 64) {
		rolagem();
	}
	
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

clone_upgrade = [];

base_y_up = 20; // posição inicial (pode mudar)
upgrades_y = 0 + base_y_up;

function cria_upgrades(_qtd = 1) {
	for (var i = 0; i < _qtd; i++) {
		upgrades[i] = instance_create_layer(0, 0, layer, upgrade_obj);	
	}
}

function iniciar_upgrades() {
	var lista = [
		[100, false, "Multiplica a eficiencia da pa em x2", 2 , 0, false, false, 0, 1],
		[500, false, "Multiplica a eficiencia dos funcionarios em x2", 2, 1, false, false, 1, 1],
		[1000, false, "Multiplica a eficiencia dos caminhoes em x2", 2, 2, false, false, 2, 1],
		[1500, false, "Multiplica a eficiencia em x2", 2, 3, false, false, 3, 1],
		[2500, false, "Multiplica a eficiencia em x2", 2, 4, false, false, 4, 1],
		[5500, false, "Multiplica a eficiencia em x2", 2, 5, false, false, 5, 1],
		[1000, false, "Multiplica a eficiencia da pe em x2", 2, 0, false, false, 0, 10]
	];
	
	for (var i = 0; i < array_length(lista); i++) {
		if (i < array_length(upgrades)) {
			with (upgrades[i]) {
				valor			= lista[i][0];
				comprado		= lista[i][1];
				info			= lista[i][2];
				mult			= lista[i][3];
				index			= lista[i][4];
				exibir			= lista[i][5];
				disponivel		= lista[i][6];
				pdt_alvo		= lista[i][7];
				qtd_necessaria	= lista[i][8];
			}
		}
	}
}

function gerencia_upgrades() {
	
	var pos = 0;
	if(mouse_x > 480 && mouse_y <= 64) {
		rolagem_u();
	}
	
	for (var i = 0; i < array_length(upgrades); i++) {
		var _marg = 5;
		var _x = 480 + upgrades_y + _marg + ((pos * 32) + (pos * _marg)); 
		var _y = base_y_up;
		
		with (upgrades[i]) {
			if(!comprado && disponivel) {
				x = _x;
				y = _y + sprite_height / 2;
				pos++;
			} else {
				x = -1000;
			}
		}
	}	
}


deletar_save();


cria_produtos(total_produtos);
cria_upgrades(total_upgrades);
iniciar_upgrades();
load_game();

