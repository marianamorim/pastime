#################################################################
###############MENU TOOLKIT HELP WITH CASE'S SPAM################
#################################################################
delimiter="-"
menu()
{
reset
echo "---------------------------------------------------------"
echo ""
echo -e "\033[32m Ferramenta SPAM em Shell Script \033[0m"
echo " + Coded by LittleMaryh"
echo ""
echo "---------------------------------------------------------"
echo ""

echo "Opções:"
echo -e "\033[94m [1] Tratar Dominios SPAM \033[0m"
echo -e "\033[93m [2] Obter IPs Dominios de SPAM \033[0m"
echo -e "\033[95m [3] Finalizar Script \033[0m"
echo ""
echo -n "Opção: "
read i

case $i in
1) tratar;;
2) multiping;;
3) clear; exit;;
*) menu;;
esac
}

################################################################
################TRATAR ARQUIVO DOS DOMINIOS ####################
##########################SPAM##################################
################################################################

tratar()
{

##Esta função tratará o arquivo
##Para manipulação nas demais funções

#cat = le todo conteudo do arq. txt passado como parametro
#awk '{prinnt $1}' =  de todo conteúdo irá filtrar somente o que está na primeira coluna
#grep -v = irá ignorar os registros destes dominios, pois são válidos
#sort -b = ignora linhas em branco
#sort -u = irá ignorar registros duplicados
#sed 's/option//g = irá substituir option por nada, pois quero ignorar essas palavras
#sed -e :a -e '$!N;s/\n@/\n/;ta' -e 'P;D' = se a linha começar com @, vai substituir o @ por nova linha
#listSpamToManipule.txt = tera o conteudo necessario

echo -n "Digite o local do arquivo a ser tratado para manipulação:"
read spam

cat $spam | grep -v 'uol.com' | grep -v 'yahoo.com' | grep -v 'hotmail.com' | grep -v 'bol'| grep -v 'ig' | grep -v 'terra' | egrep -v 'gmail' | awk '{print $1}' | sort -b | uniq -u | sort -u | sed 's/option//g' | sed -e :a -e '$!N;s/\n@/\n/;ta' -e 'P;D' > listSpamToManipule.txt

echo ""
echo -e "\033[94m Arquivo Pronto para manipulação \033[0m"
echo ""

sleep 5
menu
}


################################################################
###############FUNCAO OBTER IP DOS DOMINIOS ####################
##########################SPAM##################################
################################################################

multiping()
{

####Solicita caminho completo e nome do arquivo que detém dos###
####domínios maliciosos, caracteristicos de spam             ###  

echo -n "Digite o local do arquivo que contem os Dominios SPAM:"
read arq_ips

for i in $(cat $arq_ips); do       #Laço para ler arq. até final
ping "-c1 "+ $i                    #Pingar única vez cada dominio
if [ $? -gt 0 ];                   #Var $? valida se ping foi 
then			           #satisfatorio, 0=Y e 1=N
echo -e "\033[91m IP não encontrado: $i \033[0m" 
ping "-c1"+ $i | grep -oP "([0-9]{1,3}\.){3}[0-9]{1,3}" $delimiter >> hostNotFound.txt
ping "-c1"+ $i >> hostNotFound1.txt
echo ""
else
echo ""
ping "-c1 "+ $i | grep -oP "([0-9]{1,3}\.){3}[0-9]{1,3}" >> host.txt
echo -e "\033[94m Ping enviado com sucesso ao IP: $i \033[0m"
echo ""
fi

done
echo "Processo finalizado ...."
cat host.txt | grep -oP "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -u >> hostFound.txt
cat hostNotFound1.txt | grep PING >> hostNotPing.txt
sleep 3

rm host.txt
rm hostNotFound.txt
gedit hostFound.txt &
gedit hostNotPing.txt &
menu


}

###############################################################
menu
###############################################################
