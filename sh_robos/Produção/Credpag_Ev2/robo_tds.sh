DIRETORIO_TDS=/SubAdquirencia/012/tds/vendas/
DIRETORIO_TMP=$DIRETORIO_TDS+"tmp"
DIRETORIO_REMOTE=$DIRETORIO_TDS"remote/"
DIRETORIO_PROCESSADOS=$DIRETORIO_TDS"processados/"
DIRETORIO_GX=/opt/apache-tomcat-7.0.109/webapps/credpag/WEB-INF/classes/


cd $DIRETORIO_REMOTE ; wget --user=inforcard --password=Inf0card0801  --no-clobber ftp://200.198.75.242/FTPINFO*
rm -rf arquivos.txt    ; ls -l $DIRETORIO_REMOTE             | grep FTPINFO | awk '{print $9}' > arquivos.txt
rm -rf processados.txt ; ls -l $DIRETORIO_PROCESSADOS        | grep FTPINFO | awk '{print $9}' > processados.txt
rm -rf novos.txt ; cat arquivos.txt | grep -v -f processados.txt > novos.txt


cd $DIRETORIO_GX
/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0300
/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0220

