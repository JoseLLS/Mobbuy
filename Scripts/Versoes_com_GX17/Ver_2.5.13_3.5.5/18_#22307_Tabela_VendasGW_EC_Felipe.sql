
ALTER TABLE [EST]
ADD [TavNumGW] SMALLINT    NULL
CREATE NONCLUSTERED INDEX [IEST6] ON [EST] (
      [TavNumGW])
ALTER TABLE [EST]
 ADD CONSTRAINT [IEST6] FOREIGN KEY ( [TavNumGW] ) REFERENCES [TABVEN]([TavNum])