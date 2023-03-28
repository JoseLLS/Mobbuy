

CREATE TABLE [AVISO] ( 
  [AvisoId]             INT NOT NULL IDENTITY ( 1 , 1 ),
  [AvisoTitulo]         VARCHAR(50)    NULL, 
  [AvisoSituacao]       CHAR(1)    NULL, 
  [AvisoDataHora]       DATETIME    NULL, 
  [AvisoInsUsuarioId]   VARCHAR(100)    NULL, 
  [AvisoInsUsuarioNome] VARCHAR(100)    NULL, 
  [AvisoPeriodoInicial] DATETIME    NULL, 
  [AvisoPeriodoFinal]   DATETIME    NULL, 
  [AvisoTexto]          VARCHAR(MAX)    NULL, 
  [AvisoImagem]         VARBINARY(MAX)    NULL, 
  [AvisoImagem_GXI]     VARCHAR(2048)    NULL, 
     PRIMARY KEY ( [AvisoId] ))
	 
	 
CREATE TABLE [AVISOUSUARIO] ( 
  [AvisoId]              INT    NOT NULL, 
  [AvisoUsuarioId]       VARCHAR(100)    NOT NULL, 
  [AvisoUsuarioNome]     VARCHAR(100)    NULL, 
  [AvisoUsuarioDataHora] DATETIME    NULL, 
  [AvisoUsuarioLida]     BIT   NULL, 
     PRIMARY KEY ( [AvisoId],[AvisoUsuarioId] ))
ALTER TABLE [AVISOUSUARIO] 
 ADD CONSTRAINT [IAVISOUSUARIO1] FOREIGN KEY ( [AvisoId] ) REFERENCES [AVISO]([AvisoId])

 
 
 
 