/* TAREFA #24166 - JOSÉ */

CREATE TABLE [NOTIFICACAO] ( 
  [NotificacaoId]        INT    NOT NULL    IDENTITY ( 1 , 1 ), 
  [NotificacaoMsg]       VARCHAR(200)    NULL, 
  [NotificacaoEc]        SMALLINT    NULL, 
  [NotificacaoVista]     BIT    NULL, 
  [NotificacaoData]      DATETIME    NULL, 
  [NotificacaoDataVista] DATETIME    NULL, 
  [NotificacaoUsuInc]    VARCHAR(40)    NULL, 
     PRIMARY KEY ( [NotificacaoId] ))