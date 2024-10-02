use pronto

CREATE TABLE [EstabCnae] (
  [EC_Cnae_EstCod]  INT    NOT NULL,
  [EC_Cnae_CNPJ]    DECIMAL(15)    NULL,
  [EC_Cnae_CodCnae] CHAR(7)    NULL,
     PRIMARY KEY ( [EC_Cnae_EstCod] ))