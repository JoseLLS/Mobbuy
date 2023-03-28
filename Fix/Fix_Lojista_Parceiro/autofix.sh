#!/bin/bash
#ToDo: Parametrizar as aplicações.
#ToDo: Testar usar a mesma var de 'resposta'.
#ToDo: usar unzip -o (overwrite).

caminhoFix=/home/joseluiz/fix/FixParceiro/autofix.zip

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
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_credinov												
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_credinov/ /opt/apache-tomcat-9.0.46/Backup/			
			echo "Atualizando credinov"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_credinov/	
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_credinov		
		fi

		if (echo "$respostaT" | grep -iq "^02$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup thepay"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_thepay
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_thepay/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando thepay"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_thepay/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_thepay
		fi
		
		if (echo "$respostaT" | grep -iq "^03$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup credpag"		
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_credpag	
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_credpag/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando credpag"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_credpag/
      sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_credpag
		fi
		
		if (echo "$respostaT" | grep -iq "^04$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup pronto"
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_pronto			
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_pronto/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando pronto"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_pronto/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_pronto
		fi
				
		if (echo "$respostaT" | grep -iq "^05$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup smartpagamentos"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_smartpagamentos
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_smartpagamentos/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando smartpagamentos"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_smartpagamentos/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_smartpagamentos
		fi			
   
    if (echo "$respostaT" | grep -iq "^06$") || (echo "$respostaT" | grep -iq "^00$") ;then
			echo ""
			echo "Realizando Backup banese"			
      rm -rf  /opt/apache-tomcat-9.0.46/Backup/parceiro_banese
			cp -fR /opt/apache-tomcat-9.0.46/webapps/parceiro_banese/ /opt/apache-tomcat-9.0.46/Backup/
			echo "Atualizando banese"
			unzip -o $caminhoFix -d /opt/apache-tomcat-9.0.46/webapps/parceiro_banese/			
			sudo curl -u admin:MobPwd@12345 http://localhost:8089/manager/text/reload?path=/parceiro_banese
		fi			
		
		echo ""
		echo ""
		echo "Certo, não há mais o que fazer por enquanto."
		echo "Até mais!"
		exit
		
	else
		echo ""
		echo "Opa, não encontrei a pasta WEB-INF ou static na raiz do arquivo $caminhoFix."
		echo "Não fizemos nada por enquanto. Até mais!"
		exit
	fi
else
	echo "Certo, não fizemos nada por enquanto."
	echo "Até mais!"
	exit
fi
