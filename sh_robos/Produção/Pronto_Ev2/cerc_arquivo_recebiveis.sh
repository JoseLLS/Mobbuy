TASK="pronto_cercarqrecebiveis"
PATHCLASSES="/opt/apache-tomcat-7.0.109/webapps/pronto/WEB-INF/classes"
PATHJAVA="/opt/jdk1.8.0_291/bin/java"
TEXTCLASSPATH="-Dprocess="prontocercrecebiveis" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.:"
PROCESS2="recebivelarquivo"

QTPRC=`ps -fe | grep prontocercrecebiveis | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/$TASK.lock ]
   then
      rm -f /mnt/home1/sistema/logs/$TASK.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/$TASK.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/$TASK.lock

cd $PATHCLASSES
$PATHJAVA $TEXTCLASSPATH $PROCESS2 "$1" >> /mnt/home1/sistema/logs/$TASK.txt

if [ -f /mnt/home1/sistema/logs/$TASK.lock ]
then
  rm -f /mnt/home1/sistema/logs/$TASK.lock
fi
