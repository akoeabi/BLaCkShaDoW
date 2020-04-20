###########################################################################################
## CountryInfo.tcl 1.0  (15/04/2020)  		  Copyright 2008 - 2020 @ WwW.TCLScripts.NET ##
##                   _   _   _   _   _   _   _   _   _   _   _   _   _   _               ##
##                  / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \              ##
##                 ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )             ##
##                  \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/              ##
##                                                                                       ##
##                               ® BLaCkShaDoW Production ®                    	         ##
##                                                                                       ##
##                                         PRESENTS                                      ##
##									                    ®                                ##
#####################################  CountryInfo TCL   ##################################
##									                             						 ##
##  DESCRIPTION: 							                             				 ##
##  Shows some info of the world countries (capital, currencies, population, etc).       ##
##  Also records countries from users joining your channel and makes a top list.         ##
##			                            						     					 ##
##  Tested on Eggdrop v1.8.4 (Debian Linux 3.16.0-4-amd64) Tcl version: 8.6.10           ##
##									                             						 ##
###########################################################################################
##  		  _____        _____        _____                                            ##
##  		 /     \      /     \      /     \                                           ##
##  		<   RO  >----<   IT  >----<  UK   >                                          ##
##  		 \_____/      \_____/      \_____/                                           ##
##  		 /     \ DE   /     \   NL /     \                Where liberty is,          ##
##  		<  ES   >----<  USA  >----<  FR   >----.              there is my country.   ##
##   		 \_____/      \_____/      \_____/      \                                    ##
##       		   \  RU  /     \  GR  /     \   CH /                                    ##
##                  >----<   SE  >----<  BE   >----<                                     ##
##                 /      \_____/      \_____/      \_____                               ##
##                 \  AU  /     \  UA  /     \  HU  /     \                              ##
##                  `----<  DK   >----<  SK   >----<  AL   >                             ##
##                        \_____/      \_____/      \_____/                              ##
##                                     /     \  NO  /                                    ##
##                                    <  BG   >----'                                     ##
##                                     \_____/                                           ##
##									                                                     ##
###########################################################################################
##									                             						 ##
##  INSTALLATION: 							                             				 ##
##     ++ http package is REQUIRED for this script to work.                           	 ##
##     ++ tls package is REQUIRED for this script to work. (1.7.18-2 or later)           ##
##									                             						 ##
## *** TIPS                                                                              ##
## * https://ubuntu.pkgs.org/19.10/ubuntu-universe-amd64/tcl-tls_1.7.18-2_amd64.deb.html ##
##   or                                                                                  ##
##   wget https://core.tcl-lang.org/tcltls/uv/tcltls-1.7.20.tar.gz                       ##
##   tar -xzf tcltls-1.7.20.tar.gz                                                       ##
##   cd tcltls-1.7.20                                                                    ##
##   ./configure                                                                         ##
##   make (as superuser - root)                                                          ##
##   make install                                                                        ##
##   That's it. Restart your bot.                                                        ##
##									                             						 ##
##     ++ Edit the CountryInfo.tcl script and place it into your /scripts directory,     ##
##     ++ add "source scripts/CountryInfo.tcl" to your eggdrop config and rehash the bot.##
##									                             						 ##
###########################################################################################
###########################################################################################
##									                                                     ##
##  OFFICIAL LINKS:                                                                      ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                                         ##
##   Bugs report : http://www.tclscripts.net                                             ##
##   GitHub page : https://github.com/tclscripts/ 			                             ##
##   Online help : irc://irc.undernet.org/tcl-help                                       ##
##                 #TCL-HELP / UnderNet        	                                         ##
##                 You can ask in english or romanian                                    ##
##									                                                     ##
##     paypal.me/DanielVoipan = Please consider a donation. Thanks!                      ##
##									                                                     ##
###########################################################################################
##									                             						 ##
##              You want a customised TCL Script for your eggdrop?                       ##
##                   Easy-peasy, just tell us what you need!                             ##
##       We can create almost anything in TCL based on your ideas and donations.         ##
##          Email blackshadow@tclscripts.net or info@tclscripts.net with your            ##
##           request informations and we'll contact you as soon as possible.             ##
##									                             						 ##
###########################################################################################
##											             								 ##
##  To activate: .chanset +country.info | from BlackTools: .set #channel +country.info   ##
##												     									 ##
##  Commmands: !c [country name/ country code]          								 ##
##												     									 ##
##  .chanset +country.save | from BlackTools: .set #channel +country.save                ##
##												     									 ##
##  Commmands: !c stats  - shows a stats of countries from users joining your channel.   ##
##												     									 ##
###########################################################################################
##									                             						 ##
##  LICENSE:                                                                             ##
##   This code comes with ABSOLUTELY NO WARRANTY.                                        ##
##                                                                                       ##
##   This program is free software; you can redistribute it and/or modify it under       ##
##   the terms of the GNU General Public License version 3 as published by the           ##
##   Free Software Foundation.          												 ##
##                                                                                       ##
##   This program is distributed WITHOUT ANY WARRANTY; without even the implied          ##
##   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    ##
##   USE AT YOUR OWN RISK.                                                               ##
##                                                                                       ##
##   See the GNU General Public License for more details.                                ##
##        (http://www.gnu.org/copyleft/library.txt)                                      ##
##                                                                                       ##
##  			          Copyright 2008 - 2018 @ WwW.TCLScripts.NET                     ##
##                                                                                       ##
###########################################################################################

###########################################################################################
##                            CONFIGURATION FOR CountryInfo.TCL                          ##
###########################################################################################

##
#Default flgs for command usage
set country(default_flags) "-|-"

##
#Default script language (EN/RO)
set country(default_lang) "EN"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders
###
set country(ignore_prot) "1"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 4:10, which allows for upto 3 queries in 10 seconds. 4 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set country(flood_prot) "3:10"

###
# CHAN JOIN FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 4:10, which allows for upto 3 queries in 10 seconds. 4 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set country(join_flood_prot) "3:5"

###
#Webchat hosts (it will take the ident and translated in IP)
set country(webchat_hosts) {
"*.mibbit.com"
"*.kiwiirc.com"
"64.62.228.82"
"207.192.75.252"
"78.129.202.38"
"109.169.29.95"
"87.98.219.117"
"78.129.190.63"
"107.161.19.10"
"107.161.19.53"
"109.169.31.4"
}

##
#Excepted hosts for country checking
set country(webchat_excepted_hosts) {
"*.users.undernet.org"
"undernet.org"
"192.168.*"
"10.0.*"
"10.1.*"
"10.101.*"
"172.29.7.*"
}

###########################################################################################
###             DO NOT MODIFY HERE UNLESS YOU KNOW WHAT YOU'RE DOING                    ###
###########################################################################################

package require http
package require tls

###
# Bindings
# - using commands
###
bind pub $country(default_flags) !country restcountry:cmd
bind pub $country(default_flags) !c restcountry:cmd
bind join - * restcountry:join_save
bind time - "00 00 * * *" restcountry:reset

###
# Channel flags
setudef flag country.info
setudef flag country.save
set country(file_save) "countries.save"

###
if {![file exists $country(file_save)]} {
	set file [open $country(file_save) w]
	close $file
}

###
proc restcountry:reset {minute hour day month year} {
	global country
	set week_reset 0
	set general_reset 0
if {[clock format [clock seconds] -format "%w"] == 0} {
	set week_reset 1
}
if {[clock format [clock seconds] -format "%e"] == 1} {
if {![info exists country(general_reseted)]} {
	set general_reset 1
	set country(general_reseted) 1
	}
} elseif {[info exists country(general_reseted)]} {
	unset country(general_reseted)
}
if {$general_reset == "1"} {
	restcountry:reset_now 2
	return
}
if {$week_reset == "1"} {
	restcountry:reset_now 1
	return
	}
	restcountry:reset_now 0
}

###
proc restcountry:reset_now {type} {
	global country
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set temp "$country(file_save).new.$timestamp"
	set tempwrite [open $temp w]
	set file [open $country(file_save) r]
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set read_gen [lindex [split $line] 1]
	set read_month [lindex [split $line] 2]
	set read_week [lindex [split $line] 3]
	set read_day [lindex [split $line] 4]
	set read_time [lindex [split $line] 5]
	set read_country [lrange [split $line] 6 end]
switch $type  {
	0 {
	puts $tempwrite "$read_chan $read_gen $read_month $read_week 0 $read_time $read_country"
	}
	
	1 {
	puts $tempwrite "$read_chan $read_gen $read_month 0 0 $read_time $read_country"
	}

	2 {
	puts $tempwrite "$read_chan $read_gen 0 0 0 $read_time $read_country"
			}
		}
	}	 
	close $file
	close $tempwrite
	file rename -force $temp $country(file_save)
}

###
proc restcountry:checkident {ident} {
	global country
	set userip 0
	set hexre {^[^0-9a-f]?([0-9a-f]{8})$}
if {[regexp -nocase $hexre $ident]} {
	regexp -nocase $hexre $ident -> hexip
	set hexipre {^(..)(..)(..)(..)$}
	regexp -nocase $hexipre $hexip -> hexip1 hexip2 hexip3 hexip4
	scan $hexip1 %x decip1
	scan $hexip2 %x decip2
	scan $hexip3 %x decip3
	scan $hexip4 %x decip4
	set userip "$decip1.$decip2.$decip3.$decip4"
 	}
	return $userip
}

###
proc restcountry:join_save {nick host hand chan} {
	global country
if {![channel get $chan country.save]} {
	return
}
	set flood_protect [restcountry:joinflood:prot $chan]
if {$flood_protect == "1"} {
	return
}
	set hostname [lindex [split $host @] 1]
	set ident [string map {"~" ""} [lindex [split $host "@"] 0]]
	set excepted_host 0
foreach exhost $country(webchat_excepted_hosts) {
if {[string match -nocase $exhost $hostname]} {
	set excepted_host 1
	}
}
if {$excepted_host == "1"} { return }

foreach whost $country(webchat_hosts) {
if {[string match -nocase $whost $hostname]} {
	set hostname [restcountry:checkident $ident]
	break
	}
}
if {$hostname == 0} {
	set hostname [lindex [split $host @] 1]
	}
	set read_country [restcountry:data $hostname]
	set exists [restcountry:entry_exists $chan $read_country]
	set unixtime [unixtime]
if {$exists == "-1"} {
	set file [open $country(file_save) a]
	puts $file "$chan 1 1 1 1 $unixtime $read_country"
	close $file
} else {
	restcountry:entry_update $exists
	}
}

###
proc restcountry:entry_update {entry} {
	global country
	set get_chan [lindex $entry 0]
	set get_gen [lindex $entry 1]
	set get_month [lindex $entry 2]
	set get_week [lindex $entry 3]
	set get_day [lindex $entry 4]
	set get_country [lrange $entry 6 end]
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set temp "$country(file_save).new.$timestamp"
	set tempwrite [open $temp w]
	set file [open $country(file_save) r]
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set read_country [join [lrange [split $line] 6 end]]
if {[string equal -nocase $get_chan $read_chan] && [string equal -nocase $get_country $read_country]} {
	continue
} else {
	puts $tempwrite $line
	}	 
}
	close $file
	incr get_gen
	incr get_month
	incr get_week
	incr get_day
	puts $tempwrite "$get_chan $get_gen $get_month $get_week $get_day [unixtime] $get_country"
	close $tempwrite
	file rename -force $temp $country(file_save)
}

###
proc restcountry:entry_exists {chan c} {
	global country
	set found_line -1
	set file [open $country(file_save) r]
while {[gets $file line] != -1} {
if {[regexp -nocase "$chan (.*) $c" $line]} {
	set found_line $line
	break
	}
}
	close $file
	return $found_line
}

###
proc restcountry:data {ip} {
	global black
	set link "http://ip-api.com/json/$ip?fields=country"
	set ipq [http::config -useragent "lynx"]
	set ipq [::http::geturl $link -timeout 5000]
	set status [::http::status $ipq]
	set get_country ""
if {$status != "ok"} { return 0 }
	set data [join [http::data $ipq]]
	::http::cleanup $ipq
	set split_data [split $data ":"]
	regexp -nocase {"country":(.*)} $data -> get_country
if {$get_country != ""} {
	return [string map {"\"" ""} $get_country]
	} else { return 0 }
}

###
proc restcountry:wrap {str {len 100} {splitChr { }}} { 
   set out [set cur {}]; set i 0 
   foreach word [split [set str][unset str] $splitChr] { 
     if {[incr i [string len $word]]>$len} { 
         lappend out [join $cur $splitChr]
         set cur [list [encoding convertfrom utf-8 $word]] 
         set i [string len $word] 
      } { 
         lappend cur $word 
      } 
      incr i 
   } 
   lappend out [join $cur $splitChr] 
}

###
proc restcountry:list {nick chan} {
	global country
	set file [open $country(file_save) r]
	array set clist [list]
	set lang [string tolower $country(default_lang)]
	set output_list $country(lang.$lang.6)
	set inc 0
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
if {[string equal -nocase $chan $read_chan]} {
	set read_total [lindex [split $line] 1]
	set read_month [lindex [split $line] 2]
	set read_week [lindex [split $line] 3]
	set read_day [lindex [split $line] 4]
	set read_country [lrange [split $line] 6 end]
	lappend clist($read_total) [list $read_total $read_month $read_week $read_day $read_country]
		}
	}
if {[array size clist] == "0"} {
	return -1
	}
foreach c [lsort -integer -decreasing [array names clist]] {
	incr inc
	set countries ""
	set read_total ""
	set read_month ""
	set read_week ""
	set read_day ""
	set read_country ""
foreach cs $clist($c) {
	set read_total [lindex $cs 0]
	set read_month [lindex $cs 1]
	set read_week [lindex $cs 2]
	set read_day [lindex $cs 3]
	set read_country [lindex $cs 4]
	lappend countries $read_country
}
	lappend output "\002\#$inc\002. [join $countries ", "] $read_total\/$read_month\/$read_week\/$read_day"
	}
	set text "$output_list [join $output ", "]"
foreach line [restcountry:wrap $text 450] {
	putserv "PRIVMSG $chan :$line"	
	}
}

###
proc restcountry:cmd {nick host hand chan arg} {
	global country
if {![channel get $chan country.info]} {
	return
}
	set flood_protect [restcountry:flood:prot $chan $host]
	set lang [string tolower $country(default_lang)]
	set c [join [lrange [split $arg] 0 end]]
if {$flood_protect == "1"} {
	set get_seconds [restcountry:get:flood_time $host $chan]
	set replace(%seconds%) $get_seconds
	set reply [string map [array get replace] $country(lang.$lang.5)]
	puthelp "NOTICE $nick :$reply"
	return
}
if {[string equal -nocase $c "stats"]} {
	set items [restcountry:list $nick $chan]
if {$items == "-1"} {
	puthelp "NOTICE $nick :$country(lang.$lang.7)"
	return
}
	return
}
	set llength_c [string length $c]
switch $llength_c {
	0 {
	puthelp "NOTICE $nick :$country(lang.$lang.4)"
	return
	}
	1 {
	puthelp "NOTICE $nick :$country(lang.$lang.4)"
	return
	}
	2 {
	set status [restcountry:getinfo $nick $chan $c 0 ""]
if {$status == "0"} {
	puthelp "NOTICE $nick :$country(lang.$lang.2)"
	return
		}
	}
	3 {
	set status [restcountry:getinfo $nick $chan $c 0 ""]
if {$status == "0"} {
	puthelp "NOTICE $nick :$country(lang.$lang.2)"
	return
		}
	}
	default {
	set country_search [join $c "%20"]
	restcountry:getinfo $nick $chan $country_search 1 $c
		}
	}
}

###
proc restcountry:getfullname_borders {code} {
	global country
	set split_codes [split $code ","]
	set code [string map {"," ";"} $code]
	set link "https://restcountries.eu/rest/v2/alpha?codes=$code"
  	set http [::http::config -useragent "lynx"]
	http::register https 443 [list ::tls::socket -autoservername true]
	set ipq [::http::geturl $link -timeout 5000]
	set status [::http::status $ipq]
if {$status != "ok"} {
	return $status
}
	set data [http::data $ipq]
	::http::cleanup $ipq
	set split_data [split $data ","]
	set country_names ""
	set inc 0
foreach line $split_data {
	set name ""
if {[regexp {\{"name":(.*)} $line -> name]} {
	regsub {,"topLevelDomain"(.*)} $name "" name
if {$name != ""} {
	set c [lindex $split_codes $inc]
	lappend country_names "[restcountry:text $name] ($c)"
	incr inc
	continue	
			}
		}
	}
	return [join $country_names ", "]
}

###
proc restcountry:remove_trailing {text} {
	set return ""
	set zero [lindex [split $text "."] 1]
if {$zero == "0"} {
	set return [lindex [split $text "."] 0]
	} else { set return $text }
	return $return
}

###
proc restcountry:getinfo {nick chan arg type country_searched} {
	global country
switch $type {
	0 {
	set link "https://restcountries.eu/rest/v2/alpha/$arg"	
	}
	1 {
	set link "https://restcountries.eu/rest/v2/name/$arg"
	}
}
	set supper_utf8 "&#178"
  	set http [::http::config -useragent "lynx"]
	http::register https 443 [list ::tls::socket -autoservername true]
	set ipq [::http::geturl $link -timeout 5000]
	set status [::http::status $ipq]
	set lang [string tolower $country(default_lang)]
if {$status != "ok"} {
	return 0
}
	set data [http::data $ipq]
	::http::cleanup $ipq
if {[string match "*Not Found*" $data]} {
	set replace(%country%) $country_searched
	set reply [string map [array get replace] $country(lang.$lang.1)]
	puthelp "NOTICE $nick :$reply"
	return
}
	regexp {"name":(.*)} $data -> name
	regsub -all {,"topLevelDomain"(.*)} $name "" name

	regexp {"alpha3Code":(.*)} $data -> alpha3Code
	regsub -all {,"callingCodes"(.*)} $alpha3Code "" alpha3Code

	regexp {"area":(.*)} $data -> area
	regsub -all {,"gini"(.*)} $area "" area

	regexp {"region":(.*)} $data -> region
	regsub -all {,"subregion"(.*)} $region "" region

	regexp {"subregion":(.*)} $data -> subregion
	regsub -all {,"population"(.*)} $subregion "" subregion

	regexp {"population":(.*)} $data -> population
	regsub -all {,"latlng"(.*)} $population "" population

	regexp {"languages":(.*)} $data -> languages
	regsub -all {,"translations"(.*)} $languages "" languages
	
	regexp {"capital":(.*)} $data -> capital
	regsub -all {,"altSpellings"(.*)} $capital "" capital

	regexp {"topLevelDomain":(.*)} $data -> topLevelDomain
	regsub -all {,"alpha2Code"(.*)} $topLevelDomain "" topLevelDomain
  
	regexp {"currencies":(.*)} $data -> currencies
	regsub -all {,"languages"(.*)} $currencies "" currencies

	regexp {"nativeName":(.*)} $data -> nativeName
	regsub -all {,"numericCode"(.*)} $nativeName "" nativeName

	regexp {"borders":(.*)} $data -> borders
	regsub -all {,"nativeName"(.*)} $borders "" borders
	regexp {"timezones":(.*)} $data -> timezones
	regsub -all {,"borders"(.*)} $timezones "" timezones

	set country_name [restcountry:text $name]
	set replace(%country%) $country_name
	set nativeName [restcountry:text [join $nativeName]]
	set replace(%nativeName%) $nativeName
	set capital [restcountry:text $capital]
if {$capital == ""} { set capital "N/A" }
	set replace(%capital%) $capital
	set region [restcountry:text $region]
	set replace(%region%) $region
	set subregion [restcountry:text $subregion]
	set replace(%subregion%) $subregion
	set population [restcountry:commify [restcountry:text $population]]
	set replace(%population%) $population
	set alpha3Code [restcountry:text $alpha3Code]
	set replace(%alpha3Code%) $alpha3Code
	set languages [restcountry:text $languages]
	regexp {iso639_1:(.*)} $languages -> language_iso
	regsub -all {,iso639_2(.*)} $language_iso "" language_iso
	regexp {name:(.*)} $languages -> language_name
	regsub -all {,nativeName(.*)} $language_name "" language_name
	set replace(%languages%) "$language_name ($language_iso)"
	set currencies [join [restcountry:text $currencies]]
	regexp {symbol:(.*)} $currencies -> currency_simbol
	regexp {code:(.*)} $currencies -> currency_code
	regsub -all {,name(.*)} $currency_code "" currency_code
	set replace(%currencies%) "$currency_simbol ($currency_code)"
	set area [restcountry:remove_trailing [restcountry:text $area]]
if {$area != "null"} {
if {[string equal -nocase $country(default_lang) "EN"]} {
	set area [restcountry:commify [lindex [split [expr $area * "0.386102"] "."] 0]]
} else {
	set area [restcountry:commify $area]
	}
} else {
	set area "-"
}
	set replace(%area%) $area
	set timezones [restcountry:text $timezones]
	set replace(%timezones%) $timezones
	set borders [restcountry:getfullname_borders [restcountry:text $borders]]
if {[llength $borders] == "0"} { set borders "N/A" }
	set replace(%borders%) $borders
	set topLevelDomain [restcountry:text $topLevelDomain]
	set replace(%topLevelDomain%) $topLevelDomain
	set supper [restcountry:supper $supper_utf8]
	set replace(%supper%) $supper
	set reply [string map [array get replace] $country(lang.$lang.3)]
foreach line [restcountry:wordwrap $reply 450 ";"] {
	putserv "PRIVMSG $chan :$line"
	}
}

###
# Credits
set restcountry(projectName) "Country Info"
set restcountry(author) "BLaCkShaDoW & skew"
set restcountry(website) "wWw.TCLScriptS.NeT"
set restcountry(email) "info\[at\]tclscripts.net"
set restcountry(version) "v1.0"

###
proc restcountry:joinflood:prot {chan} {
	global country
	set number [scan $country(join_flood_prot) %\[^:\]]
	set timer [scan $country(join_flood_prot) %*\[^:\]:%s]
if {[info exists country(flood:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*restcountry:remove:joinflood $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists country(flood:$chan)]} { 
	set country(flood:$chan) 0 
}
	incr country(flood:$chan)
	utimer $timer [list restcountry:remove:joinflood $chan]	
if {$country(flood:$chan) > $number} {
	set country(flood:$chan:act) 1
	utimer [expr $country(ignore_prot) * 60] [list restcountry:expire:joinflood $chan]
	return 1
	} else {
	return 0
	}
}

###
proc restcountry:expire:joinflood {chan} {
	global country
if {[info exists country(flood:$chan:act)]} {
	unset country(flood:$chan:act)
	}
}

###
proc restcountry:remove:joinflood {chan} {
	global country
if {[info exists country(flood:$chan)]} {
	unset country(flood:$chan)
	}
}

###
proc restcountry:flood:prot {chan host} {
	global country
	set number [scan $country(flood_prot) %\[^:\]]
	set timer [scan $country(flood_prot) %*\[^:\]:%s]
if {[info exists country(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*restcountry:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists country(flood:$host:$chan)]} { 
	set country(flood:$host:$chan) 0 
}
	incr country(flood:$host:$chan)
	utimer $timer [list restcountry:remove:flood $host $chan]	
if {$country(flood:$host:$chan) > $number} {
	set country(flood:$host:$chan:act) 1
	utimer [expr $country(ignore_prot) * 60] [list restcountry:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}

###
proc restcountry:expire:flood {host chan} {
	global country
if {[info exists country(flood:$host:$chan:act)]} {
	unset country(flood:$host:$chan:act)
	}
}

###
proc restcountry:remove:flood {host chan} {
	global country
if {[info exists country(flood:$host:$chan)]} {
	unset country(flood:$host:$chan)
	}
}

###
proc restcountry:get:flood_time {host chan} {
	global country
		foreach tmr [utimers] {
if {[string match "*restcountry:expire:flood $host $chan*" [join [lindex $tmr 1]]]} {
	return [lindex $tmr 0]
		}
	}
}

###
proc restcountry:text {text} {
	global country
	set text [string map {"\[" ""
				"\]" ""
				"\"" ""
					} $text]
	return [encoding convertfrom "utf-8" $text]
}

###
proc restcountry:wordwrap {str {len 100} {splitChr { }}} { 
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
proc restcountry:supper {string} {
    set map {}
    foreach {entity number} [regexp -all -inline {&#(\d+)} $string] {
        lappend map $entity [format \\u%04x [scan $number %d]]
    }
    	set string [string map [subst -nocomm -novar $map] $string]
	return $string
}

###
#http://wiki.tcl.tk/5000
proc restcountry:fixpoint {varName script} {
    upvar 1 $varName arg
    while {[set res [uplevel 1 $script]] ne $arg} {
        set arg $res
    }
    return $arg
}

###
proc restcountry:commify {num {sep ,}} {
    restcountry:fixpoint num {
        regsub {^([-+]?\d+)(\d\d\d)} $num "\\1$sep\\2"
    }
}

###
# Languages

# Romanian
set country(lang.ro.1) "Nu am gasit \"%country%\""
set country(lang.ro.2) "Eroare. Nu am putut prelua nicio informatie. Incearca te rog mai tarziu.."
set country(lang.ro.3) "\002Tara\002: %country% ; \002Nume nativ\002: %nativeName% (%alpha3Code%); \002Capitala\002: %capital% ; \002TLD\002: %topLevelDomain% ; \002Arie\002: %area% km%supper% ; \002Continent\002: %region% (%subregion%) ; \002Populatie\002: %population% ; \002Limba\002: %languages% ; \002Moneda\002: %currencies% ; \002Frontiere\002: %borders% ; \002Fus orar\002: %timezones%."
set country(lang.ro.4) "Eroare. Foloseste: \002!country\002 \[nume tara/cod2tara/cod3tara\]"
set country(lang.ro.5) "Ai depasit numarul de comenzi. Te rog asteapta \002%seconds%\002 secunde.."
set country(lang.ro.6) "\002Statistici\002 Tari \[Total\/Luna\/Saptamana\/Zi\]"
set country(lang.ro.7) "Nu exista statistici inca.."

# English
set country(lang.en.1) "Didn't found \"%country%\""
set country(lang.en.2) "Error. Could not retrieve information, try again later.."
set country(lang.en.3) "\002Country\002: %country% ; \002Native name\002: %nativeName% (%alpha3Code%) ; \002Capital\002: %capital% ; \002TLD\002: %topLevelDomain% ; \002Area\002: %area% mi%supper% ; \002Continent\002: %region% (%subregion%) ; \002Population\002: %population% ; \002Languages\002: %languages% ; \002Currencies\002: %currencies% ; \002Borders\002: %borders% ; \002TimeZone\002: %timezones%."
set country(lang.en.4) "Error. Use: \002!country\002 \[country name/cod2tara/cod3tara\]"
set country(lang.en.5) "You excedeed the number of commands. Please wait \002%seconds%\002 seconds.."
set country(lang.en.6) "Country \002Stats\002 \[Total\/Month\/Week\/Day\]"
set country(lang.en.7) "No countries stats yet.."

putlog "\002$restcountry(projectName) $restcountry(version)\002 by\002 $restcountry(author)\002 ($restcountry(website)): Loaded & initialized.."

###########################################################################################
## CountryInfo.tcl 1.0  (15/04/2020)      	  Copyright 2008 - 2020 @ WwW.TCLScripts.NET ##
###########################################################################################
###                  *** THE END ***                                		            ###
###########################################################################################
