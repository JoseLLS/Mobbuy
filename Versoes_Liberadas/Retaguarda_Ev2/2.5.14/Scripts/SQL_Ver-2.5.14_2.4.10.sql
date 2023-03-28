/* ALTERAÇÃO DA VERSÃO DO BANCO */

UPDATE PARSIS
SET ParCon = '2.5.14_2.4.10'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '10/03/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'

/* TAREFA #15479 - CARLOS */

--USE BANESE
--USE BEMFACIL
--USE CREDINOV
--USE CREDPAG
--USE PRONTO
--USE SMARTPAGAMENTOS
--USE CredPagLeia

CREATE TABLE [CodigoRetornoTransacoes] (
  [CodigoRetornoTransacoesCod] VARCHAR(32)     NOT NULL,
  [CodigoRetornoTransacoesDsc] VARCHAR(500)     NOT NULL,
      PRIMARY KEY ( [CodigoRetornoTransacoesCod] ))

--use Banese
--use Bemfacil
--use Credinov
--use CredPag
--use Pronto
--use Smartpagamentos
--use CredPagLeia

insert into CodigoRetornoTransacoes (CodigoRetornoTransacoesCod, CodigoRetornoTransacoesDsc)
values 
('00','Transação Autorizada'),
('01','Transação Referida – Emissor'),
('03','Rede Inválida (comerciante)'),
('05','Trn. Não Autorizada – Emissor'),
('06','Erro Genérico'),
('08','Time-out no Emissor/Bandeira'),
('0A','CNPJ wallet não habilitado para  transacionar'),
('0B','Cartão já adicionado a uma carteira'),
('12','Transação Inválida'),
('13','Valor da Transação Inválido'),
('14','Cartão Inválido'),
('15','Instituição não Cadastrada (Emissor sem convênio)'),
('17','Data Invalida'),
('19','Repita a Transação (Tente Novamente)'),
('21','Não foi possível cancelar ou confirmar a transação'),
('23','Parcelamento inválido'),
('25','Registro não encontrado'),
('26','Operação com Id duplicada'),
('30','Erro de formato'),
('31','Instituição não pertence a rede'),
('38','Excedido tentativas de senha'),
('40','Serviço Indisponível'),
('41','Cartão Extraviado'),
('43','Cartão Roubado'),
('51','Saldo Insuficiente'),
('52','Utilize função Crédito'),
('53','Utilize função Débito'),
('54','Cartão e/ou Conta Vencida'),
('55','Senha Inválida'),
('56','Cartão sem registro'),
('57','Serviço Inválido para esse Cliente'),
('58','Transação não permitida conveniado'),
('60','Entrar em contato com o Banrisul'),
('61','Excedido Limite de Saque'),
('62','Cartão Bloqueado'),
('64','Valor da transação não permitido'),
('65','Excedido Freqüência de Saque'),
('68','Time-Out – Não recebida resposta  Instituição Origem'),
('76','Não foi possível confirmar ou cancelar a transação'),
('77','Dados referentes ao registro não são  pertinentes à solicitação original'),
('78','Limite de compra excedido'),
('79','Transação cancelada'),
('80','Data Inválida'),
('81','Chave de Criptografia Inválida'),
('83','Cartão ou Cheque Bloqueado'),
('85','Verificação de Cadastro OK'),
('86','Parcela Inválida'), 
('87','Prazo Inválido'), 
('88','CNAE wallet não permitida para o cartão'),
('89','CNPJ inválido para transacionar'),
('90','Ambiente Indisponível Temporariamente'), 
('91','Instituição Destino Temporariamente  Fora de Serviço'),	
('92','Wallet pendente de aprovação'),
('93','Wallet não habilitado para transacionar'),
('94','Zero dólar com prazo expirado de  liberação no App'),
('N0','Conta Bloqueada'), 
('N1','Via Inválida'), 
('N2','Categoria de Conta Inválida'), 
('N3','Problema sistema: XXX Cod: 99'),
('N4','Agência Inválida'), 
('N5','Agência e/ou Conta Inválida'), 
('N6','Tamanho Inválido'), 
('N7','Erro Retorno PGM: XXXXX Cod: 99'),
('N8','Abend'), 
('NA','Erro de CheckSum'), 
('NB','NPJ/CPF Não Cadastrado'), 
('NR','Serviço bloqueado para o cliente'), 
('NS','Qtd. de parcelas solicitadas superior  a permitida'), 
('NT','Valor solicitado é inferior ao mínimo  permitido'),
('NU','Valor da parcela solicitado é inferior  ao mínimo permitido'),
('NV','Valor solicitado é superior ao  disponível'),
('NW','Quantidade de Parcelas Menor que o  Permitido'),
('NX','Valor disponível inferior ao mínimo  permitido p/ Crédito 1 Minuto'),
('P1','Erro no código de barras'), 
('P2','Encargo não permitido'), 
('P3','Data de vencimento inválida'), 
('P4','Documento vencido'), 
('P5','Valor digitado diferente do código de  barras'),
('P6','Erro no CMC-7 do cheque'), 
('P7','Solicitação de pagamento sem  sessão aberta'),
('P8','Valor não permitido nesta forma de  pagamento'),
('P9','Documento não pode ser pago com  cheque de outros bancos'),
('PA','Documento fora do prazo'), 
('PB','Informação de último NSU ok  incompatível'),
('PC','Abertura com Lote não encerrado'), 
('PD','Documento não pode ser pago com  cheque'),
('PE','Cancelamento de operação que não  do Lote Corrente'),
('PF','Cheque já utilizado'), 
('PG','Feche o lote e recolha à agência'), 
('PH','Lote Aberto em Data Anterior'), 
('PI','Transação não permitida neste  horário'),
('PJ','Código de Pagamento do GPS  inexistente'),
('PK','Competência do GPS inválida'), 
('PL','Identificador GPS Invalido'), 
('PM','Valor INSS GPS Invalido'), 
('PN','Valor Outras Entidades do GPS  Invalido'),
('PO','Valor ATM/Multas e Juros de GPS  Invalido'),
('PP','Valor Total de GPS Invalido'),
('Q0','Solicitação de Fechamento de  Terminal'),
('Q1','Consulta cheque de outro banco'), 
('Q2','Identificador Depósito Inválido'), 
('Q3','Limite de Depósito Excedido'), 
('Q4','Código de Segurança Inválido'), 
('Q5','Senha vencida, verificar na agência'), 
('Q6','Mac Address não cadastrado'), 
('V0','Contate a central do seu cartão'), 
('V1','Desbloqueie o Cartão'), 
('V2','Cartão não permite transações  internacionais'),
('V3','Valor diferente da pré-autorização'), 
('V4','Senha Inválida'), 
('V5','Senha Inválida. Utilize a nova senha'), 
('V6','Lojista, contate o Adquirente'), 
('V7','Conta destino inválida'), 
('V8','Conta origem inválida'), 
('V9','Erro no Cartão'), 
('VA','Suspensão de pagamento recorrente  para serviço'),
('VB','Saque não disponível'), 
('VC','Transação NFC não permitida.  Utilizar CHIP'),
('Y1','Transação EMV aprovada offline'), 
('Y3','Transação EMV aprovada offline por  falta de comunicação'),
('Z1','Transação EMV negada offline'), 
('Z3','Transação EMV negada offline por falta de comunicação')

/* TAREFA #15479 - LÉIA */

USE PRONTO


--Rodar primeiro
INSERT INTO  sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wwAviso', 'wwAviso', 'Avisos', '', '', 0, 1, '')


select * from   sse2_mod where MOD2Id = 'wwAviso'


--Rodar segundo

Select * from sse2_mnu02 where  MnuIteIde = 'wwAviso'

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wwAviso', 'Avisos', 103, 'TAB_GER', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"


--Rodar terceiro
select * from sse2_ung_mod where mod2id = 'wwAviso'

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wwAviso') -- Dar o SELECT de baixo na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

--Rodar quarto
select * from sse2_grp_mod where MOD2Id = 'wwAviso'

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wwAviso') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

/* TAREFA #15541 - LÉIA */

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc] ,[ParTipPar] ,[ParTamPar] ,[ParQtdDec] ,[ParIndSin] ,[ParCon] ,[ParUsuInc] ,[ParDtiInc] ,[ParFlgInt])
     values ('SOLICCANC_EMAILAVISO','Email que vai receber as solicitações de Cancelamento','CA', 255,NULL,'N',null,'Sistema','2022-03-03 00:00:00.000', 0)

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc] ,[ParTipPar] ,[ParTamPar] ,[ParQtdDec] ,[ParIndSin] ,[ParCon] ,[ParUsuInc] ,[ParDtiInc] ,[ParFlgInt])
     values ('SOLICCANC_EMAILMSG','Mensagem do Email de solicitações de Cancelamento','CA', 255,NULL,'N',null,'Sistema','2022-03-03 00:00:00.000', 0)