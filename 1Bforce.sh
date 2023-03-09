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
	xargs -a posiSub.txt -I@ sh -c 'subfinder -d @ | anew $domain/brute_force/xargs.txt'
	cat $domain/brute_force/xargs.txt | anew $domain/brute_force/posiSub.txt
}
puredns

#validar subdomain
DNS_resolving(){

	puredns resolve $domain/brute_force/posiSub.txt -r $domain/dnsResolve/resolvers.txt | anew $domain/sub/sub_vali.txt
	cp $domain/sub/sub_vali.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
	
}
DNS_resolving
