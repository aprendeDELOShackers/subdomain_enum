#!/bin/bash

domains=$1
wordlists=/usr/share/wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
resolvers=/home/josema96/HackerOne/hunters_tools/resolvers.txt

####################################################################################################################################################################################
		#Tecnica Passive
subdomain_(){
	mkdir -p $domains $domains/sub/sub-real $domains/gotator_permu $domains/httprobe 
#Active enumeration passive
	#amass enum -passive -d $domains | sort -u | anew $domains/sub/amass.txt;
	assetfinder --subs-only $domains | sort -u | anew $domains/sub/asset.txt;
	findomain --output -t $domains 2> /dev/null ; cp $(pwd)/*.txt $domains/sub ; rm $(pwd)/*.txt;
	#subfinder -d $domains | sort -u | anew $domains/sub/subfin.txt;
	sublist3r -d $domains -o $domains/sub/sublis.txt;
#Archivos de Internet con "gauplus":"waybackulr":"unfurl" para sacar subdomain
	gauplus -t 5 -random-agent -subs $domains | unfurl --unique domains | anew $domains/sub/gau.txt;
	waybackurls $domains | unfurl -u domains | anew $domains/sub/way.txt;
#Conjuntos de datos de "Sonda"o"Sonar" del proyecto Rapid7 para sacar subdomains
	crobat -s $domains > $domains/sub/crob.txt;
#Registro de Certificado "https://crt.sh"
	ctfr.py -d $domains | sort -u | anew $domains/sub/ctfr.txt;
########################################################################################
######:La tecnica #Enumeracion recursiva" corrienso las tools menciona anteriormente:###############################################################################################
	#Tecnica Activa
#bruteforce DNS subdomains
        #shuffledns -d $dominio -w $wordlists -r $resolvers | sort -u | anew $domains/sub/shuff.txt;
        puredns bruteforce $wordlists $domains -r $resolvers | tee $domains/sub/pure.txt;
	cat $domains/sub/*.txt > $domains/sub/allSub.txt;
	cp $domains/sub/allSub.txt  $domains/gotator_permu/perm_sub.txt;

#Premutation/Alterations
	gotator -sub $domains/gatator_permu/perm_sub.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md -silent | anew $domains/gatator_permu/posible-sub.txt
#Validar o resolver o verificar si es valido
	puredns resolve $domains/gatator_permu/posible-sub.txt -r $resolvers | anew $domains/sub/permuSub.txt
	cat $domains/sub/allSub.txt $domains/sub/permuSub.txt | anew $domains/sub/sub-real/vali_sub.txt
}
subdomain_
####################################################################################################################################################################################
resol_DNS(){
	puredns resolve $domains/sub/sub-real/vali_sub.txt -r $resolvers | anew $domains/sub/sub-real/subdomain.txt
	#shuffledns -d $domino -list $domains/sub/all.txt -o $domains/sub/resol.txt -r $resolvers

}
resol_DNS
####################################################################################################################################################################################
#http_probe(){
	#cat $domains/sub/resol_dns/*.txt | fhc | sort -u | anew $domains/httprobe/probe.txt
#	cat $domains/sub/sub-real/subdomain.txt | httpx | sort -u | anew $domains/httprobe/probe.txt
	#cat $domains/sub/resol_dns/*.txt | urlprobe | sort -u | anew $domains/httprobe/probe.txt
#}
#http_probe
####################################################################################################################################################################################



