QTPRC=`ps -fe | grep credpagsoftwareexpress | wc -l`
if [ "${QTPRC1:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress.lock ]
   then
      rm -f /mnt/home1/sistema/logs/credpag_softwareexpress.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/credpag_softwareexpress.lock

cd /opt/apache-tomcat-7.0.109/webapps/credpag/WEB-INF/classes

echo "INICIANDO credpag_redecaptura.sh " >> /mnt/home1/sistema/logs/credpag_redecaptura.txt


date >> /mnt/home1/sistema/logs/credpag_redecaptura.txt


/opt/jdk1.8.0_291/bin/java -Dprocess="credpagsoftwareexpress" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0500 "$1" >> /mnt/home1/sistema/logs/credpag_redecaptura.txt 

/opt/jdk1.8.0_291/bin/java -Dprocess="credpagsoftwareexpress" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0220

/opt/jdk1.8.0_291/bin/java -Dprocess="credpagsoftwareexpress" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0208

if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress.lock ]
then
  rm -f /mnt/home1/sistema/logs/credpag_softwareexpress.lock
fi
