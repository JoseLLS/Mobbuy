use MonitorPermite
ALTER TABLE [TrnNaoConf]
ADD [TrnNaoConfMonitorada] BIT  NULL

update TrnNaoConf set TrnNaoConfMonitorada = 0