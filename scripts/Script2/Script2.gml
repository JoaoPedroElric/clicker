/// @function array_delete_custom(_array, _index)
/// @param _array  Array de origem
/// @param _index  Posição a remover
/// @return Novo array sem o valor naquela posição
function array_delete_custom(_array, _index) {
    var len = array_length(_array);
    var new_array = [];
    var j = 0;

    for (var i = 0; i < len; i++) {
        if (i != _index) {
            new_array[j] = _array[i];
            j++;
        }
    }

    return new_array;
}