<?php

	/*
          GeoIP block[v1.0]
      (c) Copyright 2013-2014 by Inferno
 
	  @author    : Inferno (http://www.infus211.ct8.pl)
	  @date      : 14 września 2014
	  @update    : 14 września 2014

	Do poprawnego działania wymagana jest zainstalowana biblioteka GeoLiteCity dla php.
	Instalacja biblioteki: http://php.net/manual/en/geoip.setup.php
	W razie braku możliwości instalacji plik ten znajduje się na http://www.PTSRP.pl/geoip.php
  
	*/ 

print_r( geoip_country_code_by_name ($_GET['ip']));

?>