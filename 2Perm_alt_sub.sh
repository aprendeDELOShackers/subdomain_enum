#!/bin/bash

domain=$1
p=permutations.txtt
#Premutation/Alterations
	mkdir -p $domain $domain/sub $domain/gotator_permu
	echo [+] ejecutando assetfinder
	subfinder -d $domain | tee $domain/sub/sub.txt
	echo  [+] ejecutando gotator
	gotator -sub $domain/sub/sub.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md > $domain/gotator_permu/perm.txt
#Validar o resolver o verificar si es valido
        puredns resolve $domain/gotator_permu/perm.txt -r resolvers.txt | anew $domain/gotator_permu/valido.txt
	cp $domain/gotator_permu/perm_sub.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
	#rm -rf $domain



#echo [+] ejecuando assetfinder ; assetfinder -subs-only testphp.vulnweb.com | tee sub.txt ; gotator -sub sub.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md > perm.txt ; puredns resolve perm.txt -r resolvers.txt | anew valido.tx

#otra manera de resolver o validar dns
#assetfinder -subs-only testphp.vulnweb.com | tail -6 | massdns -r resolvers.txt -t A -o S -w resul.txt.

