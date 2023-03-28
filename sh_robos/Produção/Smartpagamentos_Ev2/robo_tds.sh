SERVER=200.198.75.242
#SERVER=200.174.54.18
#SERVER=177.69.107.225

DIRETORIO_TDS=/SubAdquirencia/006/tds/vendas/
DIRETORIO_TMP=$DIRETORIO_TDS+"tmp"
DIRETORIO_REMOTE=$DIRETORIO_TDS"remote/"
DIRETORIO_PROCESSADOS=$DIRETORIO_TDS"processados/"
DIRETORIO_GX=/opt/apache-tomcat-7.0.109/webapps/smartpagamentos/WEB-INF/classes/


deletar_arquivo_no_ftp(){ 
        ftp -n $SERVER <<END_SCRIPT
        quote user inforcard
        quote PASS Inf0card0801
        mdelete $ARQ_DELECAO
        bye
END_SCRIPT
}
deletar_arquivo_local(){ 
        #cp $DIRETORIO/local/historico/$ARQ_DELECAO $DIRETORIO/local/historico/fin/$ARQ_DELECAO  
	echo $ARQ_DELECAO
        if [ -e $DIRETORIO_PROCESSADOS/$ARQ_DELECAO ] ; then
                rm -f $DIRETORIO_REMOTE/$ARQ_DELECAO
                deletar_arquivo_no_ftp
        fi
}


cd $DIRETORIO_REMOTE ; wget --user=inforcard --password=Inf0card0801  --no-clobber ftp://200.198.75.242/FTPBFAC*
rm -rf arquivos.txt    ; ls -l $DIRETORIO_REMOTE             | grep FTPBFAC | awk '{print $9}' > arquivos.txt
rm -rf processados.txt ; ls -l $DIRETORIO_PROCESSADOS        | grep FTPBFAC | awk '{print $9}' > processados.txt
rm -rf novos.txt ; cat arquivos.txt | grep -v -f processados.txt > novos.txt


cd $DIRETORIO_GX
/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0300
#/opt/java/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0220
#/opt/java/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0140



#DELECAO DOS ARQUIVOS JA PROCESSADOS (tanto na infocards quanto no ftp da tds)
for ARQ_DELECAO in $(ls -lav $DIRETORIO_REMOTE | grep --invert-match ^d |awk '{print $9}');do echo $ARQ_DELECAO;deletar_arquivo_local;done;

