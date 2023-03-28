QTPRC=`ps -fe | grep smartpagamentosredecaptura | wc -l`

if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock ]
   then
      rm -f /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock

cd /opt/apache-tomcat-7.0.109/webapps/smartpagamentos/WEB-INF/classes

echo "INICIANDO smartpagamentos_redecaptura.sh " >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt

date >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt


/opt/jdk1.8.0_291/bin/java -Dprocess="smartpagamentosredecaptura" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0600 "$1" >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura2.txt

date >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt

echo "ACABOU smartpagamentos_redecaptura.sh " >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt

date >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt

echo "==============================================" >> /mnt/home1/sistema/logs/smartpagamentos_redecaptura.txt

if [ -f /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock ]
then
  rm -f /mnt/home1/sistema/logs/smartpagamentos_redecaptura.lock
fi
