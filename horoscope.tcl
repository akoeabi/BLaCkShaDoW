#######################################################################################################
## BlackHoroscop 1.4.1  (10/04/2020) 		  Drepturi de autor 2008 - 2020 @ WwW.TCLScripts.NET ##
## - romanian version -   _   _   _   _   _   _   _   _   _   _   _   _   _   _                      ##
##                       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \                     ##
##                      ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )                    ##
##                       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/                     ##
##                                                                                                   ##
##                                      ® BLaCkShaDoW Production ®                                   ##
##                                                                                                   ##
##                                              PRESENTS                                             ##
##									                           ® ##
#########################################  BLACK HOROSCOP TCL   #######################################
##									                             ##
##  DESCRIERE: 						 	                                     ##
##  Ofera previziune detaliate zilnice ale horoscopului pentru fiecare semn zodiacal.                ##
##									                             ##
##  Semne zodiacale: Berbec, Taur, Gemeni, Rac, Leu, Fecioara, Balanta, Scorpion, Sagetator,         ##
##                   Capricorn, Varsator si Pesti.                                                   ##
##									                             ##
##  Testat pe Eggdrop v1.8.3 (Debian Linux 3.16.0-4-amd64) versiune Tcl : 8.6.6                      ##
##									                             ##
#######################################################################################################
##									                             ##
##                                 /===============================\                                 ##
##                                 |      This Space For Rent      |                                 ##
##                                 \===============================/                                 ##
##									                             ##
#######################################################################################################
##									                             ##
##  INSTALARE: 							                                     ##
##     ++ pachetele http si json sunt necesare pentru ca acest script sa functioneze.                ##
##     ++ Editeaza BlackHoroscop.tcl si pune-l in directorul /scripts al eggdropului tau,            ##
##     ++ adauga linia "source scripts/BlackHoroscop.tcl" in conf-ul eggdropului tau si apoi rehash. ##
##									                             ##
#######################################################################################################
##									                             ##
##  ISTORIE:                                                                                         ##
##  - versiunea 1.4.1
##    + am schimbat site-ul sursa
##  - versiunea 1.4                                                                                  ##
##    + complet reconstruit intr-un stil nou si cu o alta sursa web de informatii pentru horoscop.   ##
##    + adaugate setari de protectie la flood impotriva celor care abuzeaza de folosirea comenzilor. ##
##    + adăugata setare pentru o zodie prestabilita fiecarui user, diferita pentru fiecare canal.    ##
##    + adaugate informatii procentuale despre dragoste, sanatate si succes.                         ##
##    + adaugate informatii suplimentare despre numerele norocoase.                                  ##
##    + adaugat suport utf-8.                                                                        ##
##  - versiunea 1.3                                                                                  ##
##    + sursa web actualizata.                                                                       ##
##    + rezolvate cateva bug-uri minore.                                                             ##
##									                             ##
#######################################################################################################
##									                             ##
##  LINK-uRI OFICIALE:                                                                               ##
##   E-mail            : BLaCkShaDoW[arond]tclscripts.net                                            ##
##   Raportare bug-uri : http://www.tclscripts.net                                                   ##
##   Pagina GitHub     : https://github.com/tclscripts/ 			                     ##
##   Ajutor online     : irc://irc.undernet.org/tcl-help                                             ##
##                 Canal #TCL-HELP / Retea UnderNet        	                                     ##
##                 Puteti sa intrebati atat in lb. romana, cat si in lb. engleza                     ##
##									                             ##
##     paypal.me/DanielVoipan = Luati in considerare o donatie. Multumesc!                           ##
##									                             ##
#######################################################################################################
##									                             ##
##                           Vrei un TCL script personalizat pentru eggdropul tau?                   ##
##                               Nimic mai simplu, doar spune-ne ce ai dori!                         ##
##                   Se poate crea aproape orice TCL pe baza ideilor si donatiilor tale.             ##
##                  Trimite un email la blackshadow@tclscripts.net sau info@tclscripts.net           ##
##                    cu informatiile necesare si te voi contacta cat mai curand posibil.            ##
##									                             ##
#######################################################################################################
##									                             ##
##  COMENZI:                                                                                         ##
##									                             ##
##  Pentru activare: .chanset #canal +horoscop | prin BlackTools: .set +horoscop                     ##
##                                                                                                   ##
##  ![horoscop|zodie] [?|help] - afiseaza toate comenzile disponibile.                               ##
##                                                                                                   ##
##  !zodie [set|reset] [zodie] - seteaza zodie implicita user.                                       ##
##                                                                                                   ##
##  !zodie [nick] - returneaza predictiile zodiei pentru ziua curenta.                               ##
##                                                                                                   ##
##  ![zodie] - returneaza predictiile zodiei pentru ziua curenta.                                    ##
##                                                                                                   ##
##  !noroc [nick] - arata predictiile numerelor norocoase pentru ziua curenta.                       ##
##                                                                                                   ##
##  ![horoscop|zodie] version - arata versiunea actuala a scriptului BlackHoroscop.                  ##
##                                                                                                   ##
#######################################################################################################
##                                                                                                   ##
##  EXEMPLE:                                                                                         ##
##									                             ##
##  <user> !berbec                                                                                   ##
##  <bot> Berbec (Astazi): Ai parte de o zi pozitiva, in mare parte, cu momente in care vei observa  ##
##               o recuperare a puterii de a lua decizii pe baza unor observatii corecte, tinand cont## 
##               de ceilalti. Faptul ca vrei ceva anume nu este o garantie ca iti va fi bine daca il ##
##               obtii si nici ca il vei putea obtine. Astazi trebuie sa faci o selectie practica a  ##
##               dorintelor. Sanatate: 45% Dragoste: 50% Succes: 50%                                 ##
##									                             ##
##  <user> !zodie berbec                                                                             ##
##  <bot> Berbec (Astazi): Ai parte de o zi pozitiva, in mare parte, cu momente in care vei observa  ##
##               o recuperare a puterii de a lua decizii pe baza unor observatii corecte, tinand cont## 
##               de ceilalti. Faptul ca vrei ceva anume nu este o garantie ca iti va fi bine daca il ##
##               obtii si nici ca il vei putea obtine. Astazi trebuie sa faci o selectie practica a  ##
##               dorintelor. Sanatate: 45% Dragoste: 50% Succes: 50%                                 ##
##									                             ##
##  <user> !noroc pesti                                                                              ##
##  <bot> Pesti -- Numere norocoase astazi: 13,21,16,7,49,24.                                        ##
##                                                                                                   ##
##  De asemenea, va puteti seta o zodie implicita, folosind: !zodie set [zodie]                      ##
##									                             ##
##  <user> !zodie set gemeni                                                                         ##
##                                                                                                   ##
##  Dupa ce ati setat o zodie, pur si simplu utilizati !zodie si va arata predictiile pentru aceasta.##
##                                                                                                   ##
##  <user> !zodie                                                                                    ##
##  <bot> Gemeni (Astazi): S-ar putea sa te confrunti cu probleme complexe si sa fii surprins.       ##
##               Domeniul vizat este munca, dar nici daca vei petrece mai mult timp acasa nu te poti ##
##               astepta sa fii ferit. Poti ajunge la o intelegere cu anumite persoane cu care te    ##
##               afli intr-un conflict acut. Este important sa nu fortezi nota si sa nu te bazezi pe ##
##               noroc, ci pe bun simt. Sanatate: 35% Dragoste: 65% Succes: 70%                      ##
##                                                                                                   ##
##  Pentru a reseta zodia implicita, pur si simplu tastati: !zodie reset                             ##
##                                                                                                   ##
##  Puteti vedea si informatiile altor useri care au salvate zodii, prin specificarea nickului lor.  ##
##                                                                                                   ##
##  <user> !zodie user                                                                               ##
##  <bot> Taur (Astazi): Ar fi de dorit sa domolesti, atat cat este posibil, tendinta de a planifica ##
##             viitorul, intr-un moment in care il vezi in culori sumbre. Usurinta cu care ajungi la ##
##             concluzia ca ai scapat, deja, de anumite probleme profesionale sau de imagine este    ##
##             dezarmanta pentru cei care te cunosc bine. Sanatate: 65% Dragoste: 80% Succes: 70%    ##
##									                             ##
##  <user> !noroc user                                                                               ##
##  <bot> Taur -- Numere norocoase astazi: 18,34,25,10,36,21.                                        ##
##                                                                                                   ##
##  Semne zodiacale: Berbec, Taur, Gemeni, Rac, Leu, Fecioara, Balanta, Scorpion, Sagetator,         ##
##                   Capricorn, Varsator si Pesti.                                                   ##
##                                                                                                   ##
#######################################################################################################
##									                             ##
##  LICENTA:                                                                                         ##
##   Acest program vine cu ABSOLUT NICIO GARANTIE.                                                   ##
##                                                                                                   ##
##   Acest cod este un software liber; il puteti redistribui si/sau modifica in termenii licentei    ## 
##   PUBLICE GENERALE GNU versiunea 3 publicata de catre Free Software Foundation.                   ##
##                                                                                                   ##
##   Aceasta sursa cod este distribuita FARA NICIO GARANTIE; chiar fara garantia implicita de        ##
##   vandabilitate sau conformitate unui anumit scop.                                                ##
##                                                                                                   ##
##   Cititi Licenta Publica Generala GNU pentru detalii.                                             ##
##        (http://www.gnu.org/copyleft/library.txt)                                                  ##
##                                                                                                   ##
##  			  Drepturi de autor 2008 - 2018 @ WwW.TCLScripts.NET                         ##
##                                                                                                   ##
#######################################################################################################

#######################################################################################################
###                               CONFIGURARI PENTRU BlackHoroscop RO TCL                           ###
#######################################################################################################

###
# Cmdchar trigger
# - set here the trigger you want to use.
###
set horoscop(cmd_char) "!"

###
# User db file
# - specifies the file where all users weather locations are stored.
###
set horoscop(user_file) "scripts/Blackhoroscop.RO.users.txt"

###
# Channel flags
# - to activate the script:
# .set +horoscop or .chanset #channel +horoscop
###
setudef flag horoscop

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders, 0 to disable flood protection
###
set horoscop(ignore_prot) "1"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 3:10, which allows for upto 3 queries in 10 seconds. 3 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set horoscop(flood_prot) "3:10"

###
# Output type
# 1 - NOTICE ; 0 - CHANNEL
###
set horoscop(output_type) "1"

#######################################################################################################
###                    NU MODIFICATI DE AICI INCOLO DECAT DACA AVETI HABAR CE FACETI                ###
#######################################################################################################

package require http
package require json

###
# Bindings
# - using commands
bind pubm - * horoscop:get:cmd
bind pub - $horoscop(cmd_char)noroc horoscop:noroc:cmd
bind pub - $horoscop(cmd_char)zodie horoscop:zodie:cmd
bind pub - $horoscop(cmd_char)horoscop horoscop:zodie:cmd

#OBF
set horoscop(zodii) "Berbec Taur Gemeni Rac Leu Fecioara Balanta Scorpion Sagetator Capricorn Varsator Pesti"
#/OBF

###
if {![file exists $horoscop(user_file)]} {
	set file [open $horoscop(user_file) w]
	close $file
}

###
proc horoscop:zodie:cmd {nick host hand chan arg} {
	global horoscop
if {![channel get $chan horoscop]} {
	return
}
	set flood_protect [horoscop:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [horoscop:get:flood_time $host $chan]
	horoscop:say $nick $chan [list $nick $get_seconds] 13
	return
}
	set cmd [lindex [split $arg] 0]
	set zodie [lindex [split $arg] 1]
	
switch $cmd {
	set {
if {[lsearch -nocase $horoscop(zodii) $zodie] < 0} {
	horoscop:say $nick $chan [list $nick $zodie] 5
	return
			}
	horoscop:setsign $nick $host $chan $zodie 0		
	horoscop:say $nick $chan [list $nick $zodie] 2
	return
		}
	reset {
	set check_sign [horoscop:getsign $nick $host $chan]
if {$check_sign == "0"} {
	horoscop:say $nick $chan [list $nick $horoscop(cmd_char)] 3
	return
			} else {
	horoscop:setsign $nick $host $chan $zodie 1
	horoscop:say $nick $chan [list $nick] 4
	return
			}
		}
	help {
	horoscop:say $nick $chan [list $horoscop(cmd_char)] help
	return
		}
	\? {
	horoscop:say $nick $chan [list $horoscop(cmd_char)] help
	return
		}
	version {
	horoscop:say "" $chan [list $horoscop(cmd_char)] version
	return
		}
	}
if {[onchan $cmd $chan]} {
	set get_host [getchanhost $cmd $chan]
	set check_sign [horoscop:getsign $cmd $get_host $chan]
if {$check_sign == "0"} {
	horoscop:say $nick $chan [list $cmd] 11
	return			
				}
	set get_horoscop [horoscop:get $check_sign]
	set text [lindex $get_horoscop 0]
	set stats [lindex $get_horoscop 2]
	set health [lindex $stats 1]
	set love [lindex $stats 3]
	set success [lindex $stats 5]
	set text "[join $text] \002Sanatate\002: $health% ; \002Dragoste\002: $love% ; \002Success\002: $success%"
foreach w [horoscop:wrap $text 440] {
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $check_sign]\002 (Azi): $w"
			} else { putserv "NOTICE $nick :\002[string toupper $check_sign]\002 (Azi): $w" }
		}
	} elseif {$cmd == ""} {
	set check_sign [horoscop:getsign $nick $host $chan]
if {$check_sign == "0"} {
	horoscop:say $nick $chan [list $nick $horoscop(cmd_char)] 3
	return			
			}
	set get_horoscop [horoscop:get $check_sign]
	set text [lindex $get_horoscop 0]
	set stats [lindex $get_horoscop 2]
	set health [lindex $stats 1]
	set love [lindex $stats 3]
	set success [lindex $stats 5]
	set text "[join $text] \002Sanatate\002: $health% ; \002Dragoste\002: $love% ; \002Success\002: $success%"
foreach w [horoscop:wrap $text 440] {
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $check_sign]\002 (Azi): $w"
			} else {putserv "NOTICE $nick :\002[string toupper $check_sign]\002 (Azi): $w"}
		}
	} else {
if {[lsearch -nocase $horoscop(zodii) $cmd] < 0} {
	horoscop:say $nick $chan [list $nick $cmd] 5
	return
			}
	set get_horoscop [horoscop:get $cmd]
	set text [lindex $get_horoscop 0]
	set stats [lindex $get_horoscop 2]
	set health [lindex $stats 1]
	set love [lindex $stats 3]
	set success [lindex $stats 5]
	set text "[join $text] \002Sanatate\002: $health% ; \002Dragoste\002: $love% ; \002Success\002: $success%"
foreach w [horoscop:wrap $text 440] {
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $cmd]\002 (Azi): $w"
			} else { putserv "NOTICE $nick :\002[string toupper $cmd]\002 (Azi): $w"}
		}
	}
}

###
proc horoscop:noroc:cmd {nick host hand chan arg} {
	global horoscop
if {![channel get $chan horoscop]} {
	return
}
	set flood_protect [horoscop:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [horoscop:get:flood_time $host $chan]
	horoscop:say $nick $chan [list $nick $get_seconds] 13
	return
}
	set zodie [lindex [split $arg] 0]
if {[onchan $zodie $chan]} {
	set get_host [getchanhost $zodie $chan]
	set check_sign [horoscop:getsign $zodie $get_host $chan]
if {$check_sign == "0"} {
	horoscop:say $nick $chan [list $zodie] 11
	return			
				}
	set get_horoscop [horoscop:get $check_sign]
	set numere [lindex $get_horoscop 1]
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $check_sign]\002 -- Numere norocoase astazi: $numere"
		} else { putserv "NOTICE $nick :\002[string toupper $check_sign]\002 -- Numere norocoase astazi: $numere" }
	} elseif {$zodie == ""} {
	set check_sign [horoscop:getsign $nick $host $chan]
if {$check_sign == "0"} {
	horoscop:say $nick $chan [list $nick $horoscop(cmd_char)] 3
	return			
			}
	set get_horoscop [horoscop:get $check_sign]
	set numere [lindex $get_horoscop 1]
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $check_sign]\002 -- Numere norocoase astazi: $numere"
		} else { putserv "NOTICE $nick :\002[string toupper $check_sign]\002 -- Numere norocoase astazi: $numere" }
	} else {
if {[lsearch -nocase $horoscop(zodii) $zodie] < 0} {
	horoscop:say $nick $chan [list $nick $zodie] 5
	return
			}
	set get_horoscop [horoscop:get $zodie]
	set numere [lindex $get_horoscop 1]
	if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $zodie]\002 -- Numere norocoase astazi: $numere"
		} else { putserv "NOTICE $nick :\002[string toupper $zodie]\002 -- Numere norocoase astazi: $numere" }
	}
}

###
proc horoscop:say {nick chan arg type} {
	global black horoscop
	set inc 0
foreach s $arg {
	set inc [expr $inc + 1]
	set replace(%msg.$inc%) $s
}
	set reply [string map [array get replace] $black(horoscop.ro.$type)]
if {$nick == ""} {
	putserv "PRIVMSG $chan :$reply"
	} else {
	putserv "NOTICE $nick :$reply"
	}
}

###
proc horoscop:get:cmd {nick host hand chan arg} {
	global horoscop
if {![channel get $chan horoscop]} {
	return
}	
	set cmd [lindex [split $arg] 0]
	set cmd_map [lindex [split $cmd $horoscop(cmd_char)] 1]
if {[lsearch -nocase $horoscop(zodii) $cmd_map] > -1} {
	set flood_protect [horoscop:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [horoscop:get:flood_time $host $chan]
	horoscop:say $nick $chan [list $nick $get_seconds] 13
	return
}
	set get_horoscop [horoscop:get $cmd_map]
	set text [lindex $get_horoscop 0]
	set stats [lindex $get_horoscop 2]
	set health [lindex $stats 1]
	set love [lindex $stats 3]
	set success [lindex $stats 5]
	set text "[join $text] \002Sanatate\002: $health% ; \002Dragoste\002: $love% ; \002Success\002: $success%"
foreach w [horoscop:wrap $text 440] {
if {$horoscop(output_type) == "0"} {
	putserv "PRIVMSG $chan :\002[string toupper $cmd_map]\002 (Azi): $w"
			} else { putserv "NOTICE $nick :\002[string toupper $cmd_map]\002 (Azi): $w" }
		}
	}
}

###
proc horoscop:getsign {nick host chan} {
	global horoscop
	set file [open $horoscop(user_file) "r"]
	set read_sign ""
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set enc_chan [encoding convertfrom utf-8 $read_chan]
	set read_host [lindex [split $line] 2]
if {[string equal -nocase $enc_chan $chan] && [string match -nocase $host $read_host]} {
	set read_sign [lindex [split $line] 3]
	}
}
	close $file
if {$read_sign == ""} {
	return 0
	} else {
	return $read_sign
	}
}


#OBF
# Credite
set horoscop(numeProiect) "BlackHoroscop"
set horoscop(autor) "BLaCkShaDoW"
set horoscop(website) "wWw.TCLScriptS.NeT"
set horoscop(email) "blackshadow\[at\]tclscripts.net"
set horoscop(versiune) "v1.4.1"
#/OBF

###
proc horoscop:setsign {nick host chan sign reset} {
	global horoscop
	set file [open $horoscop(user_file) "r"]
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set temp "sign_temp.$timestamp"
	set tempwrite [open $temp w]
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set enc_chan [encoding convertfrom utf-8 $read_chan]
	set read_host [lindex [split $line] 2]
if {[string equal -nocase $enc_chan $chan] && [string match -nocase $host $read_host]} {
	continue
	} else {
	puts $tempwrite $line
	}	
}
	close $tempwrite
	close $file
    file rename -force $temp $horoscop(user_file)
if {$reset == "0"} {
	set file [open $horoscop(user_file) a]
	puts $file "$chan $nick $host $sign"
	close $file
	}
}

###
proc horoscop:get {sign} {
	global horoscop
	set i 0
	set h ""
	set numbers ""
	set stats ""
	set pos [horoscop:get:pos $sign]
	set data [horoscop:getdata]
	set getjson [horoscop:getjson "data" $data]
	set line [lindex $getjson 3]
while {$i < 12} {
	set id [lindex $line $i]
	set z [lindex $id 7]
if {[regexp [subst -nocommands -nobackslashes {((.*)RO$pos)}] $id]} {
	set numbers [lindex $id 9]
	set stats [lindex $id 11]
	set h $z
	break
		}
	incr i
	}
	return [list $h $numbers $stats]
}

###
proc horoscop:get:pos {sign} {
	global horoscop
switch [string tolower $sign] {
	berbec {
	return "1"
	}
	taur {
	return "2"
	}
	gemeni {
	return "3"
	}
	rac {
	return "4"
	}
	leu {
	return "5"
	}
	fecioara {
	return "6"
	}
	balanta {
	return "7"
	}
	scorpion {
	return "8"
	}
	sagetator {
	return "9"
	}
	capricorn {
	return "10"
	}
	varsator {
	return "11"
	}
	pesti {
	return "12"
		}
	}	
}

###
proc horoscop:getjson {get data} {
	global horoscop
	set parse [::json::json2dict $data]
	set return ""
foreach {name info} $parse {
if {[string equal -nocase $name $get]} {
	set return $info
	break;
		}
	}
	return $return
}

#OBF
proc horoscop:getdata {} {
	global horoscop
	set link "http://www.tclscripts.tk/horoscop/"
	set ipq [http::config -useragent "lynx"]
	set ipq [::http::geturl "$link" -timeout 50000] 
	set data [http::data $ipq]
	::http::cleanup $ipq
	return $data
}
#/OBF

###
proc horoscop:flood:prot {chan host} {
	global horoscop
	set number [scan $horoscop(flood_prot) %\[^:\]]
	set timer [scan $horoscop(flood_prot) %*\[^:\]:%s]
if {[info exists horoscop(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*horoscop:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists horoscop(flood:$host:$chan)]} { 
	set horoscop(flood:$host:$chan) 0 
}
	incr horoscop(flood:$host:$chan)
	utimer $timer [list horoscop:remove:flood $host $chan]	
if {$horoscop(flood:$host:$chan) > $number} {
	set horoscop(flood:$host:$chan:act) 1
	utimer [expr $horoscop(ignore_prot) * 60] [list horoscop:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}

###
proc horoscop:remove:flood {host chan} {
	global horoscop
if {[info exists horoscop(flood:$host:$chan)]} {
	unset horoscop(flood:$host:$chan)
	}
}

###
proc horoscop:expire:flood {host chan} {
	global horoscop
if {[info exists horoscop(flood:$host:$chan:act)]} {
	unset horoscop(flood:$host:$chan:act)
	}
}

###
proc horoscop:get:flood_time {host chan} {
	global horoscop
		foreach tmr [utimers] {
if {[string match "*horoscop:expire:flood $host $chan*" [join [lindex $tmr 1]]]} {
	return [lindex $tmr 0]
		}
	}
}

###
proc horoscop:wrap {str {len 100} {splitChr { }}} { 
   set out [set cur {}]; set i 0 
   foreach word [split [set str][unset str] $splitChr] { 
     if {[incr i [string len $word]]>$len} { 
         lappend out [join $cur $splitChr] 
         set cur [list $word] 
         set i [string len $word] 
      } { 
         lappend cur $word 
      } 
      incr i 
   } 
   lappend out [join $cur $splitChr] 
}

###
#Texte
set black(horoscop.ro.help) "Comenzi: \002\[%msg.1%zodie\]\002 \[?|help\] ; \002\[%msg.1%zodie\] set\002 <zodie> ; \002\[%msg.1%zodie\] reset\002 ; \002%msg.1%zodie\002 \[zodie|nick\] ; \002%msg.1%noroc\002 \[zodie|nick\] ; \002%msg.1%horoscop\002 version"
set black(horoscop.ro.2) "\002%msg.1%\002, zodia ta implicita a fost setata ca:\002 %msg.2%\002."
set black(horoscop.ro.3) "\002%msg.1%\002, nu ai o zodie setata. Foloseste:\002 \[%msg.2%zodie\] set <zodie>\002 pentru a seta una."
set black(horoscop.ro.4) "\002%msg.1%\002, zodia ta implicita a fost resetata."
set black(horoscop.ro.5) "\002%msg.1%\002,\002 %msg.2%\002 nu reprezinta o zodie."
set black(horoscop.ro.11) "\002%msg.1%\002 nu are setata o zodie.."
set black(horoscop.ro.13) "\002%msg.1%\002: Trimiti cereri prea repede. Calmeaza-te si incearca din nou dupa \002%msg.2% secunde\002. Multumesc!"
set black(horoscop.ro.version) "\002$horoscop(numeProiect) $horoscop(versiune)\002 creat de\002 $horoscop(autor)\002 ($horoscop(email)) --\002 $horoscop(website)\002. PRIVATE TCL available only on donations."

putlog "\002$horoscop(numeProiect) $horoscop(versiune)\002 coded by\002 $horoscop(autor)\002 ($horoscop(website)): Loaded & initialised.."

#######################
#######################################################################################################
###                  *** SFARSIT BlackHoroscop RO TCL ***                                           ###
#######################################################################################################
