
#!/bin/bash

#Scraping(JS/source code) o raspado(JS/codigo fuente)
#corrindo gospider ====> Este proseso se divide en tres parte
#1)Subdomio de Sondeo Web
#2)Limpiesa de Salida
#3)Resolver nuestro dominio del destino

domain=$1
resolvers=/home/josema96/HackerOne/hunters_tools/resolvers.txt

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



#echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only |  tee sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color | tee http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r | tail -1000 | anew gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4

#echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only > sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color > http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r > gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4


