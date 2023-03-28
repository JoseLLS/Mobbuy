import os
import zipfile
import configparser
from datetime import datetime

# Carrega o arquivo de configuração
config = configparser.ConfigParser()
config.read(os.path.abspath(os.path.dirname(__file__)) + '\\LiberaFix.ini')

# Retorna as propriedades utilizadas
diretorioApp	= config.get("Geral", "diretorioApp")
arquivoFix		= config.get("Geral", "arquivoFix")

NaoIncluir = []

# Configura as exceções
NaoIncluir.append(os.path.join(diretorioApp, "logs"))
NaoIncluir.append(os.path.join(diretorioApp, "PublicTempStorage"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "CloudServices.config"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "log4j2.xml"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "client.cfg"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "GXcfg.class"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "GXApplication.class"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "Images.txt"))
NaoIncluir.append(os.path.join(diretorioApp, "WEB-INF", "classes", "qviewer", "services", "client.cfg"))
NaoIncluir.append(os.path.join(diretorioApp, "gxmetadata", "LastTimeCopy"))
NaoIncluir.append(os.path.join(diretorioApp, "static", "Resources", "LastTimeCopy"))
NaoIncluir.append(os.path.join(diretorioApp, "static", "DeveloperMenu.xml"))
NaoIncluir.append(os.path.join(diretorioApp, "static", "gxcfg.js"))

def executa():

	print('=================================================================================')
	print('                               LIBERAÇÃO DE FIX                                  ')
	print('=================================================================================')
	print('')
	
	dtAgora = datetime.now()
	minutosCorte = int(input("Copiar os arquivos com menos de [X] minutos de criação/modificação. [X]: "))
	print('\nVerificando em.: {}\n'.format(diretorioApp))
	
	# Excluir o fix anterior (se houver).
	try:
		os.remove(arquivoFix)
	except FileNotFoundError:
		pass
	
	# Inicializa o novo zip do fix.
	fix = zipfile.ZipFile(arquivoFix, 'a')
	files = []
	
	# Pra cada arquivo dentro da aplicação...
	for r, d, f in os.walk(diretorioApp):
		for file in f:
                    	
			caminhoAbsoluto = os.path.join(r, file)
			caminhoRelativo = os.path.relpath(caminhoAbsoluto, diretorioApp)
                     
			# Verifica se o tempo de criação do arquivo está dentro do parâmetro de corte.
			if minutosCriacaoArquivo(caminhoAbsoluto, dtAgora) <= minutosCorte:
				
				incluirArquivo = True
				for excecao in NaoIncluir:
					if excecao in caminhoAbsoluto:
						incluirArquivo = False
						break
				
				# Incluir o arquivo no zip se ele não está na lista de exceção.
				if incluirArquivo:
					print('Adicionando....: {}'.format(caminhoRelativo))
					fix.write(caminhoAbsoluto, caminhoRelativo)
			
	fix.close()
	
	print('\nFix gerado em..: {}'.format(arquivoFix))

def minutosCriacaoArquivo(caminhoArquivo, dtAgora):
	try:
		timeStampArquivo = os.path.getmtime(caminhoArquivo)
	except FileNotFoundError:
		return 0
	
	dtArquivo   = datetime.fromtimestamp(timeStampArquivo)
	diffData	= dtAgora - dtArquivo
	minutos		= diffData.total_seconds()/60
	return minutos


executa()

input('\nPressione ENTER para sair.')
