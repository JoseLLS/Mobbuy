/* TAREFA #21834 */

--Script da base Retaguarda
DROP INDEX [UVAN042] ON [VAN04];

CREATE NONCLUSTERED INDEX [UVAN042] ON [VAN04] (
      [VanTrnDta],
      [VanTrnExpVerNova]);

--Script da base Monitoramento	  
INSERT INTO PARSIS
VALUES ('MNT_TRN_DATA', 'Hoje + D- á ser considerado no filtro da tabela VAN04', 'VA', 1, NULL, 'N', '2', 'ADM', '2023-05-04 16:32:00.000', NULL, NULL, 0);

INSERT INTO Variavel
VALUES (17, 'Data transação', 'A');

INSERT INTO VariavelOperador
VALUES (17, '=');

INSERT INTO VariavelOperador
VALUES (17, '<');

INSERT INTO VariavelOperador
VALUES (17, '<=');

INSERT INTO VariavelOperador
VALUES (17, '>');

INSERT INTO VariavelOperador
VALUES (17, '>=');

ALTER VIEW VwEcCartao AS
SELECT 
       NEWID()             AS 'VwEcCartao_Guid',
       TransacaoMonitorada AS 'VwEcCartao_TransacaoMonitorada',
	   TransacaoData       AS 'VwEcCartao_TransacaoData',
	   TransacaoEc         AS 'VwEcCartao_TransacaoEc',
	   TransacaoNumCar     AS 'VwEcCartao_TransacaoNumCar',
	   COUNT(*)            AS 'VwEcCartao_TransacaoQtd'
	   FROM TRANSACAO WITH(NOLOCK) 
WHERE TransacaoMonitorada = 0 AND TransacaotrnCod <> 'CC' AND TransacaoStatus <> 'Cancelada'
GROUP BY TransacaoMonitorada, 
         TransacaoData, 
		 TransacaoEc, 
		 TransacaoNumCar;
		 
ALTER VIEW VwEcCartaoValor AS
SELECT 
       NEWID()             AS 'VwEcCartaoValor_Guid',
       TransacaoMonitorada AS 'VwEcCartaoValor_TransacaoMonitorada',
	   TransacaoData       AS 'VwEcCartaoValor_TransacaoData',
	   TransacaoEc         AS 'VwEcCartaoValor_TransacaoEc',
	   TransacaoNumCar     AS 'VwEcCartaoValor_TransacaoNumCa',
	   TransacaoValor      AS 'VwEcCartaoValor_TransacaoValor',
	   COUNT(*)            AS 'VwEcCartaoValor_TransacaoQtd'
	   FROM TRANSACAO WITH(NOLOCK) 
WHERE TransacaoMonitorada = 0 AND TransacaotrnCod <> 'CC' AND TransacaoStatus <> 'Cancelada'
GROUP BY TransacaoMonitorada, 
         TransacaoData, 
		 TransacaoEc, 
		 TransacaoNumCar,
		 TransacaoValor;