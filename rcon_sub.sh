#!/bin/bash

#Autor= "Nu||d3v"==============="new_day_is"

#####################################################################################################################
#Automatization for Search subdomaind === "amass","assetfinder","findomain","subfinder","sublist3r","crobat","turbolist3r.py","ctfr.py","anubis","acamar.py","github-subdomains.oy","shuffledns","cencys-subdomain.py"
#####################################################################################################################

dominio=$1
wordlists=/usr/share/wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
resolvers=/home/josema96/HackerOne/hunters_tools/resolvers.txt

#funtion1
Help(){
	echo -e "\n\tRcon_Scriptkiddie.sh"
	echo -e "\n\tEjemplo de ejecución de la herramienta"
	echo -e "\n\t./R_recon.sh"
}
#funtion2
vali_domain(){
	host $dominio > /dev/null 2>&1
}

#funtion3
subdomain(){
	mkdir -p $dominio $dominio/sub $dominio/httpx
#passive sub proporcionado por fuentes como
	amass enum -d $dominio | sort -u | anew $ruta/amass.txt;
	assetfinder --subs-only $dominio | sort -u | anew $dominio/sub/asset.txt;
	findomain --output -t $dominio 2> /dev/null ; cp $(pwd)/*.txt $dominio/sub ; rm $(pwd)/*.txt
	subfinder -d $dominio -silent | sort -u | anew $dominio/sub/subfin.txt;
	sublist3r -d $dominio -o $dominio/sub/sublis.txt;
	turbolist3r.py -d $dominio -o $dominio/sub/turbo.txt;
	anubis -t $dominio  -S | sort -u | anew $dominio/sub/anub.txt;
	acamar.py $dominio 2>/dev/null ; cp $(pwd)/*.txt $dominio/sub ; rm $(pwd)/*.txt
#Conjuntos de datos de "Sonda"o"Sonar" del proyecto Rapid7 para sacar subdomains
	crobat -s $dominio | tee $dominio/sub/crob.txt;
#Registro de Certificado o logs "https://crt.sh"
	ctfr.py -d $dominio -o $dominio/sub/ctfr.txt;
#Github scraping o raspado de subdomain
	github-subdomains.py -t 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 -d $dominio | sort -u | anew $dominio/sub/git_su.txt;
#Archivos de Internet con "gauplus":"waybackulr":"unfurl" para sacar subdomain
        gauplus -t 5 -random-agent -subs $dominio | unfurl --unique domains | anew $dominio/sub/gau.txt;
        waybackurls $dominio | unfurl -u domains | anew $dominio/sub/way.txt;
#Fuentes passiva
	censys-subdomain.py --censys-api-id 00a19a0d-3bef-4a04-a75f-ac97844c98f1 --censys-api-secret wYSZz8VA9EHvj8YvG>
#brute force for subdomaind "shuffledns"
	shuffledns -d $dominio -w $wordlists -r $resolvers | sort -u | anew $dominio/sub/shuff.txt;
	puredns bruteforce $wordlists $dominio -r $resolvers | tee $dominio/sub/pure.txt;

	echo -e "\n\tguardando todo los sub all 'all.txt'\n"
	cat $dominio/sub/*.txt 2>/dev/null | tee $dominio/sub/all.txt;
	cat $dominio/sub/all.txt 2> /dev/null | anew $dominio/sub/all_sub.txtt;
	echo -e "\n\teliminando el archivo all.txt\n"
	rm $dominio/sub/*.txt;
	echo -e "\n\tse guardo todos los subdominio en el archivo unico 'all_sub.txtt'\n"
}

#resol_Domain(){
	#echo -e "\n\tValidando subdomains o DNS con 'shuffledns'\n"
	#shuffledns -d $domino -list $dominio/sub/all.txtt -o $domini/sub/sub_vali.txtt -r $resolvers
#Validar o resolver o verificar si es valido los subdominio
        #puredns resolve $domains/gatator_permu/valid-perm.txt -r $resolvers | anew $dominio/sub/sub_vali.txt

#}

#funtion5
		#Validar si existe tal "URL" con "httpx"
httpx(){
	echo -e "\n\tvalidar existente 'url'\n"
	cat $dominio/sub/all_sub.txtt | httpx | sort -u | anew $dominio/httpx/u.txt
	echo -e "\n\ttermino la ejecución"
}

#funtion6
#validar si existe tal "URL" con "urlprobe"
#urlprobe(){
#	echo -e "\n\tvalidar existente 'url'\n"
#	cat $ruta/domains_vali.txtt | sort -u | anew $ruta/probe.txt
#	echo -e "\n\ttermino ña ejecucion"
#}

#fintion7
#fhc(){
	#echo -e "\n\tvalidar existente 'url'\n"
	#cat $dominio/sub/all_sub.txtt | fhc | tee $dominio/fhc/fhc.txt
	#echo -e "\n\ttermino la ejecucion\n"
#}

#funtion8
#main call funtions
if [ "$#" == "1" ];then
	vali_domain
	if [ "$(echo $?)" == "0" ];then
		subdomain
		#resol_Domain
		httpx
		#urlprobe
		#fhc
	else
		echo -e "\nno es un dominio"
	fi
else
	Help

fi
