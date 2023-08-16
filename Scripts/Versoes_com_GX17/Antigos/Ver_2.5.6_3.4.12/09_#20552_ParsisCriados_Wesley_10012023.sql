--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_HOST'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_BASEURL'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_CODSUBEMPRESA'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_CLIENTID'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_USUARIO'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_SENHA'

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_HOST', 'Host da API de transações PIX', 'CA', 80, 'N', 'www.mobbuyapp.com:10443')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_BASEURL', 'BaseUrl da API de transações PIX', 'CA', 80, 'N', '/InterfaceManagerMobbuy/interface/processos/apipix/')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_CODSUBEMPRESA', 'CodSubEmpresa da API de transações PIX', 'CA', 80, 'N', '1002')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_CLIENTID', 'ClientId da API de transações PIX', 'CA', 80, 'N', 'c11863329d7eca1d8f8172a9578ae9f5')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_USUARIO', 'Usuario da API de transações PIX', 'CA', 80, 'N', 'mobbuyguest')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_SENHA', 'Senha da API de transações PIX', 'CA', 80, 'N', '8f543df1d7571e92db14b5fa067552e6')
