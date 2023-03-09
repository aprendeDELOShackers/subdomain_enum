#!/bin/bash

#Ejecución de puredns:
#Antes de ejecutar puredns debemos de generar el "resolvers dns publico" Para ellos uzaremos la herramienta
#dnsvalidator# para obt info de "resoluctores dns publico" que son importante

#Resolutor de DNS publico podemos encontar en "https://public-dns .info/nameservers.txt"
domain=$1
wordlists=/usr/share/wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
valid_dns(){
	mkdir -p $domain/dsnResolve $domain/brute_force $domain/sub
	dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 100 -o $domain/dnsResolve/resolvers.txt
}
valid_dns

#############################################################################################################

puredns(){
	puredns bruteforce $wordlists $domain -r $domain/dnsResolve/resolvers.txt -w $domain/brute_force/posiSub.txt
}
puredns

#Resoldns
shuffledns(){
	shuffledns -d $domino -list $domain/brute_force/posiSub.txt -r $domain/dnsResolve/resolvers.txt -o $domain/brute_force/subposi.txt
	cat /$domain/brute_force/*.txt | sort -u  | anew | $domain/brute_force/all.txt
}
shuffledns

DNS_resolving(){
	puredns resolve $domain/brute_force/all.txt -r $resolvers | anew $domain/sub/sub_vali.txt

}

