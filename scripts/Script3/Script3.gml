function converter(v_cheio = 0) {
    var v = v_cheio;
    var notacao = "";

	    if (v >= 1000000000000) { 
        v /= 1000000000000; 
        notacao = "T"; 
    } else if (v >= 1000000000) { 
        v /= 1000000000; 
        notacao = "B"; 
    } else if (v >= 1000000) { 
        v /= 1000000; 
        notacao = "M"; 
    } else if (v >= 10000) { 
        v /= 1000; 
        notacao = "K"; 
    } else { 
        return string(v); 
    }
	var str = string_format(v, 0, 2) + notacao;
	return str;
}
