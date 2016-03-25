/*
          GeoIP block[v1.0]
      (c) Copyright 2013-2014 by Inferno
 
	  @author    : Inferno (http://www.infus211.ct8.pl)
	  @date      : 14 wrze�nia 2014
	  @update    : 14 wrze�nia 2014

	Do poprawnego dzia�ania wymagana jest zainstalowana biblioteka GeoLiteCity dla php.
	Instalacja biblioteki: http://php.net/manual/en/geoip.setup.php
	W razie braku mo�liwo�ci instalacji plik ten znajduje si� na http://www.PTSRP.pl/geoip.php
	  
*/ 

#include <a_samp>
#include <a_http>
#include <zcmd>

#define PHP_GEOIP "yourwebsite.pl/geoip.php?ip=%s"

public OnPlayerConnect(playerid)
{
	new playerip[20];
	GetPlayerIp(playerid, playerip, 20);
	
	new file[128];
	format(file, 128, "Truck/Allowip/%s.txt", playerip);
	if(fexist(file))
	{
		new stringurl[128];
		format(stringurl, 128, PHP_GEOIP, playerip);
		print(stringurl);
		HTTP(playerid, HTTP_GET, stringurl, "", "SprawdzanieGEOIP");
	}
	else SendClientMessage(playerid, -1, "To IP jest dodane do wyj�tk�w!");
	
	
	return 1;
}

CMD:dodajip(playerid, params[])
{
	if(isnull(params))
		return SendClientMessage(playerid, -1, "U�yj: /dodajip <ip>");
		
	new file[128];
	format(file, 128, "Truck/Allowip/%s.txt", params);
	if(fexist(file)) return SendClientMessage(playerid, -1, "To IP jest ju� dodane do wyj�tk�w!");
	//if(!file_create(file)) return SendClientMessage(playerid, -1, "B��d przy dodawaniu!");
	
	new File: pliczek = fopen(file);
	fwrite(pliczek, Nick(playerid));
	fclose(pliczek);
	
	new string[128];
	format(string, 128, "IP %s zosta�o dodane do whitelisty!", params);
	SendClientMessage(playerid, -1, string);
	return 1;
}

forward SprawdzanieGEOIP(index, response_code, data[]);
public SprawdzanieGEOIP(index, response_code, data[])
{
	if(response_code != 200) return print("[ERROR]B��d przy sprawdzaniu GEOIP!"); //wiadomo�� o b��dzie czy co�
    if(!strcmp(data, "PL", true))
		return SendClientMessage(index, -1, "Proxy nie zosta�o wykryte!");
		
	ShowPlayerDialog(index, 9999, DIALOG_STYLE_MSGBOX, "Wykryto proxy", "Niestety, wykryto u Ciebie proxy przez co nie mo�esz wej��\nna serwer. Je�eli uwa�asz �e to b��d skontaktuj si� z dowolnym\noperatorem.\n\nStrona: www.ptsrp.pl\nTS3: ts3.ptsrp.pl", "Rozumiem", "");
	SetTimerEx("ToKick", 500, false, "i", index);
	return 1;
}

stock Nick(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

forward ToKick(playerid);
public ToKick(playerid)
{
	if(IsPlayerConnected(playerid)) Kick(playerid);
	return 1;
}