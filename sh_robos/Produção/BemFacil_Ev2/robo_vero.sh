QTPRC=`ps -fe | grep bemfacilrobovero | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/bemfacil_robovero.lock ]
   then
      rm -f /mnt/home1/sistema/logs/bemfacil_robovero.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/bemfacil_robovero.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/bemfacil_robovero.lock

cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes

#Global Payments
/opt/jdk1.8.0_291/bin/java -Dprocess="bemfacilrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0090 >> /mnt/home1/sistema/logs/bemfacil_robovero.txt
#Vero
/opt/jdk1.8.0_291/bin/java -Dprocess="bemfacilrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0800 >> /mnt/home1/sistema/logs/bemfacil_robovero.txt
/opt/jdk1.8.0_291/bin/java -Dprocess="bemfacilrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0810 >> /mnt/home1/sistema/logs/bemfacil_robovero.txt

#Faz a geracao de arquivo para banco.
### 23/07/2020 - Bruno ### /opt/java/jdk1.8.0_291/bin/java -Dprocess="bemfacilrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.:/usr/java/jdk1.7.0_71/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: parb0099

if [ -f /mnt/home1/sistema/logs/bemfacil_robovero.lock ]
then
  rm -f /mnt/home1/sistema/logs/bemfacil_robovero.lock
fi
