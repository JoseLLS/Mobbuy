/* TAREFA #20864 - JOSÉ */

USE Pronto

--Rodar script em todos os clientes que serão atualizados
CREATE TABLE [MovimentacaoBobina] (
  [MovBobinaId]        INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [MovBobinaTipo]      CHAR(20)    NULL,
  [MovBobinaDtaEnvRem] DATETIME    NULL,
  [MovBobinaQnt]       SMALLINT    NULL,
  [EstCod]             INT    NULL,
     PRIMARY KEY ( [MovBobinaId] ))

ALTER TABLE [MovimentacaoBobina]
ADD CONSTRAINT [IMOVIMENTACAOBOBINA1] FOREIGN KEY ( [EstCod] ) REFERENCES [EST]([EstCod])
 
CREATE NONCLUSTERED INDEX [UMOVIMENTACAOBOBINA] ON [MovimentacaoBobina] (
      [EstCod],
      [MovBobinaTipo],
      [MovBobinaDtaEnvRem] DESC)
 
 ------------------------------------------------------------------------------------------------------------------
 
 CREATE TABLE [BobinaParametro] (
  [BobinaParId]     SMALLINT    NOT NULL,
  [BobinaParQtdEnv] SMALLINT    NULL,
  [BobinaParQtdVen] SMALLINT    NULL,
  [BobinaParQtdMin] SMALLINT    NULL,
     PRIMARY KEY ( [BobinaParId] ))
	 
-------------------------------------------------------------------------------------------------------------------
	 
CREATE TABLE [BobinaEmail] (
  [BobinaEmailId]     INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [BobinaEmailDtaEnv] DATETIME    NULL,
  [MovBobinaId]       INT    NULL,
     PRIMARY KEY ( [BobinaEmailId] ))

CREATE NONCLUSTERED INDEX [IBOBINAEMAIL1] ON [BobinaEmail] (
      [MovBobinaId])

ALTER TABLE [BobinaEmail]
ADD CONSTRAINT [IBOBINAEMAIL1] FOREIGN KEY ( [MovBobinaId] ) REFERENCES [MovimentacaoBobina]([MovBobinaId])
 
--------------------------------------------------------------------------------------------------------------------
 
UPDATE PARSIS
SET ParCon = '<p>Caro Administrador,<br /><br />&emsp;&emsp;&emsp;Acaba de ser registrado em nosso sistema</p><p>&emsp;&emsp;&emsp;Nova Solicita&ccedil;&atilde;o de Bobina&nbsp;</p>&emsp;&emsp;&emsp;Registrada pelo [ORIGEM] <br><br>&emsp;&emsp;&emsp;EC:<br><b>&emsp;&emsp;&emsp;[ESTABELECIMENTO]</b><br><br>&emsp;&emsp;&emsp;Favor Providenciar ou entrar em contato.<P>Atenciosamente<br>Sistema</p><u>Nâo responda essa mensagem ela é automática e gerada pelo sistema de Gestão de SubAdquirentes</u>'
WHERE ParCod = 'SOLICITABOBINA_EMAILMSG'

----------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MovBobina_Grid', 'MovBobina_Grid', 'Movimentação de bobinas', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MovBobina_Grid', '', 80, 'SUPRIMENTOS', '', '/pronto/servlet/') --Alterar o 'pronto' conforme o projeto do cliente atualizado

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MovBobina_Grid') --Alterar o '25' conforme a unidade de negócio do cliente atualizado

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'MovBobina_Grid') --Alterar o '25' conforme a unidade de negócio do cliente atualizado