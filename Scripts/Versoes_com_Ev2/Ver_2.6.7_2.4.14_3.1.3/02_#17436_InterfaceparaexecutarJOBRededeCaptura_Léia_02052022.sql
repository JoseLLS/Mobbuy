
CREATE NONCLUSTERED INDEX [UVAN023] ON [VAN02] (
      [VanCod],
      [VanWbsDat],
      [VanWbsSeq] DESC)
	  
CREATE NONCLUSTERED INDEX [UVAN024] ON [VAN02] (
      [VanWbsDat] DESC,
      [VanWbsSta])

CREATE NONCLUSTERED INDEX [UVAN025] ON [VAN02] (
      [VanWbsDat],
      [VanWbsNumSer],
      [VanWbsNumCrt],
      [VanWbsVlr])	  