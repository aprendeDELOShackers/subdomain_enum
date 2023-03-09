#!/bin/bash

	#VHOST probing

#hay 2 clase tipos VHOST virtual
# 1=Host vitual basado en IP y 2=Host virtual basado en nombre

#Como podemos identificar VHOST en una sola IP..?
#Para ellos utilizamos la tools llamada "HosthHunter"
domain=$1
Hosthunter(){
	mkdir -p $domain $domain/subdominio
	pyrhon3 hosthunter ip.txt

}
Hosthunter

	#Bruteforce VHOST
	gobuster -vhost -u https://ejemplo.com -t 50 -w subdomain.txt
