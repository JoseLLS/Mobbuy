

update sse2_mod  set 
MOD2Dsc  = 'Cadastro CNAE'
where MOD2Id = 'hcnae0106_grid'

update sse2_mnu02 set 
MnuIteOrd = 60,
MnuIteIdRoot = 'ADQ',
MnuIteDsc = 'Cadastro CNAE',
MnuItePth = ''
where MnuIteIde = 'hcnae0106_grid'

update sse2_mod  set 
MOD2Dsc  = 'Importar CNAE'
where MOD2Id = 'hcnae0107'

update sse2_mnu02 set 
MnuIteOrd = 45,
MnuIteIdRoot = 'ADQ',
MnuIteDsc = 'Importar CNAE',
MnuItePth = ''
where MnuIteIde = 'hcnae0107'

