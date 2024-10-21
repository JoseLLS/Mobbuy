/* TAREFA #25099 - RUAN */

CREATE TABLE [Usuario] (
  [UsuarioGuid]  NCHAR(40)    NOT NULL,
  [UsuarioNome]  NVARCHAR(40)    NOT NULL,
  [UsuarioEmail] NVARCHAR(100)    NOT NULL,
  [UsuarioLogin] NVARCHAR(100)    NOT NULL,
  [UsuarioAtivo] BIT    NOT NULL,
     PRIMARY KEY ( [UsuarioGuid] ))