*** Settings ***
Documentation    Amostra de teste: verificando disponibilidade da página
Library     Browser
Resource    ../../pages/sample_page.resource
Resource    ../../hooks/HOOKS.resource
Resource    ../../steps/web/sample_step.resource
Resource    ../../commom/constants.resource

*** Test Cases ***
Site da Cogna disponível
    [Setup]    Iniciar sessão web    ${BROWSER}    ${HEADLESS}
    Given acesso a página
    Then a página está disponível
    And o título da página está correto
    And é possível aceitar os cookies
    And é possível acessar a página de resultados    
    [Teardown]    Finalizar sessão web
