use prontoset
go

select * from tipdsp

select * from vlrpag where tidcod = 2
and vlpstspag = 1;

update vlrpag set VlpStspag = 6
where tidcod = 2
and vlpstspag = 1;