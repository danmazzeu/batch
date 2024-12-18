@echo off
:: Title
title Trocar IP Wi-Fi

:: Color Matrix
color 0A

:: Counter
set counter=0

:loop
:: Configuration
set interface="Wi-Fi"
set /a ultimo_octeto=%random% %% 255
set novo_ip=192.168.11.%ultimo_octeto%
set mascara=255.255.254.0
set gateway=192.168.10.254
set dns=8.8.8.8

:: Timer
set minutes=5
set timer=60*%minutes%

:: Command to configure the new IP
netsh interface ipv4 set address "%interface%" static %novo_ip% %mascara% %gateway%
set /a counter+=1

:: Command to configure the DNS (optional)
:: netsh interface ipv4 set dnsservers "%interface%" static %dns% primary

:: Result
echo #######################################
echo * IP alterado com sucesso!
echo * Nova configuracao de rede:
echo * Interface: %interface%
echo * IP: %novo_ip%
echo * Mascara: %mascara%
echo * Gateway: %gateway%
echo * DNS: %dns%
echo * Proxima alteracao em %minutes% minuto(s).
echo * Ja foram alterados %counter% IP's.
echo #######################################

:: Restart
ping 127.0.0.1 -n %timer% > nul & goto loop
