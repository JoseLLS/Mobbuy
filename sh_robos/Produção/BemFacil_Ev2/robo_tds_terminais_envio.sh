#!/bin/sh

# --> caminho onde sera criado e enviado os arquivos para TDS
caminho=/SubAdquirencia/006/tds/terminais
num=0

# --> acessa o diretório para processar o programa Genexus
cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes/

# --> executa o programa Genexus que gera o arquivo para TDS
/opt/jdk1.8.0_291/bin/java -classpath ../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0400

# --> Acessa o diretorio /var/tds para fazer upload dos arquivos da TDS(Cadastro de terminais)
cd $caminho 

# --> Verifica se possui arquivo para envio, se possuir ele faz o FTP
#ls infocards_*.env
#if [ $? -ne 0 ] ; then
#  num=9
#else
  # --> faz upload do arquivo nosso para TDS através do FTP (todos os arquivos que começam com infocards_)
#  wput infocards_*.env ftp://inforcard:Inf0card0801@200.198.75.242xxxxxxx

  # --> caso ocorra erro no ftp, ele tenta 8x
#  while [ $? -ne 0 ]
#  do
#    num=$(($num+1))
#    if [ $num -ne 9 ] ; then
#      wput infocards_*.env ftp://inforcard:Inf0card0801@200.198.75.242
#    else
#      echo   
#    fi
#  done
#fi

# --> após enviar o arquivo para TDS, move os mesmos para a pasta de enviados, caso FTP funciona
#if [ ! -d $caminho/enviados ] ; then
#  mkdir $caminho/enviados
#fi
#if [ $num -ne 9 ] ; then 
#  mv $caminho/infocards_*.env $caminho/enviados
#fi

