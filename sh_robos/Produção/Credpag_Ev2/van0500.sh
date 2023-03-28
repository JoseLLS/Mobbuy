start=$(date -d"$start - 1 months " +"%Y%m%d")
end=$(date +"%Y%m%d")
echo $start
echo $end
while [[ $start -le $end ]]
do
        echo $start
	echo "===[ INICIO ]==="

        /opt/jdk1.8.0_291/bin/java  -classpath ../lib/commons-lang-2.4.jar:../lib/gxclassR.jar:../lib/Una2000.jar:../lib/iText.jar:../lib:.:../lib/gxclassR.jar:../lib/jtds-1.2.jar:../lib/ojdbc14.jar:.: van0500 $start

        start=$(date -d"$start + 1 day " +"%Y%m%d")
done
echo "===[ FIM ]==="
