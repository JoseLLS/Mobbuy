TASK="smart_enviaemailmonitor"
PATHCLASSES="/opt/docker/volumes/monitorSmart_9/webapps/MonitoramentoSmart/WEB-INF/classes/com/monitor"
PATHJAVA="/opt/jdk1.8.0_291/bin/java"
TEXTCLASSPATH="-Dprocess="smartenviaemailmonitor" -classpath ../lib/activation-1.1.jar:../lib/bcprov-jdk15on-1.64.jar:../lib/commons-codec-1.9.jar:../lib/commons-collections4-4.1.jar:../lib/commons-compress-1.19.jar:../lib/commons-fileupload-1.3.3.jar:../lib/commons-io-2.2.jar:../lib/commons-lang-2.4.jar:../lib/commons-math3-3.6.1.jar:../lib/compiler-0.9.7.jar:../lib/curvesapi-1.06.jar:../lib/encoder-1.2.2.jar:../lib/encoder-jsp-1.2.2.jar:../lib/GeneXus.jar:../lib/guava-30.1-jre.jar:../lib/gxclassR.jar:../lib/gxcommon.jar:../lib/gxcryptocommon.jar:../lib/gxmail.jar:../lib/gxmaps.jar:../lib/gxoffice.jar:../lib/itext-2.1.7.jar:../lib/jackson-annotations-2.11.0.jar:../lib/jackson-core-2.11.0.jar:../lib/jackson-databind-2.11.0.jar:../lib/javax.annotation-api-1.3.2.jar:../lib/javax.jms-3.1.2.2.jar:../lib/javax.jws-3.1.2.2.jar:../lib/javax.mail-1.6.2.jar:../lib/jaxb-api-2.3.0.jar:../lib/jaxws-api-2.2.1.jar:../lib/joda-time-2.10.4.jar:../lib/json-20180813.jar:../lib/jtds-1.2.jar:../lib/log4j-api-2.13.3.jar:../lib/log4j-core-2.13.3.jar:../lib/poi-4.1.2.jar:../lib/poi-ooxml-4.1.2.jar:../lib/poi-ooxml-schemas-4.1.2.jar:../lib/poi-scratchpad-4.1.2.jar:../lib/SparseBitSet-1.2.jar:../lib/xercesImpl-2.12.0.jar:../lib/xml-apis-1.4.01.jar:../lib/xmlbeans-3.1.0.jar:.:"
PROCESS1="com.monitor.aemail_envio"

QTPRC=`ps -fe | grep smartenviaemailmonitor | wc -l`
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
$PATHJAVA $TEXTCLASSPATH $PROCESS1 >> /mnt/home1/sistema/logs/$TASK.txt

if [ -f /mnt/home1/sistema/logs/$TASK.lock ]
then
  rm -f /mnt/home1/sistema/logs/$TASK.lock
fi
