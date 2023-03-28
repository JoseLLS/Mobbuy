# Dar permissao aos arquivos de Reembolso

FILES="`ls /mnt/home1/SubAdquirencia/012/reembolso/env`"

if [ "$FILES" != "" ]
then
  sudo chmod 777 /mnt/home1/SubAdquirencia/012/reembolso/env/*.rem
  sudo chown tomcat:tomcat /mnt/home1/SubAdquirencia/012/reembolso/env/*.rem
fi

