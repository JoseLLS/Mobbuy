#!/bin/sh

# --> cria o caminho onde a TDS ira receber os arquivos
caminho=/SubAdquirencia/006/tds/terminais
num=0

# --> Acessa o diretorio /var/tds para fazer downloads de arquivos da TDS(Cadastro de terminais)
cd $caminho

# --> verifica se o arquivo existe, caso nao exista cria ou recupera o mesmo
if [ ! -e $caminho/processados-tds.txt ] ; then 
   if [ ! -e $caminho/Backup-NaoApagar/processados-tds.txt ] ; then
      touch $caminho/processados-tds.txt
   else
      cp $caminho/Backup-NaoApagar/processados-tds.txt $caminho/
   fi
fi

# --> faz download do arquivo da TDS através do FTP
wget --user=inforcard --password=Inf0card0801  --no-clobber ftp://200.198.75.242/retorno/*.ret


# --> caso ocorra erro no ftp, ele tenta novamente fazer o ftp 8x
while [ $? -ne 0 ] 
do
  if [ $num -ne 9 ] ; then 
    wget --user=inforcard --password=Inf0card0801 --no-clobber ftp://200.198.75.242/retorno/*.ret
  else
    num=$(($num+1))
  fi
done 
#ftp -n 200.198.75.242 <<END_SCRIPT
#quote user inforcard
#quote PASS Inf0card0801
#mput *.ret
#quote y
#quote y
#quote y
#quote y
#quote y
#quit
#END_SCRIPT


# --> lista os arquivos que vieram da TDS e grava no arquivo lista_receb_tds.txt
ls infocards_*.ret > lista_receb_tds.txt 

# --> verifica os arquivos ja processados para não processar novamente os mesmos
cat lista_receb_tds.txt | grep -v -f processados-tds.txt > novos_aprocessar_tds.txt

# --> acessa o diretório para processar o programa Genexus
cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes/

# --> faz a leitura do aquivo lista_receb_tds.txt contendo os arquivos vindos da TDS para ser processado
while read linha;
do

  # --> executa o programa Genexus que carrega o arquivo processado pela TDS (arq por arq)
  /opt/jdk1.8.0_291/bin/java -classpath ../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0402 $caminho/$linha

echo $caminho/$linha
echo 'estou a processando'
done < $caminho/novos_aprocessar_tds.txt

# --> após processado joga para o diretorio recebidos
if [ ! -d $caminho/retorno ] ; then 
  mkdir $caminho/retorno
fi
if [ $num -ne 9 ] ; then
  mv $caminho/infocards_*.ret $caminho/retorno
  cat $caminho/novos_aprocessar_tds.txt >> $caminho/processados-tds.txt
  cp $caminho/processados-tds.txt $caminho/Backup-NaoApagar/
fi

