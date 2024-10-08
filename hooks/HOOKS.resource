*** Settings ***
Library        Browser
Library        RequestsLibrary
Library        DatabaseLibrary
Library        String
Library        OperatingSystem
Library        ../commom/load_env.py
Resource       ../commom/constants.resource

*** Variables ***
${ENV}    STG

*** Keywords ***
Conectar com banco do tenant
    [Arguments]    ${TENANT}
    Connect To Database    psycopg2    %{DB_NAME}    %{DB_USER}    %{DB_PASSWORD}    %{DB_HOST}    %{DB_PORT}
    #Verificando se o tenant é Kroton, pois o nome do schema no banco é diferente
    IF    '${TENANT}' == 'KROTON'
        Set Suite Variable    ${DB_SCHEMA}    public
    ELSE
        ${DB_SCHEMA}    Convert To Lower Case       ${TENANT}
        Set Suite Variable    ${DB_SCHEMA}
    END

#Teste Web
Iniciar sessão web
    [Arguments]     ${BROWSER}      ${HEADLESS}
        Log    Executando testes no browser: ${BROWSER}
        New Browser           browser=${BROWSER}    headless=${HEADLESS}
        New Page              ${BASE_URL}

#Teste Web
Finalizar sessão web
    Take Screenshot
    Close Browser

#Teste API
Criar sessão para requisição
    [Arguments]        ${ALIAS}            ${TENANT}        ${API}
    Create Session     ${ALIAS}            ${${ENV}_BASE_URL_${TENANT}}${API}      disable_warnings=True

#Teste API
Gerar token
    [Arguments]        ${ALIAS}
    ...    ${TENANT}     
    ...    ${API}
    ...    ${USERNAME}
    ...    ${PASSWORD}
	Criar sessão para requisição     ${ALIAS}    ${TENANT}   ${API}
    &{HEADERS}         Create Dictionary     Content-type=application/json
    ${RESPONSE}        POST On Session       ${ALIAS}       /auth/login
    ...           data={"username":"${USERNAME}","password":"${PASSWORD}"}
    ...           headers=${HEADERS}
    Set Suite Variable                       ${TOKEN}    Bearer ${RESPONSE.json()['token']}

#Teste WEB e API
Limpar dados de testes
    [Arguments]    ${TENANT}    ${PATH_SQL}
        [Teardown]    Disconnect From All Databases
        Conectar com banco do tenant    ${TENANT}
        ${SQL_SCHEMA}    Get File          ${PATH_SQL}
        ${SQL_SCHEMA}    Replace String    ${SQL_SCHEMA}    {DB_SCHEMA}    ${DB_SCHEMA}
        
        Execute Sql String    ${SQL_SCHEMA}

#Preparando variáveis dinâmicas para teste - Falta concluir
Definir user e senha     
    [Arguments]    ${TENANT}    ${APPLICATION}
    [Teardown]    Disconnect From All Databases
    Conectar com banco do tenant    ${TENANT}
        
    #Verificando qual a aplicação precisa definir usuário, pois são regras diferentes
    IF    '${APPLICATION}' == 'ERP'
        @{QUERY}    Query      
    ...    SELECT cpf,id,nome FROM ${DB_SCHEMA}.pessoa ORDER BY RANDOM() LIMIT 10;
    
    Set Suite Variable     ${USER_${TENANT}_${ENV}}        ${QUERY[0][0]}
    Set Suite Variable     ${PASSWORD_${TENANT}_${ENV}}    ${QUERY[0][0]}
    Set Suite Variable     ${ID_USER_${TENANT}_${ENV}}     ${QUERY[0][1]}
    Set Suite Variable     ${USERNAME_${TENANT}_${ENV}}    ${QUERY[0][2]}
    
    Log To Console        ${USER_${TENANT}_${ENV}}   
    Log To Console        ${PASSWORD_${TENANT}_${ENV}}
    Log To Console        ${ID_USER_${TENANT}_${ENV}}
    Log To Console        ${USERNAME_${TENANT}_${ENV}}

    Set Env Variables      
    ...    ${TENANT}    
    ...    ${ENV}    
    ...    ${USER_${TENANT}_${ENV}}   
    ...    ${PASSWORD_${TENANT}_${ENV}}   
    ...    ${ID_USER_${TENANT}_${ENV}}    
    ...    ${USERNAME_${TENANT}_${ENV}}

    ELSE IF    '${APPLICATION}' == 'LMS'
            @{QUERY}    Query      
    ...    SELECT cpf,id,nome FROM ${DB_SCHEMA}.pessoa ORDER BY RANDOM() LIMIT 10;
      
    Set Suite Variable     ${USER_${TENANT}_${ENV}}        ${QUERY[0][0]}
    Set Suite Variable     ${PASSWORD_${TENANT}_${ENV}}    ${QUERY[0][0]}
    Set Suite Variable     ${ID_USER_${TENANT}_${ENV}}     ${QUERY[0][1]}
    Set Suite Variable     ${USERNAME_${TENANT}_${ENV}}    ${QUERY[0][2]}
    
    Log To Console        ${USER_${TENANT}_${ENV}}   
    Log To Console        ${PASSWORD_${TENANT}_${ENV}}
    Log To Console        ${ID_USER_${TENANT}_${ENV}}
    Log To Console        ${USERNAME_${TENANT}_${ENV}}
       
    Set Env Variables      
    ...    ${TENANT}    
    ...    ${ENV}    
    ...    ${USER_${TENANT}_${ENV}}   
    ...    ${PASSWORD_${TENANT}_${ENV}}   
    ...    ${ID_USER_${TENANT}_${ENV}}    
    ...    ${USERNAME_${TENANT}_${ENV}}
    
    END