#!/bin/bash
#ToDo: Parametrizar as aplicações.
#ToDo: Testar usar a mesma var de 'resposta'.
#ToDo: usar unzip -o (overwrite).

caminhoFix=/home/lsantos/fix/fix7/autofix.zip

clear
echo "Maravilha, é hora de atualizar o FIX!"
echo ""
echo "Você tem CERTEZA que o arquivo $caminhoFix possui a pasta WEB-INF e/ou static logo no primeiro nível?"
echo "Abra o zip se estiver na dúvida! Isso é importante pra não descompactar a aplicação no local errado."
echo ""
echo "Podemos continuar? [s/n]:"
read resposta

if echo "$resposta" | grep -iq "^s" ;then
	if (unzip -l $caminhoFix | grep -q " WEB-INF") || (unzip -l $caminhoFix | grep -q " static"); then

		echo ""
		echo "Qual cliente deseja atualizar?"
		echo "00 = TODOS"
		echo "01 = credinov"
		echo "02 = thepay"
		echo "03 = credpag"
		echo "04 = pronto"
		echo "05 = smartpagamentos"
		echo "06 = banese"

	
		read respostaT
		
		if (echo "$respostaT" | grep -iq "^01$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup credinov"	
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/credinov-v17up8												
			cp -fR /opt/apache-tomcat-9.0.46/webapps/credinov-v17up8/ /opt/apache-tomcat-9.0.46/Backup/			
			echo "Atualizando credinov"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/credinov-v17up8/	
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/credinov-v17up8	
		fi
		
		if (echo "$respostaT" | grep -iq "^01$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup estbank"	
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/estbank-v17up8												
			cp -fR /opt/apache-tomcat-9.0.46/webapps/estbank-v17up8/ /opt/apache-tomcat-9.0.46/Backup/			
			echo "Atualizando estbank"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/estbank-v17up8/	
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/estbank-v17up8	
		fi

		if (echo "$respostaT" | grep -iq "^02$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup thepay"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/thepay-v17up8
			cp -fR /opt/apache-tomcat-9.0.46/webapps/thepay-v17up8/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando thepay"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/thepay-v17up8/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/thepay-v17up8
		fi
		
		if (echo "$respostaT" | grep -iq "^03$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup credpag"		
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/credpag-v17up8	
			cp -fR /opt/apache-tomcat-9.0.46/webapps/credpag-v17up8/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando credpag"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/credpag-v17up8/
      sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/credpag-v17up8
		fi
		
		if (echo "$respostaT" | grep -iq "^04$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup pronto"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/pronto-v17up8			
			cp -fR /opt/apache-tomcat-9.0.46/webapps/pronto-v17up8/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando pronto"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/pronto-v17up8/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/pronto-v17up8
		fi
				
		if (echo "$respostaT" | grep -iq "^05$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup smartpagamentos"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/smartpagamentos-v17up8
			cp -fR /opt/apache-tomcat-9.0.46/webapps/smartpagamentos-v17up8/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando smartpagamentos"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/smartpagamentos-v17up8/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/smartpagamentos-v17up8
		fi	
		
		if (echo "$respostaT" | grep -iq "^06$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup Banese"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/banese-v17up8
			cp -fR /opt/apache-tomcat-9.0.46/webapps/banese-v17up8/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando Banese"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/banese-v17up8/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/banese-v17up8
		fi		
		
		echo ""
		echo ""
		echo "Certo, nÃ£o hÃ¡ mais o que fazer por enquanto."
		echo "AtÃ© mais!"
		exit
		
	else
		echo ""
		echo "Opa, nÃ£o encontrei a pasta WEB-INF ou static na raiz do arquivo $caminhoFix."
		echo "NÃ£o fizemos nada por enquanto. AtÃ© mais!"
		exit
	fi
else
	echo "Certo, nÃ£o fizemos nada por enquanto."
	echo "AtÃ© mais!"
	exit
fi
