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
VALUES('Rede Captura', 'Data Inicial', NULL, 'ADMIN', NULL, GETDATE(), NULL, 1, 'pronto_redecaptura.sh');

INSERT INTO Robo
VALUES('Importar Trn', NULL, NULL, 'ADMIN', NULL, GETDATE(), NULL, 1, 'importar_trn_rede_cap.sh');

INSERT INTO Robo
VALUES('Integração Manager', 'Data Inicial', 'Data Final', 'ADMIN', NULL, GETDATE(), NULL, 1, 'integracao_manager.sh');

INSERT INTO Robo
VALUES('Robô Vero', NULL, NULL, 'ADMIN', NULL, GETDATE(), NULL, 1, 'robo_vero.sh');