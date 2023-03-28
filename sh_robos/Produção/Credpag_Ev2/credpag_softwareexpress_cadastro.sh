QTPRC=`ps -fe | grep credpagsoftwareexpresscadastro | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock ]
   then
      rm -f /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock

echo "INICIANDO credpag_softwareexpress_cadastro.sh " >> /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.txt

cd /opt/apache-tomcat-7.0.109/webapps/credpag/WEB-INF/classes

/opt/jdk1.8.0_291/bin/java -Dprocess="credpagsoftwareexpresscadastro" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0550 >> /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.txt
/opt/jdk1.8.0_291/bin/java -Dprocess="credpagsoftwareexpresscadastro" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0560 >> /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.txt

echo "ENCERROU credpag_softwareexpress_cadastro.sh " >> /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.txt

if [ -f /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock ]
then
  rm -f /mnt/home1/sistema/logs/credpag_softwareexpress_cadastro.lock
fi
