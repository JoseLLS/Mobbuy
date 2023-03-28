echo "INICIANDO aprovar_ant.sh" >> /mnt/home1/sistema/logs/aprovar_bemfacil_ant.txt

cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes

/opt/jdk1.8.0_291/bin/java -Dprocess="credinov_aprovarant" -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ppagant0100b "$1" "$2" >> /mnt/home1/sistema/logs/aprovar_bemfacil_ant.txt

echo "ENCERROU aprovar_ant.sh" >> /mnt/home1/sistema/logs/aprovar_bemfacil_ant.txt
