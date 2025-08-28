#!/bin/bash
# Script de checklist atualizado com espera automática do WordPress

echo "🔎 Verificando containers ativos..."
containers=("webproxy" "webserver" "database")
all_running=true
for c in "${containers[@]}"; do
    status=$(docker inspect -f '{{.State.Running}}' $c 2>/dev/null)
    if [ "$status" == "true" ]; then
        echo "✅ Container '$c' está ativo"
    else
        echo "❌ Container '$c' NÃO está ativo"
        all_running=false
    fi
done

echo -e "\n🔎 Verificando volumes Docker..."
volumes=("app" "my")
for v in "${volumes[@]}"; do
    if docker volume inspect $v >/dev/null 2>&1; then
        echo "✅ Volume '$v' encontrado"
    else
        echo "❌ Volume '$v' não encontrado"
        all_running=false
    fi
done

echo -e "\n🔎 Verificando rede Docker 'wordpress'..."
if docker network inspect wordpress >/dev/null 2>&1; then
    echo "✅ Rede 'wordpress' encontrada"
else
    echo "❌ Rede 'wordpress' não encontrada"
    all_running=false
fi

# Função para testar HTTP com espera automática
function wait_for_http() {
    url=$1
    timeout=120   # tempo máximo em segundos
    interval=5    # intervalo entre tentativas
    elapsed=0

    echo -e "\n⏳ Aguardando serviço em $url ficar pronto..."
    while [ $elapsed -lt $timeout ]; do
        code=$(curl -s -o /dev/null -w "%{http_code}" $url)
        if [[ "$code" =~ ^2|3 ]]; then
            echo "✅ HTTP OK em $url (código $code)"
            return 0
        else
            sleep $interval
            elapsed=$((elapsed + interval))
        fi
    done
    echo "❌ HTTP falhou em $url após $timeout segundos (último código $code)"
    return 1
}

# Testa acesso HTTP interno e via IP da VM
urls=("http://localhost:8080" "http://192.168.56.162:8080")
for url in "${urls[@]}"; do
    wait_for_http $url || all_running=false
done

if [ "$all_running" = true ]; then
    echo -e "\n✅ Checklist concluído! Tudo funcionando corretamente."
else
    echo -e "\n⚠️ Checklist concluído, mas alguns itens estão com problemas. Verifique os erros acima."
fi

