use Pronto
ALTER TABLE AntManual ADD AntManualTipo SMALLINT NULL
UPDATE AntManual SET AntManualTipo = 1
INSERT INTO AntManual(AntManualSegmento,AntManualTaxa, AntManualUsuInc,AntManualUsuAlt,AntManualDtaInc,AntManualDtaAlt) (SELECT AntManualSegmento,AntManualTaxa, AntManualUsuInc,AntManualUsuAlt,AntManualDtaInc,AntManualDtaAltFROM AntManual)
UPDATE AntManual SET AntManualTipo = 2 WHERE AntManualiD >= 9