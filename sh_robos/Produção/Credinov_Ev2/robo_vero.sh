QTPRC=`ps -fe | grep credinovrobovero | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/credinov_robovero.lock ]
   then
      rm -f /mnt/home1/sistema/logs/credinov_robovero.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/credinov_robovero.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/credinov_robovero.lock

cd /opt/apache-tomcat-7.0.109/webapps/credinov/WEB-INF/classes

/opt/jdk1.8.0_291/bin/java -Dprocess="credinovrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0800
/opt/jdk1.8.0_291/bin/java -Dprocess="credinovrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0810

#Faz a geracao de arquivo para banco.
/opt/jdk1.8.0_291/bin/java -Dprocess="credinovrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.:/opt/java/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: parb0099
/opt/jdk1.8.0_291/bin/java -Dprocess="credinovrobovero" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.:/opt/java/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: parb0098

FILES="`ls /mnt/home1/SubAdquirencia/025/reembolso/env`"

if [ "$FILES" != "" ]
then
   sudo chmod 777 /mnt/home1/SubAdquirencia/025/reembolso/env/*.txt
   sudo chown tomcat:tomcat /mnt/home1/SubAdquirencia/025/reembolso/env/*.txt
fi

if [ -f /mnt/home1/sistema/logs/credinov_robovero.lock ]
then
  rm -f /mnt/home1/sistema/logs/credinov_robovero.lock
fi
