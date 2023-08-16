CREATE NONCLUSTERED INDEX [UTRNPAGSEG3] ON [TrnPagSeg] (
      [TrnPagSegSituacaoProcesso],
      [TrnPagSegTipoEvento])

CREATE NONCLUSTERED INDEX [UTRNPAGSEG4] ON [TrnPagSeg] (
      [TrnPagSegNsu],
      [TrnPagSegSituacaoProcesso],
      [TrnPagSegTipoEvento])