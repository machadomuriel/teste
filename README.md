# Robot Framework . Projeto Base . Browser Library
#### Cogna . QA . Automação

![Pipeline Status (Main)](https://gitlab.com/platosedu/cosmos/automacao-de-testes/robot_base_project_lib_browser/badges/main/pipeline.svg)

Este repositório é um template para projetos que desejam usar a [Browser Library](https://robotframework-browser.org/), uma biblioteca moderna para testes Web desenvolvida pela Playwright, que promete entregar mais:
- 🚀 velocidade
- ✅ confiabilidade
- 🔬 visibilidade

### SUMÁRIO
- [🤓 Começando](#-começando)
  - [📦🐍Configure o ambiente virtual Python e instale suas dependências](#-configure-o-ambiente-virtual-python-e-instale-suas-depend%C3%AAncias)
  - [📦✳️ Instale o Node e suas dependências](#%EF%B8%8F-instale-o-node-e-suas-dependências)
  - [📦🔡 Variáveis de ambiente](#-vari%C3%A1veis-de-ambiente)
- [📊 Pipeline](#-pipeline)
- [⛓️ Arquitetura](#%EF%B8%8F-arquitetura)
- [🧩 Padrões e boas práticas](#-padrões-e-boas-práticas)
- [🛠️ Utilitários](#%EF%B8%8F-utilitários)
  - [Ferramentas para Desenvolvimento](#ferramentas-para-desenvolvimento)
  - [Plugins obrigatórios](#plugins-obrigatórios)
  - [Plugins opcionais](#plugins-opcionais)
- [📚 Referências](#-referências)
- [❓ FAQ](#-faq)
- [📄 Licença](#-licença)

### 🤓 Começando
Já começando com boas práticas, sugerimos trabalhar com o projeto em ambiente virtual. Embora você atue somente em um projeto, essa prática pode trazer benefícios a longo prazo, considerando que podemos expandir nossa atuação e colaborar com outros QAs. Assim, podemos garantir isolamento de dependências, evitar conflitos entre projetos, portabilidade, reprodutibilidade e facilidade de limpeza. 

Para garantir a configuração correta, você pode seguir em ordem os tópicos e steps abaixo. Belezinha?

#### 📦🐍 Configure o ambiente virtual Python e instale suas dependências

1. Instalar o Python: [Download - Python](https://www.python.org/downloads/)
2. Acessar o diretório do projeto
3. Criar o ambiente virtual Python:
   3.1. **Windows**
      ```powershell
      py -m venv venv
      ```
   3.2. **Linux**
      ```bash
      python3 -m venv venv
      ```
4. Ativar o ambiente virtual Python:
   4.1. **Windows**
      ```powershell
      ./venv/Scripts/activate
      ```
   4.2. **Linux**
      ```bash
      source venv/bin/activate
      ```
5. Instalar requisitos:
      ```bash
      pip install -r requirements.txt
      ```

#### 📦✳️ Instale o Node e suas dependências
1. Instalar o [Node](https://nodejs.org/pt/download/prebuilt-installer)
2. Inicializar a biblioteca browser
    ```bash
    rfbrowser init
    ```
    
#### 📦🔡 Variáveis de ambiente

- Dados sensíveis como usuários e senhas devem ser armazenados no arquivo .env
- Chaves de acesso (api keys) também devem ser informadas dentro desse arquivo

O arquivo HOOKS.robot faz uma chamada para o arquivo commom/load_env.py que, por sua vez, carrega na memória as variáveis de ambiente existentes no arquivo .env. Por herança, as variáveis são disponibilizadas para todos os arquivos que utilizam o HOOKS.robot.

O arquivo .env deve ser criado apenas no repositório local, na raiz do projeto. As variáveis devem possuir o formato CHAVE=VALOR.

```
BASE_URL=https://urldoprojeto.com
PROJETO_STAGE_USUARIO=user-do-projeto
PROJETO_STAGE_SENHA=senha-do-user-do-projeto
ZEPHYR_ACCESS_TOKEN=INTEGRACAO-TOKEN
```

> Mais informações sobre integração com Zephyr: [Como gerar access token do Zephyr](http://https://support.smartbear.com/zephyr-scale-cloud/docs/rest-api/generating-api-access-tokens.html "Como gerar access token")


### 📊 Pipeline
  A pipeline é configurada no arquivo git-ci.yaml e possui 2 etapas:

  health-check: verifica se aplicação está disponível para a automação ser executada.
  run-tests: instala a imagem, prepara o ambiente e executa o teste de amostra sample.robot.

  Os resultados dos testes você pode acompanhar pelo terminal e pelo arquivo disponibilizado para download no final do teste. Esses arquivos são artefatos que expiram em 1 dia.

## ⛓️ Arquitetura

      ├── common
      │     └── arquivos comuns aos testes, como libs e variáveis (.resource ou .py)
      ├── hooks
      │     └── arquivos com keywords de setup (.resource)
      ├── pages
      │     └── arquivos contendo o encapsulamento dos elementos das páginas (.resource) 
      ├── resources
      │     └── materias de apoio, como .sql, .sgv, .csv.
      ├── results
      │     └── outputs dos testes. Sempre executar robot -d ./results para que os logs sejam salvos nessa pasta
      ├── steps
      │     └── api
      │           └── arquivos contendo as keywords que possuem a lógica para os testes de api (.resource)
      │     └── web
      │           └── arquivos contendo as keywords que possuem a lógica para os testes de web (.resource)
      ├── tests
      │     └── api
      │           └── arquivos contendo os testes de API, em Gherkin, com extensão .robot
      │     └── web
      │           └── arquivos contendo os testes web, em Gherkin, com extensão .robot
      ├── .env.template
      │     └── modelo de variáveis de ambiente
      ├── .gitignore
      │     └── arquivos que não devem ser commitados
      ├── .gitlab-ci.yml
      │     └── configuração da pipeline
      ├── .robocop
      │     └── configuração de análise estática
      ├── README.md
      │     └── Esse doc lindo que você está lendo!
      ├── requirements.txt
      │     └── requisitos para serem instalados antes de executar o projeto.

## 🧩 Padrões e boas práticas
 - Ver seção de [Style Guide](https://cogna.atlassian.net/wiki/spaces/VP/pages/695272048/Playbook+de+automa+o+de+testes#Style-Guide), do Playbook de Automação.
>  Não custa lembrar logo alguns pontos básicos:
> - nome dos arquivo e pastas no padrão_snake_case (separados por \_)
> - variáveis sempre UPPER_CASE
> - nomenclatura de componentes: NOME_DA_PAGINA.NOME_DO_ELEMENTO.TIPO_DO_ELEMENTO. Ex: CADASTRO_ALUNOS.SAVE.BUTTON
> - encapsulamento das variáveis dentro da page
> - utilizar a tag **[Setup]** e **[Teardown]** para iniciar e finalizar um teste ou suíte de testes

## 🛠️ Utilitários

#### Ferramentas para Desenvolvimento
- [x] IDE sugerida: [VS Code](https://code.visualstudio.com/download)
- [x] Terminal sugerido: [Git Bash](https://git-scm.com/downloads)

#### Plugins obrigatórios
- [x] [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [x] [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
- [x] [Robot Framework Language Server](https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp)
- [x] [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [x] [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)

#### Plugins opcionais
- [x] [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)

## 🤖 Integração Robot x Zephyr Scale:
> **Seção em andamento. Processo ainda NÃO aplicado e NÃO vigente.**

A integração do resultados dos testes automatizados com o Zephyr se dá através da API disponibilizada pela ferramenta. As requisições exigem autenticação através de token. Esse token deve ser armazenado no arquivo .env da seguinte forma:

```
ZEPHYR_ACCESS_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9eyJjb
```
É pré-requisito que os casos de testes automatizados no Robot já estejam cadastrados no Zephyr. Além disso, os casos de testes no Robot devem estar identificados pela chave (ID) do casos de testes cadastrado no Zephyr.

Documentações:
[Como gerar access token](http://https://support.smartbear.com/zephyr-scale-cloud/docs/rest-api/generating-api-access-tokens.html "Como gerar access token")
[API Zephyr Scale](https://support.smartbear.com/zephyr-scale-cloud/api-docs/#section/Introductionhttp:// "API Zephyr Scale")

## 📚 Referências
- [Playbook de Automação](https://cogna.atlassian.net/wiki/spaces/VP/pages/695272048/Playbook+de+automa+o+de+testes)
- [Robot](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Browser Library](https://marketsquare.github.io/robotframework-browser/Browser.html)
- [Requests Library](https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html)

## ❓ FAQ
> Dicas e dúvidas sobre o repositório base de automação com Browser Library e sobre outros assuntos relacionados.

Sinta-se à vontade para adicionar novas dúvidas/soluções. Ah, caso não encontre direto no índice, um `ctrl+F` sempre ajuda. Pode não estar no título, mas pode estar dentro do documento.

- [FAQ](#faq)
  - [Como listar minhas dependências Python?](#como-listar-minhas-dependências-python)
  - [O que é o arquivo .robocorp?](#o-que-é-o- arquivo-.robocorp)  
    
#### Como listar minhas dependências Python?
Acesse o terminal e, no diretório do seu projeto, digite:
    ```
    pip freeze
    ```
#### O que é o arquivo .robocop?
Esse arquivo é uma configuração do pacote Robocop (faz análise estática do código) que é instalando junto com as dependências do projeto. A linha inserida nele é para evitar aparecer sublinhados nas keywords.

## 📄 Licença
_adicionar licença do projeto_