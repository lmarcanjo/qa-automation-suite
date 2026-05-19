# language: pt
Funcionalidade: Requisitos Não Funcionais (NFR) e Performance da API
  Como um Engenheiro de Qualidade
  Quero garantir que a API suporte a volumetria esperada e trate picos de tráfego
  Para que a aplicação não caia durante eventos de alta demanda

  @performance @load_test
  Cenário: [Load] Suportar carga de usuários simultâneos no fluxo principal
    Dado que a API está operando em condições normais
    Quando eu simular uma rampa de acesso até "50" Usuários Virtuais (VUs) durante "1 minuto"
    Fazendo requisições GET no endpoint de listagem
    Então o tempo de resposta do percentil 95 (p95) deve ser menor que "500ms"
    E a taxa de erro (http_req_failed) deve ser menor que "1%"

  @performance @stress_test
  Cenário: [Stress] Encontrar o ponto de quebra do banco de dados em mutações
    Dado que a API está operando em condições normais
    Quando eu simular "100" Usuários Virtuais (VUs) simultâneos
    Fazendo requisições POST pesadas de criação de dados por "2 minutos"
    Então a CPU e a memória do servidor não devem estourar
    E o tempo máximo de resposta não deve ultrapassar "2000ms"
    Mas se houver falhas, a API deve retornar "503 Service Unavailable" graciosamente e não corromper o banco

  @performance @spike_test
  Cenário: [Spike] Sobreviver a um pico repentino de acessos (Efeito Black Friday)
    Dado que o tráfego atual é de "10" VUs
    Quando houver um salto repentino para "200" VUs em menos de "10 segundos"
    E esse tráfego se mantiver por "30 segundos"
    Então o sistema deve recuperar sua estabilidade após o tráfego voltar ao normal
    E nenhum dado em trânsito deve ser perdido

  @security @rate_limiting
  Cenário: [Rate Limit] Bloquear excesso de requisições por IP (DDoS Protection)
    Dado que um usuário mal intencionado descobre a rota de Login
    Quando ele realizar mais de "100" requisições na mesma rota em menos de "1 minuto"
    Então a API deve bloquear temporariamente o IP
    E retornar o Status Code "429 Too Many Requests"

  @performance @soak_test
  Cenário: [Soak] Validar ausência de Memory Leaks em longa duração
    Dado que a aplicação roda contínuamente
    Quando eu mantiver uma carga média de "30" VUs constante por "1 hora"
    Então o consumo de memória RAM do servidor deve se manter estável
    E o tempo de resposta não deve degradar ao longo do tempo

  @performance @cache_validation
  Cenário: [Cache] Validar eficiência do tempo de resposta para dados cacheados
    Dado que um recurso foi recém consultado e armazenado em Cache
    Quando eu fizer "500" requisições GET consecutivas para este mesmo recurso
    Então o tempo de resposta do percentil 99 (p99) deve ser menor que "50ms"
    E a API não deve bater no banco de dados para essas requisições
