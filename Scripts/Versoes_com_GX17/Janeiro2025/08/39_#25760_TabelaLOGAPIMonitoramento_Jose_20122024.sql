/* #25760 */

CREATE TABLE [LOG_API] (
  [LOG_API_Cod]             DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [LOG_API_Programa]        NVARCHAR(200)    NOT NULL,
  [LOG_API_DataHora]        DATETIME    NOT NULL,
  [LOG_API_ApiKey]          NVARCHAR(128)    NULL,
  [LOG_API_Usuario]         NVARCHAR(128)    NULL,
  [LOG_API_Estabelecimento] INT    NULL,
  [LOG_API_DadosEntrada]    NVARCHAR(MAX)    NOT NULL,
  [LOG_API_DadosSaida]      NVARCHAR(MAX)    NOT NULL,
  [LOG_API_CessaoId]        DECIMAL(10)    NULL,
     PRIMARY KEY ( [LOG_API_Cod] ))