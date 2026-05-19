# 🚀 QA Automation Suite - Supreme Edition (UI, API & Perf)

Esta é a suíte de testes E2E, API e Performance, cobrindo alguns fluxos possíveis do Sauce Demo e Restful-Booker.

## 🎯 Cobertura Expandida (+40 Cenários)
- **UI (Playwright):** 20 Cenários! Cobertura total de todos os usuários (standard, locked, problem, glitch). Testes de ordenação (A-Z, Z-A, Price L-H, Price H-L), carrinho via página de detalhes, validações de todos os campos do checkout, persistência de dados e links externos (redes sociais).
- **API (Postman/Newman):** 20 Cenários! Inclusão de rotas PATCH (atualização parcial), GET com múltiplos filtros combinados (nomes e datas), validações de segurança (403) em PUT/PATCH/DELETE, fluxos de não-encontrado (404) e método não permitido (405).
- **Performance (K6):** Cenários escalonados testando gargalos em métodos POST e GET simultaneamente.
- **CI/CD (GitHub Actions):** Pipeline automatizado que instala dependências e executa os 3 frameworks na nuvem a cada push.

## ⚙️ Stack Tecnológica & Setup
- **UI:** Playwright (TypeScript)
- **API:** Postman / Newman
- **Performance:** K6 (JavaScript)
- **CI/CD:** GitHub Actions (`.github/workflows/qa-pipeline.yml`)