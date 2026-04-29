#!/usr/bin/env python3
"""
Script para converter JSON do Mockaroo para SQL
Uso: python3 json_to_sql.py filename.json table_name
"""

import json
import sys
import re

def sanitize_value(value):
    """Sanitiza valores para SQL"""
    if value is None or value == '':
        return 'NULL'
    if isinstance(value, bool):
        return str(int(value))
    if isinstance(value, (int, float)):
        return str(value)
    # Escape de aspas simples
    value_str = str(value).replace("'", "''")
    return f"'{value_str}'"

def convert_json_to_sql(json_file, table_name):
    """Converte JSON para INSERT SQL"""
    try:
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        print(f"Erro ao ler arquivo JSON: {e}", file=sys.stderr)
        return None

    if not isinstance(data, list) or len(data) == 0:
        print("Erro: JSON deve ser uma lista de objetos", file=sys.stderr)
        return None

    sql_lines = [f"-- Importar dados de {json_file} para {table_name}"]
    sql_lines.append(f"-- Gerado automaticamente por json_to_sql.py")
    sql_lines.append("")

    # Obter colunas do primeiro registro
    columns = list(data[0].keys())

    # Gerar INSERT statements
    for record in data:
        values = [sanitize_value(record.get(col)) for col in columns]
        columns_str = ', '.join(columns)
        values_str = ', '.join(values)
        sql_line = f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});"
        sql_lines.append(sql_line)

    return '\n'.join(sql_lines)

def main():
    if len(sys.argv) < 2:
        print("Uso: python3 json_to_sql.py input.json [table_name]")
        print("")
        print("Exemplo:")
        print("  python3 json_to_sql.py categoria.json categoria")
        print("  python3 json_to_sql.py usuario.json usuario > usuario.sql")
        sys.exit(1)

    json_file = sys.argv[1]
    table_name = sys.argv[2] if len(sys.argv) > 2 else json_file.replace('.json', '')

    sql = convert_json_to_sql(json_file, table_name)
    if sql:
        print(sql)

if __name__ == '__main__':
    main()

