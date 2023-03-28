QTPRC=`ps -fe | grep credinovemail | wc -l`
if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /opt/sistema/log/credinov_email.lock ]
   then
      rm -f /opt/sistema/log/credinov_email.lock
   fi
fi

if [ -f /opt/sistema/log/credinov_email.lock ]
then
   exit
fi

date >> /opt/sistema/log/credinov_email.lock

echo "INICIANDO credinov_email.sh " >> /opt/sistema/log/credinov_email.txt

cd /opt/apache-tomcat-7.0.109/webapps/credinov/WEB-INF/classes
/opt/jdk1.8.0_291/bin/java -Dprocess="credinovemail" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: mpl0100 >> /opt/sistema/log/credinov_email.txt

echo "ENCERROU credinov_email.sh " >> /opt/sistema/log/credinov_email.txt

if [ -f /opt/sistema/log/credinov_email.lock ]
then
  rm -f /opt/sistema/log/credinov_email.lock
fi
