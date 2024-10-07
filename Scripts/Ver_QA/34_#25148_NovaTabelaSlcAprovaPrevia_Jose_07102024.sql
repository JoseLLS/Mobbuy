/* TAREFA #25148 - JOSÉ */

CREATE TABLE [SLCAPROVAPREVIA] ( 
  [SlcAprovaPreviaId]  INT    NOT NULL    IDENTITY ( 1 , 1 ), 
  [SlcNomeArquivo]     VARCHAR(50)    NULL, 
  [SlcDataPagamento]   DATETIME    NULL, 
  [SlcSequencial]      INT    NULL, 
  [SlcDocFavorecido]   VARCHAR(14)    NULL, 
  [SlcValor]           DECIMAL(17,2)    NULL, 
  [SlcStatusPrevia]    VARCHAR(40)    NULL, 
  [SlcStatusProc]      SMALLINT    NULL, 
  [SlcDataInclusao]    DATETIME    NULL, 
  [SlcUsuarioInclusao] VARCHAR(40)    NULL, 
  [SlcDataAlteracao]   DATETIME    NULL, 
     PRIMARY KEY ( [SlcAprovaPreviaId] ));