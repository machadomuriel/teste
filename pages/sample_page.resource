*** Settings ***
Library    Browser

*** Variables ***
${PAGE.TITLE}                 Cogna: Inovação e educação em sintonia
${PAGE.MESSAGE}               xpath=//h2[text()='Inovação e educação em sintonia']
${MORE_RESULTS.BUTTON}        xpath=//button[span[text()='Mais resultados']]
${COOKIES.OK.BUTTON}          xpath=//button[span[text()='Ok']]