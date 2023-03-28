QTPRC=`ps -fe | grep bemfacilemail | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/bemfacil_email.lock ]
   then
      rm -f /mnt/home1/sistema/logs/bemfacil_email.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/bemfacil_email.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/bemfacil_email.lock

echo "INICIANDO bemfacil_email.sh " >> /mnt/home1/sistema/logs/bemfacil_email.txt

cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes
/opt/jdk1.8.0_291/bin/java -Dprocess="bemfacilemail" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: mpl0100 >> /mnt/home1/sistema/logs/bemfacil_email.txt

echo "ENCERROU bemfacil_email.sh " >> /mnt/home1/sistema/logs/bemfacil_email.txt

if [ -f /mnt/home1/sistema/logs/bemfacil_email.lock ]
then
  rm -f /mnt/home1/sistema/logs/bemfacil_email.lock
fi
