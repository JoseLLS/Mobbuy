/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.36','2.5.35',GETDATE());

/* TAREFA #23982 -  JOSÉ */

INSERT INTO PARSIS
VALUES ('MANAGER_TRN_CAPTURA','Url da API de transações da captura','VA',100,NULL,'N','/InterfaceManagerMobbuy/interface/api/transacoes/captura','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('MANAGER_URL','Url do manager','VA',100,NULL,'N','www.mobbuyapp.com:10443','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL','E-mails para envio de alerta de bloqueio de transações (separados por ";").','VA',200,NULL,'N',
'compliance@semprepronto.com.br;financeiro@semprepronto.com.br','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL_MSG','Corpo do e-mail para envio de alerta de bloqueio de transações.','VA',200,NULL,'N',
'<p>Realizamos o bloqueio das transações do EC [EC] e POS [POS] devido a divergência de informações com o sistema Retaguarda.<br>Favor verificar.</p>','ADMIN',GETDATE(),NULL,NULL,0);

/* TAREFA #24046 - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpTranBloq', 'wpTranBloq', 'Transações bloqueadas compliance', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpTranBloq', '', 60, 'AUDITORIA', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpTranBloq');

INSERT INTO sse2_grp_mod (UNG2Cod, USR2GrpId, MOD2Id)
VALUES (25, 'ADM', 'wpTranBloq');

/* TAREFA #24118 - JOSÉ */

INSERT INTO PARSIS
VALUES ('LINKPAGAMENTO_VALOR','Valor máximo do link de pagamento','NU','15',NULL,'N','100000','ADMIN',GETDATE(),NULL,NULL,0);