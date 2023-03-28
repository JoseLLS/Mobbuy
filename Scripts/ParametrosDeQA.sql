/*RODAR TODA VEZ QUE ATUALIZAR UM BANCO DE QA DE ALGUM CLIENTE*/

UPDATE PARSIS 
SET ParCon = 'N' 
WHERE ParCod = 'SSL_OBRIGATORIO'

UPDATE PARSIS
SET ParCon = 'portal.mobbuyapp.com'
WHERE ParCod = 'CERC_AUTH_HOST_INTERNAL'

UPDATE PARSIS
SET ParCon = 'S'
WHERE ParCod = 'HOMOLOG'

UPDATE PARSIS
SET PARCON = 'ap-homolog.cerc.inf.br'
WHERE PARCOD IN (
'CERC_AUTH_HOST',
'CERC_HOST'
)

UPDATE PARSIS SET PARCON = 0 WHERE PARCOD = 'POLITICA_SENHA'

UPDATE PARSIS
SET ParCon = 'apigateway-qa.mobbuyapp.com'
WHERE ParCod = 'LINKPAGAMENTOAPI_HOST'

UPDATE PARSIS
SET ParCon = 'https://apigateway-qa.mobbuyapp.com'
WHERE ParCod = 'MANAGERAPI_HOST'

UPDATE PARSIS
SET ParCon = 'sistemas.mobbuyapp.com'
WHERE ParCod = 'PORTAL_EC_RESPOSITO_HOST'

UPDATE PARSIS
SET ParCon = 'https://apigateway-qa.mobbuyapp.com'
WHERE ParCod = 'SIMULADORAPI_HOST'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/bemfacilev15/rest/' --Alterar o "bemfacilev15" conforme o cliente
WHERE ParCod = 'URL_GX16_API'

UPDATE PARSIS
SET ParCon = 'https://portal.mobbuyapp.com/bemfacil/servlet/iface_resetsenha?' --Alterar o "bemfacil" conforme o cliente
WHERE ParCod = 'URL_RESET_SENHA'

UPDATE PARSIS
SET ParCon = 'portal.mobbuyapp.com'
WHERE ParCod = 'URL_SISTEMA'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/PosTokenInstWS' --Alterar o "prontoev15" conforme o cliente
WHERE ParCod = 'POS_TOKEN_INST_WS'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15' --Alterar o "prontoev15" conforme o cliente
WHERE ParCod = 'URL_GX16'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/'
WHERE ParCod = 'URL_GX16_API_CAN_CESSAO'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/'
WHERE ParCod = 'URL_CAN_CESSAO_NOVA_VERSAO'

UPDATE PARSIS
SET ParCon = 'http://64.227.0.44:8089/Monitoramento/rest/InsereTransacaoWS'
WHERE ParCod = 'URL_INSERE_TRN_MONITOR'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/SaldoV3EstabelecimentoWS'
WHERE ParCod = 'URL_SALDO_CESSAO'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/api_auth_cerc'
WHERE ParCod = 'URL_TOKEN_CERC'

UPDATE PARSIS
SET ParCon = 'http://64.227.0.44:8089/Monitoramento/rest/MonitoramentoTransacaoWS'
WHERE ParCod = 'URL_VERIFICA_MONITOR'

UPDATE PARSIS SET ParCon = 'https://sistemas.mobbuyapp.com/prontoev15/rest/LiquidaCessaoV2WS'
WHERE PARCOD = 'LIQUIDA_CESSAO'