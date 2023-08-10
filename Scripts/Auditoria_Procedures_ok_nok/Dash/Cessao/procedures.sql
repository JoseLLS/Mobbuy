USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcMobCessaoPagoSint]    Script Date: 01/08/2023 09:52:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConcMobCessaoPagoSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(CessaoValor), 0)	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
	AND CessaoTipoId = 2
END

GO


USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcMobCessaoPedSint]    Script Date: 01/08/2023 09:53:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConcMobCessaoPedSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(CessaoValor), 0)	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
END

GO


USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcAPICessaoPagoSint]    Script Date: 01/08/2023 09:53:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConcAPICessaoPagoSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(CessaoValor), 0)	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
	AND CessaoNFDistribuidora <> ''
END
GO


USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcAPICessaoPedSint]    Script Date: 01/08/2023 09:53:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConcAPICessaoPedSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(B.CessaoDetValor), 0)	
	FROM Cessao A
	INNER JOIN 
	CESSAODETALHE B
	ON A.CessaoId = B.CessaoId
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
END
GO


