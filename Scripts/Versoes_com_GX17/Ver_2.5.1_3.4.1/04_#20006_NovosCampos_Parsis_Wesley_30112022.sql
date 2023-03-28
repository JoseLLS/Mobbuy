ALTER TABLE [MovTrn01] ADD [MovTrnExpControleSaldo] BIT    NULL
ALTER TABLE [VLRPAG]   ADD [VlrPagExpControleSaldo] BIT    NULL

update parsis set parcon = '003.00' where parcod = 'VERSAO_LAYOUT'
 --ANTIGO - 001.7e