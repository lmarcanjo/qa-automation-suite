# 🚀 QA Automation Master Suite

![Playwright](https://img.shields.io/badge/Playwright-2EAD33?style=for-the-badge&logo=Playwright&logoColor=white)
![k6](https://img.shields.io/badge/k6-7D64FF?style=for-the-badge&logo=k6&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

Este repositório contém o desafio técnico de QA Automaton. A suíte foi desenvolvida com foco em **Qualidade Total**, cobrindo testes ponta a ponta (E2E), testes de contrato/integração (API) e testes de resiliência e volumetria (Performance), utilizando as melhores práticas do mercado, como Page Objects, BDD e Continuous Integration.

## 🎯 Estratégia e Arquitetura

O projeto foi desenhado para ser rápido, escalável e gerar relatórios visuais ricos. 

- **UI / E2E:** `Playwright` (TypeScript). Escolhido pela velocidade, auto-wait nativo e geração de *Traces* detalhados.
- **API:** `Postman / Newman`. Escolhido pela facilidade de manutenção de collections e geração do relatório `htmlextra`.
- **Performance:** `Grafana k6`. Escolhido por rodar via script (JavaScript), permitindo versionamento de infraestrutura e assertividade de NFRs (Requisitos Não-Funcionais).
- **CI/CD:** `GitHub Actions`. Configurado para rodar a suíte completa automaticamente em cada push para a branch principal.

---

## 📂 Estrutura do Projeto

```text
qa-automation-suite/
├── docs/                     # Cenários BDD (Gherkin) detalhados (Funcionais e Não-Funcionais)
├── evidences/                # ⚠️ Ignorado no Git. Aqui são salvos os relatórios HTML e Vídeos localmente
├── tests/
│   ├── api/                  # Collections e Environments do Postman
│   ├── performance/          # Scripts do K6 (Load, Stress e Spike tests)
│   └── ui/                   # Scripts E2E com Playwright
│       ├── pages/            # Page Object Model (POM)
│       └── e2e/              # Arquivos de teste (.spec.ts)
├── .github/workflows/        # Pipeline do GitHub Actions
├── playwright.config.ts      # Configuração global do Playwright
├── run_all.sh                # Script bash para execução unificada gerando relatórios
└── README.md                 # Documentação do projeto
```

---

## 🌪️ O Que Foi Testado? (Mapeamento de Riscos e BDD)

Os cenários foram documentados utilizando Gherkin (BDD) na pasta `docs/`. Destacam-se:

### 1. Testes de Performance (Requisitos Não Funcionais)
O K6 foi configurado com *Thresholds* (Critérios de Aceite) rigorosos. O teste falhará automaticamente se:
- `http_req_duration` (p95) > 500ms.
- `http_req_failed` > 1% (Taxa de erro).

**Cenários K6 implementados:**
- **Load Test:** Ramp-up para validar a carga diária esperada.
- **Stress Test:** Ataques pesados focados em mutações de banco (POST/PUT) para validar gargalos.
- **Spike Test:** Picos rápidos de acessos paralelos para validar resiliência.

### 2. Testes de UI & API
- Validação de fluxos de exceção, quebra de contrato, campos obrigatórios, Rate Limiting (429) e injeção de dados inválidos (Negative Testing).

---

## ⚙️ Pré-requisitos e Instalação

Certifique-se de ter instalado em sua máquina:
- [Node.js](https://nodejs.org/) (v18 ou superior)
- [K6](https://k6.io/docs/get-started/installation/)

Clone o projeto e instale as dependências:

```bash
git clone https://github.com/SEU-USUARIO/qa-automation-suite.git
cd qa-automation-suite
npm install
npx playwright install --with-deps
```

---

## 🚀 Como Executar os Testes (Local)

Você pode rodar as camadas separadamente ou utilizar o script unificado.

### Opção 1: Execução Unificada (Recomendado)
Criei um script mágico que roda UI, API e Performance de uma só vez, e concentra **todos os relatórios e vídeos** na pasta `evidences/`.

```bash
# Dê permissão ao script (Apenas Linux/Mac/GitBash)
chmod +x run_all.sh

# Execute a suíte
./run_all.sh
```

### Opção 2: Comandos Individuais
**Playwright (UI E2E):**
```bash
npx playwright test          # Roda em background
npx playwright test --ui     # Abre a interface interativa do Playwright
```

**K6 (Performance):**
```bash
# Roda o teste de carga e gera um dashboard HTML na pasta evidences
K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=evidences/k6-report.html k6 run tests/performance/seu_script_k6.js
```

---

## 📊 Relatórios e Evidências

Por padrão, a captura de **vídeos e traces no caso de falha** está ativada no Playwright. 
Após a execução local, abra a pasta `evidences/` e você encontrará:
1. `playwright-report/index.html` (Gráficos e vídeos do fluxo UI).
2. `k6-report.html` (Dashboard interativo de volumetria e picos do servidor).
3. `api-report.html` (Dashboard gerado pelo Newman detalhando as requisições).


## ☁️ CI / CD (Pipeline Mágica)
Este repositório possui Integração Contínua na aba **Actions**. 
A cada push ou Pull Request para a branch `main`, os containers instalam as dependências e rodam os testes E2E e de API garantindo que nada foi quebrado antes do deploy. Os relatórios de nuvem são salvos como **Artifacts** ao final da run.

---
**Desenvolvido por [Luã Arcanjo](https://www.linkedin.com/in/lu%C3%A3-martins-arcanjo-b34500124/)** | Engenheiro de Qualidade
