QTPRC=`ps -fe | grep credinovredecaptura | wc -l`

if [ "${QTPRC:-0}" -gt "1" ]
then
   exit
else
   if [ -f /mnt/home1/sistema/logs/credinov_redecaptura.lock ]
   then
      rm -f /mnt/home1/sistema/logs/credinov_redecaptura.lock
   fi
fi

if [ -f /mnt/home1/sistema/logs/credinov_redecaptura.lock ]
then
   exit
fi

date >> /mnt/home1/sistema/logs/credinov_redecaptura.lock

cd /opt/apache-tomcat-7.0.109/webapps/credinov/WEB-INF/classes

echo "INICIANDO credinov_redecaptura.sh " >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

date >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

/opt/jdk1.8.0_291/bin/java -Dprocess="credinovredecaptura" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0500 "$1" >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

date >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

/opt/jdk1.8.0_291/bin/java -Dprocess="credinovredecaptura" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0220 >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

date >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

echo "ACABOU credinov_redecaptura.sh " >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

date >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

echo "==============================================" >> /mnt/home1/sistema/logs/credinov_redecaptura.txt

if [ -f /mnt/home1/sistema/logs/credinov_redecaptura.lock ]
then
  rm -f /mnt/home1/sistema/logs/credinov_redecaptura.lock
fi
