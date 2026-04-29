#!/bin/bash

# ============================================
# SCRIPT PARA CRIAR BANCO E IMPORTAR DADOS
# ============================================
# Este script automatiza a criação do banco de dados MySQL
# e importação dos dados de teste

echo "================================"
echo "CRIAÇÃO DE BANCO - ECOMMERCE API"
echo "================================"
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar se o MySQL está instalado
if ! command -v mysql &> /dev/null; then
    echo -e "${RED}Erro: MySQL não está instalado!${NC}"
    echo "Para instalar, execute: apt install mysql-server"
    exit 1
fi

echo -e "${YELLOW}Digite suas credenciais do MySQL:${NC}"
read -p "Usuário (padrão: root): " DB_USER
DB_USER=${DB_USER:-root}

# Se o usuário for root, tenta sem pedir senha primeiro
if [ "$DB_USER" = "root" ]; then
    echo -e "${YELLOW}Tentando conectar como root...${NC}"
    mysql -u "$DB_USER" -p -e "SELECT 1" 2>/dev/null
    if [ $? -ne 0 ]; then
        read -sp "Senha do MySQL: " DB_PASS
        echo ""
    else
        DB_PASS=""
    fi
else
    read -sp "Senha do MySQL: " DB_PASS
    echo ""
fi

# Construir comando MySQL
if [ -z "$DB_PASS" ]; then
    MYSQL_CMD="mysql -u $DB_USER"
else
    MYSQL_CMD="mysql -u $DB_USER -p$DB_PASS"
fi

# Testar conexão
echo -e "${YELLOW}Testando conexão...${NC}"
$MYSQL_CMD -e "SELECT 1" 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro: Não foi possível conectar ao MySQL!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Conectado ao MySQL com sucesso!${NC}"
echo ""

# Caminho do script SQL
SQL_FILE="src/main/resources/schema.sql"

# Verificar se o arquivo SQL existe
if [ ! -f "$SQL_FILE" ]; then
    echo -e "${RED}Erro: Arquivo $SQL_FILE não encontrado!${NC}"
    echo "Certifique-se de estar no diretório correto do projeto."
    exit 1
fi

echo -e "${YELLOW}Executando script SQL...${NC}"
echo "Arquivo: $SQL_FILE"
echo ""

# Executar script SQL
$MYSQL_CMD < "$SQL_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}✓ BANCO CRIADO COM SUCESSO!${NC}"
    echo -e "${GREEN}================================${NC}"
    echo ""
    echo "📊 Resumo:"
    echo "  - Banco de dados: ecommerce"
    echo "  - Usuário: $DB_USER"
    echo "  - 5 categorias importadas"
    echo "  - 4 usuários de teste"
    echo "  - 14 produtos importados"
    echo "  - 3 pedidos de teste"
    echo "  - 4 itens de pedido"
    echo "  - 3 pagamentos de teste"
    echo ""
    echo "🔑 Dados de teste:"
    echo "  - Email: joao@example.com"
    echo "  - Senha: senha123"
    echo ""
    echo "🚀 Próximos passos:"
    echo "  1. Execute: ./mvnw spring-boot:run"
    echo "  2. Acesse: http://localhost:8080"
    echo "  3. Faça login em: http://localhost:8080/auth/login"
    echo ""
else
    echo -e "${RED}Erro ao executar script SQL!${NC}"
    exit 1
fi

