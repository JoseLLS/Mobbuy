/* TAREFA #25286 - JOSÉ */

INSERT INTO PARSIS
VALUES ('ARQ_SLC_RTM','Caminho de arquivos de retorno RTM','VA',300,NULL,'N','/mnt/home1/SubAdquirencia/025/reembolso/SLC/retorno/','ADMIN',GETDATE(),NULL,NULL,0);

CREATE TABLE [RTMArquivo] (
  [RTMArquivoId]   INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [RTMArquivoNome] VARCHAR(80)    NULL,
  [RTMArquivoData] DATETIME    NULL,
     PRIMARY KEY ( [RTMArquivoId] ));
	 
CREATE TABLE [RTMArqDet] (
  [RTMArquivoId]   INT    NOT NULL,
  [RTMArqDetId]    INT    NOT NULL,
  [RTMArqDetDados] VARCHAR(MAX)    NULL,
     PRIMARY KEY ( [RTMArquivoId],[RTMArqDetId] ))
ALTER TABLE [RTMArqDet]
 ADD CONSTRAINT [IRTMARQDET1] FOREIGN KEY ( [RTMArquivoId] ) REFERENCES [RTMArquivo]([RTMArquivoId]);