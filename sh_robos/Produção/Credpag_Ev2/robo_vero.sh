JAVAEXEC="/opt/jdk1.8.0_291/bin/java"

QTPRC=`ps -fe | grep credpagrobovero | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/credpag_robovero.lock ]
   then
      rm -f /mnt/home1/sistema/logs/credpag_robovero.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/credpag_robovero.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/credpag_robovero.lock

cd /opt/apache-tomcat-7.0.109/webapps/credpag/WEB-INF/classes

#Global Payments
$JAVAEXEC -Dprocess="credpagrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0090 >> /mnt/home1/sistema/logs/credpag_robovero.txt
#Vero
$JAVAEXEC -Dprocess="credpagrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0800 >> /mnt/home1/sistema/logs/credpag_robovero.txt
#$JAVAEXEC -Dprocess="credpagrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0810 >> /mnt/home1/sistema/logs/credpag_robovero.txt

if [ -f /mnt/home1/sistema/logs/credpag_robovero.lock ]
then
  rm -f /mnt/home1/sistema/logs/credpag_robovero.lock
fi

