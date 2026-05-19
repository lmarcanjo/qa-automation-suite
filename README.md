# 🚀 QA Automation Master Suite - Enterprise Edition

![Playwright](https://img.shields.io/badge/Playwright-Typescript-45ba4b?style=for-the-badge&logo=playwright)
![Postman](https://img.shields.io/badge/Postman-Newman-ff6c37?style=for-the-badge&logo=postman)
![K6](https://img.shields.io/badge/K6-Performance-7d64ff?style=for-the-badge&logo=k6)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions)

Este repositório não é apenas um conjunto de scripts, mas sim uma arquitetura completa de testes automatizados englobando **UI E2E, Testes de Integração de API e Análise de Performance**, todos orquestrados por Integração Contínua (CI/CD).

## 📌 O que foi entregue?
1. **Mapeamento BDD:** +40 cenários mapeados cobrindo regras de negócio, exceções e segurança.
2. **Automação Web:** Scripts resilientes em TypeScript usando Playwright.
3. **Automação de API:** Validação de fluxos CRUD completos usando Postman e Newman.
4. **Testes de Carga:** Simulação de picos de tráfego na API usando K6.
5. **CI/CD na Nuvem:** Pipeline no GitHub Actions executando a suíte a cada *Push*.

## 📂 Estrutura de Diretórios
```text
📦 qa-automation-suite
 ┣ 📂 .github/workflows      # Pipeline de CI/CD 
 ┣ 📂 docs                   # Planos de Teste (Gherkin/BDD)
 ┣ 📂 evidences              # Relatórios Gerados Dinamicamente (.html)
 ┣ 📂 tests
 ┃ ┣ 📂 api                  # Collections (.json)
 ┃ ┣ 📂 performance          # K6 Scripts (.js)
 ┃ ┗ 📂 ui                   # Playwright Scripts (.spec.ts)
 ┣ 📜 run_all.sh             # Script Automatizado de Execução Local
 ┗ 📜 README.md              # Documentação Principal
```

## ⚙️ Como Iniciar e Executar Localmente

### Pré-requisitos (Máquina Local)
- [Node.js](https://nodejs.org/) (v16+)
- [Grafana K6](https://k6.io/docs/get-started/installation/)

### O "Super Comando" (Run All)
Foi desenvolvido um script bash que prepara o ambiente (baixa bibliotecas) e roda todos os cenários, gerando relatórios isolados de forma autônoma. No seu terminal, na raiz do projeto, execute:

**Linux / Mac / Git Bash (Windows):**
```bash
chmod +x run_all.sh
./run_all.sh
```

### 📊 Análise de Relatórios
Após a execução do script `run_all.sh`, a pasta `evidences/` será populada com os resultados.
- Abra o `api-report.html` no navegador para uma visão detalhada das requisições e falhas de contrato.
- Os testes de UI e Performance printarão seus respectivos resumos interativos direto no console/terminal.

## ☁️ Integração Contínua (GitHub Actions)
A qualidade não dorme. Foi configurado um arquivo YAML em `.github/workflows/qa-pipeline.yml` que:
1. Sobe um ambiente Ubuntu Server.
2. Faz o setup do Node e K6.
3. Executa as três suítes (UI, API e Perf) em jobs separados.
4. Exporta os relatórios como *Artifacts* diretamente na interface do GitHub.

---
*Desenvolvido com foco total em Qualidade e Resiliência.*