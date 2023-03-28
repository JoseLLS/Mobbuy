
/* TAREFA #15825 - LÉIA */  

CREATE TABLE [Processo] (
  [ProcessoId]          INT     NOT NULL     IDENTITY ( 1 , 1 ),
  [ProcessoRotina]      VARCHAR(40)  NULL,
  [ProcessoDataInicial] DATETIME     NULL,
  [ProcessoDataFinal]   DATETIME     NULL,
  [ProcessoMensagem]    VARCHAR(MAX) NULL,
  [ProcessoStatus]      VARCHAR(40)  NULL,
      PRIMARY KEY ( [ProcessoId] ));


 
 
 
 