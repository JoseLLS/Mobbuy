USE credpag
GO
/****** Object:  Table [dbo].[Trn_Situacao]    Script Date: 10/02/2023 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Situacao](
	[Trn_SituacaoCod] [varchar](2) NOT NULL,
	[Trn_SituacaoDesc] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Trn_SituacaoCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'00', N'OK por confirmação ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'01', N'OK pela resolução de pendências on-line ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'02', N'OK por conciliação ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'03', N'OK pela resolução de pendências na operação seguinte ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'04', N'OK pela resolução de pendências manual ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'05', N'Estorno OK ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'10', N'Pendente ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'13', N'Pré-autorização ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'20', N'Não autorizada ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'21', N'Não autorizada pela rede destino ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'40', N'Cancelada pela origem ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'41', N'Cancelada por resolução de pendências on-line ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'42', N'Cancelada por conciliação ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'43', N'Cancelada por resolução de pendências na operação seguinte ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'44', N'Cancelada por resolução de pendências manual ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'50', N'Estornada')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'51', N'Estornada por resolução de pendências on-line ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'52', N'Estornada por conciliação ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'53', N'Estornada por solicitação posterior ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'54', N'Estornada por resolução manual ')
GO
INSERT [dbo].[Trn_Situacao] ([Trn_SituacaoCod], [Trn_SituacaoDesc]) VALUES (N'57', N'Estornada por Reversão PIX ')
GO
