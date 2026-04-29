#!/usr/bin/env python3
"""
Script para converter CSV do Mockaroo para SQL
Uso: python3 csv_to_sql.py filename.csv table_name
"""

import csv
import sys

def sanitize_value(value):
    """Sanitiza valores para SQL"""
    if value is None or value == '' or value.lower() == 'null':
        return 'NULL'

    # Verifica se é número
    try:
        if '.' in value:
            float(value)
        else:
            int(value)
        return value
    except ValueError:
        pass

    # Escape de aspas simples
    value_str = str(value).replace("'", "''")
    return f"'{value_str}'"

def convert_csv_to_sql(csv_file, table_name):
    """Converte CSV para INSERT SQL"""
    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            rows = list(reader)
    except Exception as e:
        print(f"Erro ao ler arquivo CSV: {e}", file=sys.stderr)
        return None

    if len(rows) == 0:
        print("Erro: CSV está vazio", file=sys.stderr)
        return None

    sql_lines = [f"-- Importar dados de {csv_file} para {table_name}"]
    sql_lines.append(f"-- Gerado automaticamente por csv_to_sql.py")
    sql_lines.append("")

    # Obter colunas
    columns = list(rows[0].keys())

    # Gerar INSERT statements
    for row in rows:
        values = [sanitize_value(row.get(col, '')) for col in columns]
        columns_str = ', '.join(columns)
        values_str = ', '.join(values)
        sql_line = f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});"
        sql_lines.append(sql_line)

    return '\n'.join(sql_lines)

def main():
    if len(sys.argv) < 2:
        print("Uso: python3 csv_to_sql.py input.csv [table_name]")
        print("")
        print("Exemplo:")
        print("  python3 csv_to_sql.py categoria.csv categoria")
        print("  python3 csv_to_sql.py usuario.csv usuario > usuario.sql")
        sys.exit(1)

    csv_file = sys.argv[1]
    table_name = sys.argv[2] if len(sys.argv) > 2 else csv_file.replace('.csv', '')

    sql = convert_csv_to_sql(csv_file, table_name)
    if sql:
        print(sql)

if __name__ == '__main__':
    main()

