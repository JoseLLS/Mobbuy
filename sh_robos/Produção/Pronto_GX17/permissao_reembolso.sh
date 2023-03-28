# Dar permissao aos arquivos de Reembolso

FILES="`ls /mnt/home1/SubAdquirencia/025/reembolso/env`"

if [ "$FILES" != "" ]
then
  sudo chmod 777 /mnt/home1/SubAdquirencia/025/reembolso/env/*.txt
  sudo chown tomcat:tomcat /mnt/home1/SubAdquirencia/025/reembolso/env/*.txt
fi

