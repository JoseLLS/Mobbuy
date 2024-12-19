INSERT INTO SQLHistorico
VALUES ('3.8.4','2.6.3',GETDATE());

------------------------------------------------------------------------------------------------------------------------

use Banese

-- Inser��o da tela "Lista de tipos de documentos" no m�dulo de telas
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ConcPagBanese', 'ConcPagBanese', 'Concilia��o Pagamentos', '', '', 0, 1, '')


-- Onde est� trTipoDocumentosGrid: Nome da tela que vai ficar no menu
-- Onde est� "Lista de tipos de documentos": Descri��o da tela

-- Inser��o da tela "Lista de tipos de documentos" no menu
INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ConcPagBanese', 'Concilia��o Pagamentos', 280, 'CTR_FIN', '', '/banese/servlet/')

-- Onde est� /pronto/servlet/: substituir "pronto" pelo nome do cliente.
-- Onde est� TAD_GER: Categoria do menu, por exemplo: TAD_GER = Telas que ficam em tabelas gerais.
-- Onde est� 11: A ordena��o da tela dentro da categoria do menu.

-- Consulta para verificar as telas da categoria TAB_GER
--SELECT * FROM sse2_mnu02 WHERE MnuIteIdRoot = 'TAB_GER' ORDER BY MnuIteOrd

-- Inser��o do v�nculo da tela com o cliente no m�dulo de neg�cio
INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (12, 'ConcPagBanese') -- Para a tela de Lista de tipos de documentos

-- Onde est� 25: Cada cliente tem um c�digo de neg�cio �nico. Pronto � 25, Credpag � 24, Permite � 30, etc.
-- Pode consultar o c�digo na tabela de par�metros: PARSIS, par�metro: UNINEG.

-- Inser��o no grupo de m�dulos com permiss�es de ADM
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'ConcPagBanese') -- Sempre ser� ADM para Lista de tipos de documentos