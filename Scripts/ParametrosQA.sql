/* Lembrar de trocar o nome do cliente das URLs se necessário */

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/Alerta_Percentual_Estatistica'
WHERE ParCod = 'API_MONITOR_PERC_ESTAT'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosev15/rest/api_calcularesultadosimulador'
WHERE ParCod = 'API_SIMULADOR'

UPDATE PARSIS
SET ParCon = 'S'
WHERE ParCod = 'HOMOLOG'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/InsereEstAPI'
WHERE ParCod = 'MNT_INSEREESTAPI'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/prMovTransferenciaInsere'
WHERE ParCod = 'MNT_MOV_TRANSF'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/prTrnNaoConfirmadasIns'
WHERE ParCod = 'MNT_TRN_N_CONF'

UPDATE PARSIS
SET ParCon = 'sistemas.mobbuyapp.com'
WHERE ParCod = 'PORTAL_EC_RESPOSITO_HOST'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosev15/rest/PosTokenInstWS'
WHERE ParCod = 'POS_TOKEN_INST_WS'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosev15'
WHERE ParCod = 'URL_GX16'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosev15/rest/'
WHERE ParCod = 'URL_GX16_API'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/InsereTransacaoWS'
WHERE ParCod = 'URL_INSERE_TRN_MONITOR'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosparcom'
WHERE ParCod = 'URL_PARCEIRO'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentos/servlet/iface_resetsenha?'
WHERE ParCod = 'URL_RESET_SENHA'

UPDATE PARSIS
SET ParCon = 'sistemas.mobbuyapp.com'
WHERE ParCod = 'URL_SISTEMA'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/smartpagamentosev15/rest/api_auth_cerc'
WHERE ParCod = 'URL_TOKEN_CERC'

UPDATE PARSIS
SET ParCon = 'https://sistemas.mobbuyapp.com/MonitoramentoPermite/rest/MonitoramentoTransacaoWS'
WHERE ParCod = 'URL_VERIFICA_MONITOR'