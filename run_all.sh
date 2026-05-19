#!/bin/bash

echo "======================================================"
echo " ⚔️ PREPARANDO MAGIA LOCAL E ATACANDO! ⚔️ "
echo "======================================================"

mkdir -p evidences

echo "📦 Verificando/Instalando dependências (Node/Playwright)..."
if [ ! -d "node_modules" ]; then
    npm init -y > /dev/null
    npm install -D @playwright/test > /dev/null
    npx playwright install chromium
fi

echo "📦 Verificando/Instalando Newman..."
if ! command -v newman &> /dev/null; then
    npm install -g newman newman-reporter-htmlextra > /dev/null
fi

echo "🚀 [1/3] RODANDO PLAYWRIGHT (UI)..."
npx playwright test

echo "🚀 [2/3] RODANDO NEWMAN (API)..."
newman run tests/api/restful-booker.json -r cli,htmlextra --reporter-htmlextra-export evidences/api-report.html

echo "🚀 [3/3] RODANDO K6 (PERFORMANCE)..."
if command -v k6 &> /dev/null; then
    k6 run tests/performance/load_test.js
else
    echo "⚠️ K6 não instalado localmente. Pulei o teste de carga."
    echo "👉 Instale com: winget install k6 (Win) ou brew install k6 (Mac)"
fi

echo "======================================================"
echo " 🎉 A MAGIA FOI LANÇADA! CHEQUE A PASTA evidences/ 🎉"
echo "======================================================"