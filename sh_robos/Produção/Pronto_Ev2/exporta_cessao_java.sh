QTPRC=`ps -fe | grep pronto_cessaojava | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/pronto_exportacaojava.lock ]
   then
      rm -f /mnt/home1/sistema/logs/pronto_exportacaojava.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/pronto_exportacaojava.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/pronto_exportacaojava.lock

echo "INICIANDO pronto_exportacaojava.sh " >> /mnt/home1/sistema/logs/pronto_exportacaojava.txt

cd /opt/apache-tomcat-7.0.109/webapps/pronto/WEB-INF/classes

/opt/jdk1.8.0_291/bin/java  -Dprocess="pronto_cessaojava" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: apr_cessao_recebiveis >> /mnt/home1/sistema/logs/pronto_exportacaojava.txt

echo "ENCERROU pronto_exportacaojava.sh " >> /mnt/home1/sistema/logs/pronto_exportacaojava.txt

if [ -f /mnt/home1/sistema/logs/pronto_exportacaojava.lock ]
then
  rm -f /mnt/home1/sistema/logs/pronto_exportacaojava.lock
fi

