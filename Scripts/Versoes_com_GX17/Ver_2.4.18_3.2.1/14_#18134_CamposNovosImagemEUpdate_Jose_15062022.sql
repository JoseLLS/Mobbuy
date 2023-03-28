/* TAREFA #18134 - JOSÉ */

USE Banese
USE BemFacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

ALTER TABLE [CONFIGURACAO] 
ADD [ConfigAplicacao] VARCHAR(40)    NULL,
	[ConfigImgLogoIcone_GXI] VARCHAR(2048)    NULL, 
    [ConfigImgLogoIcone] VARBINARY(MAX)    NULL,
	[ConfigImgAvatar_GXI] VARCHAR(2048)    NULL, 
    [ConfigImgAvatar] VARBINARY(MAX)    NULL

USE Banese

UPDATE Configuracao
SET ConfigAplicacao = 'baneseev15'

USE BemFacil

UPDATE Configuracao
SET ConfigAplicacao = 'bemfacilev15'
WHERE ConfigId = 1

UPDATE Configuracao
SET ConfigAplicacao = 'prosperaev15'
WHERE ConfigId = 2

USE Credinov

UPDATE Configuracao
SET ConfigAplicacao = 'credinovev15'

USE Credpag

UPDATE Configuracao
SET ConfigAplicacao = 'credpagev15'

USE Pronto

UPDATE Configuracao
SET ConfigAplicacao = 'prontoev15'

USE SmartPagamentos

UPDATE Configuracao
SET ConfigAplicacao = 'smartpagamentosev15'