DROP INDEX [UVLRPAG7] ON [VLRPAG]

CREATE NONCLUSTERED INDEX [UVLRPAG7] ON [VLRPAG] ( 
      [VlpIdCreditTransactionPai], 
      [EstCod])


CREATE NONCLUSTERED INDEX [UVLRPAG11] ON [VLRPAG] ( 
[VlpIdCreditTransaction], 
[EstCod], 
[VlpVlrPag])