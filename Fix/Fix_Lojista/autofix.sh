#!/bin/bash
#ToDo: Parametrizar as aplicações.
#ToDo: Testar usar a mesma var de 'resposta'.
#ToDo: usar unzip -o (overwrite).

caminhoFix=/home/wcandida/fix/fix9/autofix.zip

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
		echo "07 = pagmoda"
	
		read respostaT
		
		if (echo "$respostaT" | grep -iq "^01$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup credinov"	
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/credinovev15												
			cp -fR /opt/apache-tomcat-9.0.46/webapps/credinovev15/ /opt/apache-tomcat-9.0.46/Backup/			
			echo "Atualizando credinov"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/credinovev15/	
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/credinovev15		
		fi

		if (echo "$respostaT" | grep -iq "^02$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup thepay"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/thepayev15
			cp -fR /opt/apache-tomcat-9.0.46/webapps/thepayev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando thepay"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/thepayev15/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/thepayev15
		fi
		
		if (echo "$respostaT" | grep -iq "^03$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup credpag"		
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/credpagev15	
			cp -fR /opt/apache-tomcat-9.0.46/webapps/credpagev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando credpag"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/credpagev15/
      sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/credpagev15
		fi
		
		if (echo "$respostaT" | grep -iq "^04$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup pronto"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/prontoev15			
			cp -fR /opt/apache-tomcat-9.0.46/webapps/prontoev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando pronto"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/prontoev15/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/prontoev15
		fi
				
		if (echo "$respostaT" | grep -iq "^05$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup smartpagamentos"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/smartpagamentosev15
			cp -fR /opt/apache-tomcat-9.0.46/webapps/smartpagamentosev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando smartpagamentos"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/smartpagamentosev15/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/smartpagamentosev15
		fi			
   
		if (echo "$respostaT" | grep -iq "^06$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup banese"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/baneseev15
			cp -fR /opt/apache-tomcat-9.0.46/webapps/baneseev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando banese"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/baneseev15/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/baneseev15
		fi

		if (echo "$respostaT" | grep -iq "^07$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup pagmoda"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/pagmodaev15
			cp -fR /opt/apache-tomcat-9.0.46/webapps/pagmodaev15/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando pagmoda"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/pagmodaev15/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/pagmodaev15
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
