#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Uso: $0 <arquivo.hpp>"
  exit 1
fi

hpp_file=$1
if [[ ! -f "$hpp_file" ]]; then
  echo "Erro: o arquivo $hpp_file não existe."
  exit 1
fi

cpp_file="${hpp_file%.*}.cpp"

# Verifica se o arquivo .CPP já existe e interrompe o script, caso positivo
if [[ -e "$cpp_file" ]]; then
  echo "O arquivo $cpp_file já existe. Não é possível sobrescrevê-lo."
  exit 1
fi

# Extrai o nome da classe do arquivo .HPP
class_name=$(grep -oP '^class \K\w+' "$hpp_file")

# Cria o arquivo .CPP com as definições vazias das funções
cat > "$cpp_file" <<EOF
#include "$hpp_file"

$class_name::$class_name() {
}

$class_name::~$class_name() {
}

$class_name::$class_name(const $class_name& other) {
}

$class_name &$class_name::operator=(const $class_name& other) {
  if (this != &other) {
    // implementar a atribuição
  }
  return *this;
}

EOF

# Extrai as declarações das funções do arquivo .HPP e adiciona ao arquivo .CPP
while read -r line; do
  if [[ "$line" =~ ([a-zA-Z0-9_]+)[[:space:]]+([a-zA-Z0-9_]+)\((.*)\)\; ]]; then
    return_type="${BASH_REMATCH[1]}"
    function_name="${BASH_REMATCH[2]}"
    parameters="${BASH_REMATCH[3]}"
    echo "$return_type $class_name::$function_name($parameters) {" >> "$cpp_file"
    echo "}" >> "$cpp_file"
  fi
done < "$hpp_file"

echo "CPP file: $cpp_file created!"
