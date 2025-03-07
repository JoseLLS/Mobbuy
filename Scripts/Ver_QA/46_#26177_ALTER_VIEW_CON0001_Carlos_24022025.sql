--EXCLUSIVO PARA CLIENTES EDANPAY E NEOPAGAMENTOS
USE Edanpay 
--USE neopagamentos 
GO
/****** Object:  View [dbo].[CON0001]    Script Date: 24/02/2025 15:27:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 ALTER   View [dbo].[CON0001] As

	Select top 100 * From (																								
		select   NewID() ConTrnId, 
				'Van04' ConTrnOri, 
				a.MovTrnDta ConTrnDta, 
				a.EstCod  ConTrnEstCod, 
				a.MovTrnBan as ConTrnBan,  
				a.MovTrnTipPrd ConTrnTipPrd, 
				a.MovTrnNsu   ConTrnNsu, 
				a.MovTrnVlr ConTrnVlr , 
				a.MovTrnNumMov ConTrnAdqNumMov , 
				a.MovTrnNumReg ConTrnAdqNumReg , 
				''           as ConTrnPosNroSerInt , 
				''               as ConTrnPosNroSer , 
				a.MovTrnAutCodStr as ConTrnNumAtzStr , 
				a.MovTrnIdeTer as ConTrnAdqIdeTer , 
				a.MovTrnNumCar as ConTrnNumCar , 
				ConTrnAdqCod = a.AdqCod          
				FROM MOVTRN01 a
				left join trn05 b on a.movtrnid =  b.trnbrsoprmovtrnid 
				Where b.trnbrsoprmovtrnid is null
				and a.adqcod = 5
				and a.movtrncod in ( 'CV' , 'PS' )
				and MovTrnIdOri = 0 
				and MovTrnIdCan = 0 
		
	UNION All

		SELECT 
			NEWID() ConTrnId, 
			'MOVTRN01'  ConTrnOri, 
			trnbrsoproridat ConTrnDta, 
			EstCod = 0,
			CASE 
				WHEN TrnBrsOprBan = '002' THEN 'M'
				WHEN TrnBrsOprBan = '003' THEN 'V'
				WHEN TrnBrsOprBan = '004' THEN 'E'
				WHEN TrnBrsOprBan = '010' THEN 'C'
				WHEN TrnBrsOprBan = '006' THEN 'D'
				ELSE ''
			END AS ConTrnBan,
			SUBSTRING(Trnbrsoprideser, 4, 1) ConTrnTipPrd,
			Trnbrsoprmovnsucrr ConTrnNsu,
			Trnbrsoprvlr ConTrnVlr , 
			ConTrnAdqNumMov = 0, 
			ConTrnAdqNumReg = 0, 
			trnbrsoprtrm as ConTrnPosNroSerInt , 
			trnbrsoprtrm  as ConTrnPosNroSer , 
			VanTrnNumAtzStr = '' , 
			''           as ConTrnAdqIdeTer , 
			concat (trnbrsoprbin,trnbrsoprpan )  as ConTrnNumCar , 
			adqcod as ConTrnAdqCod    
		FROM trn05    
			Where trnbrsoprmovtrnid  = 0
			and TrnBrsRdeSit in ('00','01','03','04')
			group by trnbrsoproridat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
			trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, adqcod, TrnBrsOprBan, Trnbrsoprvlr



	UNION All
		select   NewID() ConTrnId, 
			'Van04' ConTrnOri, 
			a.MovTrnDta ConTrnDta, 
			a.EstCod  ConTrnEstCod, 
			a.MovTrnBan as ConTrnBan,  
			a.MovTrnTipPrd ConTrnTipPrd, 
			a.MovTrnNsu   ConTrnNsu, 
			a.MovTrnVlr ConTrnVlr , 
			a.MovTrnNumMov ConTrnAdqNumMov , 
			a.MovTrnNumReg ConTrnAdqNumReg , 
			''           as ConTrnPosNroSerInt , 
			''               as ConTrnPosNroSer , 
			a.MovTrnAutCodStr as ConTrnNumAtzStr , 
			a.MovTrnIdeTer as ConTrnAdqIdeTer , 
			a.MovTrnNumCar as ConTrnNumCar , 
			ConTrnAdqCod = a.AdqCod        
		FROM MOVTRN01 a left join TrnPagSeg b 
		on a.movtrnid =  b.TrnPagSegMovTrnId 
			Where b.TrnPagSegMovTrnId is null
			and a.adqcod = 8
			and a.movtrncod in ( 'CV' , 'PS' )
			and MovTrnIdOri = 0 
			and MovTrnIdCan = 0 
		
	UNION All
		SELECT NEWID() ConTrnId, 
			'MOVTRN01'    ConTrnOri, 
			convert(datetime, trnpagsegdatainicial, 121) ConTrnDta, 
			EstCod = trnpagsegestabelecimento ,
			CASE
			WHEN TrnPagSegInstituicao = 'AMEX' THEN 'A'
			WHEN TrnPagSegInstituicao =	'CABAL' THEN 'C'
			WHEN TrnPagSegInstituicao =	'ELO' THEN 'E'
			WHEN TrnPagSegInstituicao =	'HIPERCARD' THEN 'H'
			WHEN TrnPagSegInstituicao =	'MAESTRO' THEN 'M'
			WHEN TrnPagSegInstituicao =	'MASTERCARD' THEN 'M'
			WHEN TrnPagSegInstituicao =	'VISA' THEN 'V'
			WHEN TrnPagSegInstituicao =	'VISA ELECTRON' THEN 'V'
			ELSE ''
			END AS ConTrnBan,
			iif(TrnPagSegMeioPagamento = 3, 'C', 'D') ConTrnTipPrd,
			trnpagsegcvcodigo ConTrnNsu,
			trnpagsegvalororiginal ConTrnVlr , 
			''  as ConTrnAdqNumMov , 
			''  as ConTrnAdqNumReg , 
			convert(varchar(40), trnpagsegestabelecimento) as ConTrnPosNroSerInt , 
			convert(varchar(40), trnpagsegestabelecimento)  as ConTrnPosNroSer , 
			convert(varchar(40), trnpagsegautorizacaocodigo) as VanTrnNumAtzStr, 
			''           as ConTrnAdqIdeTer , 
			concat (trnpagsegcartaobin,trnpagsegcartaoholder )  as ConTrnNumCar , 
			8 as ConTrnAdqCod   
		FROM TrnPagSeg    
			Where (TrnPagSegMovTrnId  = 0
			or TrnPagSegMovTrnId is null)
			and TrnPagSegSituacaoProcesso <> 'Processado'
			group by trnpagsegdatainicial, TrnPagSegInstituicao, TrnPagSegMeioPagamento, trnpagsegcvcodigo, trnpagsegvalororiginal,
			trnpagsegestabelecimento, trnpagsegautorizacaocodigo, trnpagsegcartaobin, trnpagsegcartaoholder
			) Resultado

	UNION ALL
		SELECT 
			NewID() 'ConTrnId',
			'Van04' 'ConTrnOri',
			Canc.VanWbsDat 'ConTrnDta', 
			0 'ConTrnEstCod', 
			Canc.Bandeira 'ConTrnBan',
			Canc.Produto 'ConTrnTipPrd',
			canc.VanWbsNsu 'ConTrnNsu',--alterado de cancelamento para venda
			Canc.ValorSitef 'ConTrnVlr',
			0 'ConTrnAdqNumMov',
			0 'ConTrnAdqNumReg',
			Canc.VanWbsPosIde 'ConTrnPosNroSerInt', 
			'' 'ConTrnPosNroSer', 
			Canc.VanWbsAtz 'ConTrnNumAtzStr', 
			'' 'ConTrnAdqIdeTer',
			'' 'ConTrnNumCar',
			C.AdqCod 'ConTrnAdqCod'
		FROM 
			(SELECT 
				(CONVERT(numeric(17,2), VanWbsVlr)/-100) 'ValorSitef',
				VanWbsVlr,
				VanWbsAtz, 
				VanWbsDat, 
				VanWbsPosIde, 
				VanWbsDsc, 
				VanWbsSta,
				VanWbsTrnSeq,
				VanWbsNsu,
				SUBSTRING(VanWbsBdaNom, 1, 1) 'Bandeira',
				VanWbsAdqIde,
				IIF(VanWbsDsc LIKE '%CREDITO%', 'C', 'D') 'Produto'
			FROM VAN02
			WHERE VanWbsDsc LIKE '%CANCELAMENTO%'
			AND VanWbsTrnSeq = 0
			) Canc 
		INNER JOIN
			(SELECT 
				(CONVERT(numeric(17,2), VanWbsVlr)/-100) 'ValorSitef',
				VanWbsVlr,
				VanWbsAtz, 
				VanWbsDat, 
				VanWbsPosIde, 
				VanWbsDsc, 
				VanWbsSta,
				VanWbsTrnSeq,
				VanWbsNsu,
				SUBSTRING(VanWbsBdaNom, 1, 1) 'Bandeira',
				VanWbsAdqIde,
				IIF(VanWbsDsc LIKE '%CREDITO%', 'C', 'D') 'Produto'
			FROM VAN02
			WHERE VanWbsDsc LIKE '%VENDA%'
			AND VanWbsTrnSeq > 0
			AND VanWbsSta LIKE '%ESTORNADA%'
			) Venda
		ON Canc.VanWbsDat = Venda.VanWbsDat 
		AND Canc.ValorSitef = Venda.ValorSitef 
		AND Canc.Bandeira = Venda.Bandeira
		AND Canc.Produto = Venda.Produto
		AND Canc.VanWbsPosIde = VENDA.VanWbsPosIde
		LEFT JOIN ADQ0001 C
		ON Canc.VanWbsAdqIde = C.AdqNom
		LEFT JOIN MovTrn01 Mov
		ON Canc.VanWbsDat = Mov.MovTrnDta AND Canc.ValorSitef = Mov.MovTrnVlr AND Venda.VanWbsAtz = MOV.MovTrnAutCodStr AND CONVERT(NUMERIC(18), Venda.VanWbsNsu) = Mov.MovTrnNsuMovOri
			WHERE Mov.MovTrnId IS NULL

	/* ADICIONADO PELA TAREFA #26175 - CARLOS */
	UNION ALL
		SELECT NEWID() ConTrnId, 
				'ADQUIRENTE'    ConTrnOri, 
				VanWbsDat 'ConTrnDta', 
				0 'ConTrnEstCod', 
				VanWbsBdaNom 'ConTrnBan',
				'' 'ConTrnTipPrd',
				VanWbsNsu 'ConTrnNsu',--alterado de cancelamento para venda
				(VanWbsVlr/100)  'ConTrnVlr',
				0 'ConTrnAdqNumMov',
				0 'ConTrnAdqNumReg',
				VanWbsPosIde 'ConTrnPosNroSerInt', 
				'' 'ConTrnPosNroSer', 
				VanWbsAtz 'ConTrnNumAtzStr', 
				'' 'ConTrnAdqIdeTer',
				'' 'ConTrnNumCar',
				5 'ConTrnAdqCod'
		FROM VAN02
				Where VanWbsSta = 'PENDENTE'
				AND VanWbsAdqIde  = 'vero'

	/* ADICIONADO PELA TAREFA #26175 - CARLOS */
	UNION ALL
		SELECT
			NewID() 'ConTrnId', 
			'Van04' 'ConTrnOri', 
			A.MovTrnDta 'ConTrnDta', 
			A.EstCod  'ConTrnEstCod', 
			A.MovTrnBan 'ConTrnBan',  
			A.MovTrnTipPrd 'ConTrnTipPrd', 
			A.MovTrnNsu   'ConTrnNsu', 
			A.MovTrnVlr 'ConTrnVlr' , 
			A.MovTrnNumMov 'ConTrnAdqNumMov' , 
			A.MovTrnNumReg 'ConTrnAdqNumReg' , 
			'' 'ConTrnPosNroSerInt' , 
			'' 'ConTrnPosNroSer' , 
			A.MovTrnAutCodStr 'ConTrnNumAtzStr' , 
			A.MovTrnIdeTer 'ConTrnAdqIdeTer' , 
			A.MovTrnNumCar 'ConTrnNumCar' , 
			A.AdqCod 'ConTrnAdqCod'
		FROM MOVTRN01 A left join TRN 
			on A.MovTrnDta = TRN.TrnDtaTrnCV and 
			A.MovTrnVlr = TRN.trnvlrbruvencv and
			A.MovTrnAutCodStr = TRN.trncodautcvstr
			Where A.AdqCod in (1, 3)
			and A.MovTrnCod in ( 'CV' , 'PS' )
			and A.MovTrnIdOri = 0 
			and A.MovTrnIdCan = 0 

	UNION All

		SELECT 
			NEWID() 'ConTrnId', 
			'MOVTRN01'  'ConTrnOri', 
			TrnDtaTrnCV  'ConTrnDta', 
			TrnEstCod 'ConTrnEstCod', 
			'' 'ConTrnBan',
			TrnTipPrdCV 'ConTrnTipPrd',
			TrnNsuCV 'ConTrnNsu',
			TrnVlrBruVenCV 'ConTrnVlr' , 
			0 'ConTrnAdqNumMov', 
			0 'ConTrnAdqNumReg', 
			'' 'ConTrnPosNroSerInt' , 
			'' 'ConTrnPosNroSer' , 
			''   'VanTrnNumAtzStr', 
			TrnIdeTer 'ConTrnAdqIdeTer' , 
			TrnNumCarCV 'ConTrnNumCar' , 
			A.AdqCod 'ConTrnAdqCod'    
		FROM TRN  left join MovTrn01 A  
			on TRN.TrnDtaTrnCV = a.MovTrnDta  and 
			TRN.TrnVlrBruVenCV = a.MovTrnVlr and
			TRN.TrnCodAutCvStr = a.MovTrnAutCodStr
			Where A.AdqCod in (1, 3)
			and A.MovTrnCod in ( 'CV' , 'PS' )
			and A.MovTrnIdOri = 0 
			and A.MovTrnIdCan = 0 

GO
