*** Settings ***
Library     Browser
Resource    ../../pages/sample_page.resource
Resource    ../../hooks/HOOKS.resource
Resource    ../../commom/constants.resource

*** Keywords ***
# Este é o local onde deve-se incluir métodos complexos, que acessam ou aplicam lógica entre vários elementos
acesso a página
    Take Screenshot          open-1.png

a página está disponível
    Get Text    ${PAGE.MESSAGE}    equal       Inovação e educação em sintonia

o título da página está correto
    Get Title     equal      ${PAGE.TITLE}

é possível aceitar os cookies
    Click                     ${COOKIES.OK.BUTTON}
    Take Screenshot           pagina-inicial-1.png

é possível acessar a página de resultados
    Click                     ${MORE_RESULTS.BUTTON}
    Take Screenshot           pagina-resultados-1.png