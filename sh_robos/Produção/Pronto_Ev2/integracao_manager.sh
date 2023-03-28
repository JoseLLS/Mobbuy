QTPRC=`ps -fe | grep integra_prontomanager | wc -l`

if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/integracao_manager.lock ]
   then
      rm -f /mnt/home1/sistema/logs/integracao_manager.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/integracao_manager.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/integracao_manager.lock

cd /opt/apache-tomcat-7.0.109/webapps/pronto/WEB-INF/classes

echo "INICIANDO integracao_manager.sh " >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

date >> /mnt/home1/sistema/logs/integra_prontomanager.txt

/opt/jdk1.8.0_291/bin/java -Dprocess="integra_prontomanager" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: managergetvolumtrans "$1" "$2"  >> /mnt/home1/sistema/logs/integracao_prontomanager.txt
/opt/jdk1.8.0_291/bin/java -Dprocess="integra_prontomanager" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: importaps >> /mnt/home1/sistema/logs/integracao_prontomanager.txt
/opt/jdk1.8.0_291/bin/java -Dprocess="integra_prontomanager" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: statusprestacao  >> /mnt/home1/sistema/logs/integracao_prontomanager.txt
/opt/jdk1.8.0_291/bin/java -Dprocess="integra_prontomanager" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: cancelamentoprestacao  >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

date >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

echo "ACABOU integracao_manager.sh " >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

date >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

echo "==============================================" >> /mnt/home1/sistema/logs/integracao_prontomanager.txt

if [ -f /mnt/home1/sistema/logs/integracao_manager.lock ]
then
  rm -f /mnt/home1/sistema/logs/integracao_manager.lock
fi
