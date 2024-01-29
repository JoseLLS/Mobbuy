/* TAREFA #23787 - JOSÉ */

--Rodar em todos os clientes que atualizar

CREATE TABLE [Robo] (
  [RoboId]        SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [RoboNome]      VARCHAR(40)    NULL,
  [RoboArquivo]   VARCHAR(40)    NULL,
  [RoboParm1Nome] VARCHAR(40)    NULL,
  [RoboParm2Nome] VARCHAR(40)    NULL,
  [RoboUsuInc]    VARCHAR(40)    NULL,
  [RoboUsuAlt]    VARCHAR(40)    NULL,
  [RoboDtaInc]    DATETIME    NULL,
  [RoboDtaAlt]    DATETIME    NULL,
  [RoboStatus]    BIT    NULL,
     PRIMARY KEY ( [RoboId] ));
	 
INSERT INTO Robo
VALUES('Rede Captura', 'pronto_redecaptura.sh', 'Data Inicial', NULL, 'ADMIN', NULL, GETDATE(), NULL, 1);

INSERT INTO Robo
VALUES('Importar Trn', 'importar_trn_rede_cap.sh', NULL, NULL, 'ADMIN', NULL, GETDATE(), NULL, 1);

INSERT INTO Robo
VALUES('Integração Manager', 'integracao_manager.sh', 'Data Inicial', 'Data Final', 'ADMIN', NULL, GETDATE(), NULL, 1);

INSERT INTO Robo
VALUES('Robô Vero', 'robo_vero.sh', NULL, NULL, 'ADMIN', NULL, GETDATE(), NULL, 1);