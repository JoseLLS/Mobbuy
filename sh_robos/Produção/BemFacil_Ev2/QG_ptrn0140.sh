cd /opt/apache-tomcat-7.0.109/webapps/bemfacil/WEB-INF/classes 

start='2020-02-01'
end='2020-02-22'

start=$(date -d $start +%Y%m%d)
end=$(date -d $end +%Y%m%d)

while [[ $start -le $end ]]
do
        echo $start
		echo "===[ INICIO ]==="
		
        /opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: ptrn0140 $start
		
		
        start=$(date -d"$start + 1 day" +"%Y%m%d")
		echo "===[ FIM ]==="


done

/opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0220  
