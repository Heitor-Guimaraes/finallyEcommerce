#!/bin/bash

# ============================================
# SCRIPT PARA IMPORTAR DADOS DO MOCKAROO
# ============================================
# Este script facilita a importação de dados
# gerados no Mockaroo para o MySQL

echo "================================"
echo "MOCKAROO DATA IMPORTER"
echo "================================"
echo ""

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Verificar argumentos
if [ $# -lt 2 ]; then
    echo -e "${YELLOW}Uso: ./mockaroo_importer.sh <formato> <arquivo>${NC}"
    echo ""
    echo "Formatos: sql | json | csv"
    echo ""
    echo "Exemplos:"
    echo "  ./mockaroo_importer.sh sql categoria.sql"
    echo "  ./mockaroo_importer.sh json categoria.json"
    echo "  ./mockaroo_importer.sh csv categoria.csv"
    echo ""
    exit 1
fi

FORMATO=$1
ARQUIVO=$2

# Validar arquivo
if [ ! -f "$ARQUIVO" ]; then
    echo -e "${RED}Erro: Arquivo '$ARQUIVO' não encontrado!${NC}"
    exit 1
fi

echo -e "${YELLOW}Formato detectado: ${BLUE}$FORMATO${NC}"
echo -e "${YELLOW}Arquivo: ${BLUE}$ARQUIVO${NC}"
echo ""

# Mapear tabela
TABELA=$(basename "$ARQUIVO" | cut -d. -f1)
echo -e "${YELLOW}Tabela: ${BLUE}$TABELA${NC}"
echo ""

# Conectar ao MySQL
echo -e "${YELLOW}Digite as credenciais do MySQL:${NC}"
read -p "Usuário (padrão: root): " DB_USER
DB_USER=${DB_USER:-root}

if [ "$DB_USER" = "root" ]; then
    mysql -u "$DB_USER" -p -e "SELECT 1" 2>/dev/null
    if [ $? -ne 0 ]; then
        read -sp "Senha do MySQL: " DB_PASS
        echo ""
        MYSQL_CMD="mysql -u $DB_USER -p$DB_PASS"
    else
        MYSQL_CMD="mysql -u $DB_USER"
        DB_PASS=""
    fi
else
    read -sp "Senha do MySQL: " DB_PASS
    echo ""
    if [ -z "$DB_PASS" ]; then
        MYSQL_CMD="mysql -u $DB_USER"
    else
        MYSQL_CMD="mysql -u $DB_USER -p$DB_PASS"
    fi
fi

# Testar conexão
$MYSQL_CMD -e "SELECT 1" 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro: Não foi possível conectar ao MySQL!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Conectado ao MySQL com sucesso!${NC}"
echo ""

# Processar arquivos
case $FORMATO in
    sql)
        echo -e "${YELLOW}Importando SQL...${NC}"
        $MYSQL_CMD ecommerce < "$ARQUIVO"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Dados importados com sucesso!${NC}"
        else
            echo -e "${RED}Erro ao importar dados!${NC}"
            exit 1
        fi
        ;;

    json)
        echo -e "${YELLOW}Convertendo JSON para SQL...${NC}"
        if ! command -v python3 &> /dev/null; then
            echo -e "${RED}Erro: Python 3 não está instalado!${NC}"
            exit 1
        fi

        SQL_FILE="${ARQUIVO%.json}.sql"
        python3 json_to_sql.py "$ARQUIVO" "$TABELA" > "$SQL_FILE"

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Arquivo convertido: ${BLUE}$SQL_FILE${NC}"
            echo -e "${YELLOW}Importando dados...${NC}"
            $MYSQL_CMD ecommerce < "$SQL_FILE"
            echo -e "${GREEN}✓ Dados importados com sucesso!${NC}"
        else
            echo -e "${RED}Erro ao converter JSON!${NC}"
            exit 1
        fi
        ;;

    csv)
        echo -e "${YELLOW}Convertendo CSV para SQL...${NC}"
        if ! command -v python3 &> /dev/null; then
            echo -e "${RED}Erro: Python 3 não está instalado!${NC}"
            exit 1
        fi

        SQL_FILE="${ARQUIVO%.csv}.sql"
        python3 csv_to_sql.py "$ARQUIVO" "$TABELA" > "$SQL_FILE"

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Arquivo convertido: ${BLUE}$SQL_FILE${NC}"
            echo -e "${YELLOW}Importando dados...${NC}"
            $MYSQL_CMD ecommerce < "$SQL_FILE"
            echo -e "${GREEN}✓ Dados importados com sucesso!${NC}"
        else
            echo -e "${RED}Erro ao converter CSV!${NC}"
            exit 1
        fi
        ;;

    *)
        echo -e "${RED}Erro: Formato desconhecido '$FORMATO'${NC}"
        echo "Use: sql, json ou csv"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✓ IMPORTAÇÃO CONCLUÍDA!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

# Verificar
echo -e "${YELLOW}Verificando dados em $TABELA...${NC}"
$MYSQL_CMD ecommerce -e "SELECT COUNT(*) as total_registros FROM $TABELA;"

