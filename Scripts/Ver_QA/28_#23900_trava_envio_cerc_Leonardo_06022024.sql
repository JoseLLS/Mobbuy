CREATE TABLE [CercEnvia] (
  [CercEnviaId]        INT    NOT NULL,
  [CercEnviaDescricao] VARCHAR(50)    NOT NULL,
     PRIMARY KEY ( [CercEnviaId] ))

ALTER TABLE [EST]
ADD [CercEnviaId] INT    NULL
CREATE NONCLUSTERED INDEX [IEST8] ON [EST] (
      [CercEnviaId])
ALTER TABLE [EST]
 ADD CONSTRAINT [IEST8] FOREIGN KEY ( [CercEnviaId] ) REFERENCES [CercEnvia]([CercEnviaId])