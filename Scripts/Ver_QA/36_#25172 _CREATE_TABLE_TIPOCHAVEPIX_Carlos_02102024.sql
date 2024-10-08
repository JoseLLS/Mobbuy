use Pronto

CREATE TABLE [TipoChavePix] (
  [TipoChavePixID]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [TipoChavePixDsc]    CHAR(50)    NOT NULL,
  [TipoChavePixSts]    BIT    NOT NULL,
  [TipoChavePixUsuInc] CHAR(20)    NULL,
  [TipoChavePixDtaInc] DATETIME    NULL,
  [TipoChavePixUsuAlt] CHAR(20)    NULL,
  [TipoChavePixDtaAlt] DATETIME    NULL,
     PRIMARY KEY ( [TipoChavePixID] ))

INSERT INTO TipoChavePix VALUES
('CELULAR',1,'025ADM','2024-10-02','',''),
('E-MAIL',1,'025ADM','2024-10-02','',''),
('CPF',1,'025ADM','2024-10-02','',''),
('CNPJ',1,'025ADM','2024-10-02','','')