
use Banese

-- Inserção da tela "Lista de tipos de documentos" no módulo de telas
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ConcPagBanese', 'ConcPagBanese', 'Conciliação Pagamentos', '', '', 0, 1, '')


-- Onde está trTipoDocumentosGrid: Nome da tela que vai ficar no menu
-- Onde está "Lista de tipos de documentos": Descrição da tela

-- Inserção da tela "Lista de tipos de documentos" no menu
INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ConcPagBanese', 'Conciliação Pagamentos', 280, 'CTR_FIN', '', '/banese/servlet/')

-- Onde está /pronto/servlet/: substituir "pronto" pelo nome do cliente.
-- Onde está TAD_GER: Categoria do menu, por exemplo: TAD_GER = Telas que ficam em tabelas gerais.
-- Onde está 11: A ordenação da tela dentro da categoria do menu.

-- Consulta para verificar as telas da categoria TAB_GER
--SELECT * FROM sse2_mnu02 WHERE MnuIteIdRoot = 'TAB_GER' ORDER BY MnuIteOrd

-- Inserção do vínculo da tela com o cliente no módulo de negócio
INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (12, 'ConcPagBanese') -- Para a tela de Lista de tipos de documentos

-- Onde está 25: Cada cliente tem um código de negócio único. Pronto é 25, Credpag é 24, Permite é 30, etc.
-- Pode consultar o código na tabela de parâmetros: PARSIS, parâmetro: UNINEG.

-- Inserção no grupo de módulos com permissões de ADM
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'ConcPagBanese') -- Sempre será ADM para Lista de tipos de documentos