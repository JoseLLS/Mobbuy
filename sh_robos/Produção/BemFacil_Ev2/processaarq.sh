cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes

DIR="/opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes/GP2_006_20200711_044936_0012_004586411_000340.TXT"
ARQ="GP2_006_20200711_044936_0012_004586411_000340.TXT"

# Gera o contas a receber com base na rede de captura
echo $DIR
echo "ptrn0100qg ..."
/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: aptrn0100qg $DIR $ARQ > aptrn0100qg_log.txt
echo "Terminou..."

DIR="/opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes/GP2_006_20200712_033915_0012_004586411_000341.TXT"
ARQ="GP2_006_20200712_033915_0012_004586411_000341.TXT"

# Gera o contas a receber com base na rede de captura
echo $DIR
echo "ptrn0100qg ..."
/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: aptrn0100qg $DIR $ARQ > aptrn0100qg_log.txt
echo "Terminou..."
