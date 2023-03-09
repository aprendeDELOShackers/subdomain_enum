#!/bin/bash

domain=$1
wordlists=/usr/share/wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top50000.txt

valid_dns(){
        mkdir -p $domain/dsnResolve $domain/Sub $domain/Resolve
        dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 100 -o $domain/dnsResolve/resolvers.txt
}
valid_dns
puredns(){
        puredns bruteforce $wordlists $domain -r $domain/dnsResolve/resolvers.txt -w $domain/Sub/sub.txt
}
puredns

#DNS_resolving(){
        #puredns resolve $domain/Sub/brute_f.txt -r $resolvers | anew $domain/Resolve/sub_vali.txt

#}
##################################################################################################################

p=permutations-txtt
	#Premutation/Alterations
al_perm(){
        gotator -sub $domain/Sub/brute_f.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md > $domain/Sub/perm.txt
#Validar o resolver o verificar si es valido
#        puredns resolve $domain/Sub/perm.txt -r resolvers.txt | anew $domain/Resolve/valido.txt
}
#####################################################################################################################

#Scraping(JS/source code) o raspado(JS/codigo fuente)
#corrindo gospider ====> Este proseso se divide en tres parte
#1)Subdomio de Sondeo Web
#2)Limpiesa de Salida
#3)Resolver nuestro dominio del destino

sub(){
        mkdir -p $domain $domain/sub $domain/httpx $domain/gos_sub;
        assetfinder --sub-only $domain | anew $domain/sub/asset.txt;
}
sub
#1)Subdomio de Sondeo Web
httpx(){
        cat $donain/sub/asset.txt | httpx -random-agent -retries 2 -no-color | anew $domain/httpx/urlpro-txt;
}
httpx

gospider(){
#-S, --sites | -t, --threads | #-w, --include-subs | -d, --depth | -r, --include-other-source
        gospider -S $domain/httpx/urlpro.txt --js -t 50 -d 3 --sitemap --robots -w -r | anew  $domain/gos_sub/gos.txt;
#2)Limpiesa de Salida
        cat $domain/gos_sub/gos.txt | sed '/^.\{2048\}./d' > $domain/gos_sub/gospro.txt;
        cat $domain/gos_sub/gospro.txt | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep "*.$domain.com" | sort - u | anew $domain/gos_sub/sub.txt
}
gospider

#3)Resolver nuestro dominio del destino
puredns(){
        puredns resolve $domain/gos_sub/sub.txt -w $domain/gos_sub/sub_real.txt -r $resolvers
        cat $domain/gos_sub/sub_real.txt
}
puredns
#GOOGLE ANALITIC con "BuiltWidth" es una extension
#Utilizamos una tools en lineas de comando llamado "AnaliticsRelationships"
domain=$1

AnaliticsRelationships(){
        mkdir -p $domain $domain/sub
        analyticsrelationships --url $domain | anew $domain/sub/subdomain.txt
        cat $domain/sub/subdomain.txt
}
AnaliticsRelationships

#validar dns
puredns(){
        puredns resolve $domain/sub/subdomain.txt -w $domain/sub/sub_real.txt -r $resolvers
        cat $domain/sub/sub_real.txt
}
puredns
#sondeo TLS, CSP, CNAME
#Para ellos utilizamos la tools llamada CERO


        #Sondeo TLS =====> Transporte leye segurity
domain=$1
cero(){
        mkdir -p $domain $domain/subdo
        cero $domain | sed 's/^*.//g' | grep -e "\." | anew $domain/subdo/sub.txt
#validar dns
        puredns resolve $domain/subdo/sub.txt -w $domain/subdo/sub_real.txt -r $resolvers


}
cero
        #Sondeo CSP ====> Politica seguridad de contenido

cat su.txt | httpx -csp-probe -status-code -retries 2 -no-color -silent | anew csp.txt | cut -d ' ' -f1 | unfurl -u domains | anew sub.tst


