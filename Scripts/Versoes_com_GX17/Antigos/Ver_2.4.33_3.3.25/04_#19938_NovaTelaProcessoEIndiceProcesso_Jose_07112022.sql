/* TAREFA #19938 - JOSÉ */

--Rodar o script em todos os clientes atualizados
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ProcessoGrid', 'ProcessoGrid', 'Processo', '', '', 0, 1, '')

SELECT * FROM sse2_mod

SELECT * FROM sse2_mnu02 ORDER BY MnuIteIdRoot, MnuIteOrd --SELECT para ver a ordenação (MnuIteOrd) que a tela vai ficar no menu no INSERT abaixo
--A ordenação é em ordem crescente

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ProcessoGrid', '', 150, 'TAB_GER', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'ProcessoGrid') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'ProcessoGrid') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

---------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UPROCESSO1] ON [Processo] (
      [ProcessoDataInicial],
      [ProcessoDataFinal],
      [ProcessoStatus])