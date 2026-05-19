# LANGUAGE: pt

Funcionalidade: SUÍTE UI - Sauce Demo

  @ui @login
  Esquema do Cenario: Tentativas de Login
    Dado que acesso a pagina de login
    Quando insiro o usuario "<usuario>" e senha "<senha>"
    Entao vejo a consequencia "<resultado>"

    Exemplos:
      | usuario         | senha         | resultado                |
      | standard_user   | secret_sauce  | Sucesso (Inventory)      |
      | locked_out_user | secret_sauce  | Erro: Locked out         |
      | problem_user    | secret_sauce  | Sucesso (Com bugs)       |
      | invalid_user    | invalid_pass  | Erro: Username and pass  |
      | standard_user   |               | Erro: Password required  |
      |                 | secret_sauce  | Erro: Username required  |

  @ui @filtros
  Esquema do Cenario: Teste de Ordenacao de Produtos
    Dado que estou logado como "standard_user"
    Quando seleciono o filtro "<filtro>"
    Entao o primeiro produto exibido deve ser "<produto_esperado>"

    Exemplos:
      | filtro | produto_esperado                  |
      | az     | Sauce Labs Backpack               |
      | za     | Test.allTheThings() T-Shirt (Red) |
      | lohi   | Sauce Labs Onesie                 |
      | hilo   | Sauce Labs Fleece Jacket          |

  @ui @carrinho @detalhes
  Cenario: Adicionar e remover produto pela pagina de detalhes
    Dado que estou na lista de produtos logado
    Quando clico no titulo do produto "Sauce Labs Backpack"
    E clico em "Add to cart" na pagina de detalhes
    Entao o contador do carrinho mostra "1"
    Quando clico em "Remove" na mesma pagina
    Entao o contador desaparece

  @ui @checkout @negativo
  Esquema do Cenario: Validacoes do formulario de Checkout
    Dado que inicio o checkout
    Quando preencho Nome "<nome>", Sobrenome "<sobrenome>", CEP "<cep>"
    E tento continuar
    Entao vejo a mensagem de erro "<erro>"

    Exemplos:
      | nome | sobrenome | cep   | erro                      |
      |      | Blackbull | 99999 | First Name is required    |
      | Asta |           | 99999 | Last Name is required     |
      | Asta | Blackbull |       | Postal Code is required   |

  @ui @footer @social
  Cenario: Validacao de links das redes sociais
    Dado que estou logado
    Quando rolo ate o rodape
    Entao os links do "Twitter", "Facebook" e "LinkedIn" devem estar visiveis e apontar para as URLs corretas


Funcionalidade: SUÍTE API - Restful-Booker

  @api @auth
  Cenario: Geracao de token e falhas
    Dado que envio credenciais "admin" e "password123"
    Entao recebo token 200
    Quando envio credenciais "admin" e "errado"
    Entao recebo 200 porem com mensagem "Bad credentials"

  @api @get @filtros
  Esquema do Cenario: Buscar reservas usando multiplas query strings
    Dado que envio GET para "/booking" com query "<query>"
    Entao recebo status 200

    Exemplos:
      | query                                      |
      | ?firstname=Asta                            |
      | ?lastname=Blackbull                        |
      | ?checkin=2024-01-01                        |
      | ?checkin=2024-01-01&checkout=2024-12-31    |

  @api @crud @patch
  Cenario: Fluxo de atualizacao parcial (PATCH)
    Dado que crio uma reserva valida
    Quando envio um PATCH informando apenas "firstname": "Yami" e "totalprice": 5000 com Token
    Entao recebo 200 e os outros dados permanecem intactos

  @api @negativo @404 @405
  Cenario: Validacao de rotas inexistentes ou metodos invalidos
    Dado que envio GET para "/booking/99999999"
    Entao recebo 404 Not Found
    Quando envio PUT para "/booking" (sem ID)
    Entao recebo 405 Method Not Allowed