########################################################################
#   BlackIdle TCL vers 1.0
#
#Acest TCL are grija ca cei cu idle mai mare sa nu stea cu OP sau VOICE
#Comenzile importante se seteaza pe irc dar, sunt si anumite setari de 
#configurat in TCL
#Lista cu comenzi o gasiti mai jos sau tastati pe canal !idle
#
#                                  BLaCkShaDoW ProductionS
#                             ---> The Next Generation TCL <----
#######################################################################

#Comenzi :
#!idle on (activezi sistemul general anti-idle) ( el trebuie activat primu)
#!idle off (dezactivezi sistemul anti-idle)
#!idle op <on>/<off> (dezactivezi sistemul anti-idle pt opi)
#!idle voice <on>/<off> (dezactivezi sistemul anti-idle pt voice)
#!idle status ( arata statulul modulelor de idle)
#!idle add <nume> <host> (adaugare exceptii pt anti-idle)
#!idle list (afisare exceptii)
#!idle del <nume> <host> (stergere exceptii pentru anti-idle)
#!idle op set <numar> (setezi timpu de idle care sa il aibe cel cu @ 
#pentru a primii deop)
#!idle voice set <numar> (setezi timpu de idle care sa il aibe cel cu 
#+ pentru a primii devoice


#Aici setezi caracterul de inceput al comenzii

set idle(char) "!"

#Aici setezi intervalu de timp la care sa faca checking (minute)

set idle(time) "10"

#Seteaza aici "1" daca vrei ca dupa idle-deop userul sa primeasca 
#statutul de + pe canal altfel seteaza "0"

set idle(tmp) "1"

#Seteaza aici "1" daca vrei ca userul la deop/devoice sa primeasca si 
#un mesaj pe privat altfel seteaza "0"

set idle(statmsg) "0"

#Daca ai setat mai sus "1" te rog seteaza aici mesajul care este dat la 
#cei care primesc deop

set idle(opmsg) "Ai primit deop deoarece ai avut prea mult idle"

#Daca ai setat mai sus "1" te rog seteaza aici mesajul care este dat la 
#cei care primesc devoice

set idle(voicemsg) "Ai primit devoice deoarece ai avut prea mult idle"

#Aici setezi cine poate folosii comanda

set idle(flag) "mn|M"


########################################################################
#
#                        Tha End Mothafucka
#
#######################################################################
set TheAutor "BLaCkShaDoW"
set TheVersion "1.0"
setudef flag noidle
setudef flag antividle
setudef flag antididle
setudef int opidle
setudef int voiceidle

bind pub $idle(flag) $idle(char)idle idles

proc idles {nick host hand chan arg} {
global idle
set why [lindex $arg 0]
set type [lindex $arg 1]
set number [lindex $arg 2]
set user [lindex $arg 1]
set host [lindex $arg 2]
set flag "-|H"
if {$arg == ""} { puthelp "NOTICE $nick :Foloseste : !idle <on>/<off> (activezi/dezactivezi sistemul anti-idle) | !idle op <on>/<off> | !idle voice <on>/<off> | !idle status | !idle op set <numar> (setezi idle maxim pt opi) | !idle voice set <numar> (setezi idle maxim pt voice) | !idle add <nume> <host> (adaugare exceptii) | !idle del <nume> (stergere exceptie) | !idle list (afisare exceptii)"
return 0
}

if {([regexp -nocase -- {(#[0-9]+|op|voice|set|status|add|del|list|on|off)} $why tmp idler]) && (![regexp -nocase -- {\S#} $why])} {
    switch $idler {

op {
 if {$type == ""} { puthelp "NOTICE $nick :FOloseste !idle op <on>/<off> | !idle op set <numar> (setezi max idle minute)"
return 0
}
if {$type == "on"} {
if {[channel get $chan noidle]} { set noidle "on" } else { set noidle "off"}
if {$noidle == "off"} { puthelp "NOTICE $nick :Intai activeaza sistemul anti-idle utilizand comanda !idle on"
return 0
}
set idletime [channel get $chan opidle]
if {$idletime == "0"} { puthelp "NOTICE $nick :Foloseste intai !idle op set <numar> pentru a seta idle maxim la care se va face deop (minute)"
return 0
}

channel set $chan +antididle
puthelp "NOTICE $nick :Am activat idle-deop pentru $chan"
}
if {$type == "off"} {
if {[channel get $chan noidle]} { set noidle "on" } else { set noidle "off"}
if {$noidle == "off"} { puthelp "NOTICE $nick :Intai activeaza sistemul anti-idle utilizand comanda !idle on"
return 0
}
channel set $chan -antididle
puthelp "NOTICE $nick :Am dezactivat idle-deop pentru $chan"
}

if {($type == "set") && ($number == "")} {
puthelp "NOTICE $nick :Foloseste !idle set op <number> (idle maxim) (in minute)"
return 0
}

if {$type == "set"} {
if {$number < "15"} { puthelp "NOTICE $nick :Te rog specifica un timp mai mare de 15 minute, pentru a evita ca eggul sa aibe lag"
return 0
}
channel set $chan opidle $number
puthelp "NOTICE $nick :Am setat idle maxim pentru opi la $number minute"
}
}

on {
 channel set $chan +noidle
puthelp "NOTICE $nick :Am activat sistemul anti-idle ! Pentru a devenii functional alege ce tip de anti-idle vrei : !idle op <on>/<off> | !idle voice <on/<off>"
}

off {
 channel set $chan -noidle
puthelp "NOTICE $nick :Am dezactivat sistemul anti-idle !"
}



voice {
 if {$type == ""} { puthelp "NOTICE $nick :FOloseste !idle voice <on>/<off>"
return 0
}

if {$type == "on"} {

if {[channel get $chan noidle]} { set noidle "on" } else { set noidle "off"}
if {$noidle == "off"} { puthelp "NOTICE $nick :Intai activeaza sistemul anti-idle utilizand comanda !idle on"
return 0
}
set idletime [channel get $chan voiceidle]
if {$idletime == "0"} { puthelp "NOTICE $nick :Foloseste intai !idle voice set <numar> pentru a seta idle maxim la care se va face devoice (minute)"
return 0
}


channel set $chan +antividle
puthelp "NOTICE $nick :Am activat idle-devoice pentru $chan"
}
if {$type == "off"} {
if {[channel get $chan noidle]} { set noidle "on" } else { set noidle "off"}
if {$noidle == "off"} { puthelp "NOTICE $nick :Intai activeaza sistemul anti-idle utilizand comanda !idle on"
return 0
}

channel set $chan -antividle
puthelp "NOTICE $nick :Am dezactivat idle-devoice pentru $chan"
}
if {($type == "set") && ($number == "")} {
puthelp "NOTICE $nick :Foloseste !idle set voice <number> (idle maxim) (in minute)"
return 0
}

if {$type == "set"} {
if {$number < "15"} { puthelp "NOTICE $nick :Te rog specifica un timp mai mare de 15 minute, pentru a evita ca eggul sa aibe lag"
return 0
}
channel set $chan voiceidle $number
puthelp "NOTICE $nick :Am setat idle maxim pentru voice la $number minute"
}
}

add {

if {$user == ""} { puthelp "NOTICE $nick :Foloseste !idle add <nume> <host>"
return 0
}

if {$host == ""} { puthelp "NOTICE $nick :Foloseste !idle add <nume> <host>"
return 0
}

if {[validuser $user]} { 
chattr $user $flag $chan
puthelp "NOTICE $nick :$user este deja in baza mea date..il adaug doar ca exceptie pentru modulul idle"
} else {
adduser $user $host
chattr $user $flag $chan
puthelp "NOTICE $nick :Am adaugat pe $user cu host $host ca exceptie pentru modulul idle"
}
}

del {
if {$user == ""} { puthelp "NOTICE $nick :Foloseste !idle del <nume>"
return 0
}
if {[validuser $user]} {
chattr $user -|-H $chan
puthelp "NOTICE $nick :Am sters pe $user din lista de exceptii pentru modulul idle"
} else { puthelp "NOTICE $nick :$user nu se afla in baza mea de date"
return 0
}
}

list {
set list [userlist $flag $chan]
puthelp "NOTICE $nick :Lista Useri Exceptii pentru anti-idle : $list"
}

status {

if {[channel get $chan antididle]} { set idledeop "ON" } else { set idledeop "OFF"}

if {[channel get $chan antividle]} { set idledevoice "ON" } else { set idledevoice "OFF"}

set idlev [channel get $chan voiceidle]
set idleo [channel get $chan opidle]

puthelp "NOTICE $nick :Idle-deop pentru $chan este $idledeop cu idle maxim de $idleo"
puthelp "NOTICE $nick :idle-Devoice pentru $chan este $idledevoice cu un idle maxim de $idlev"
}
}
}
}

bind raw - 317 idledevoice

proc idledevoice {nick int arg} {
  global edu botnick idle
   set nick [string tolower [lindex $arg 1]]
   set idler [string tolower [lindex $arg 2]]
   set handle [nick2hand $nick]
   set minutesidle [expr $idler / 60]
 foreach chans [channels] {
set idletime [channel get $chans voiceidle]
set reason "$idle(voicemsg) (Ai idle :$minutesidle | Maxim este :$idletime)"
 if {[channel get $chans antividle]} {
if {$idletime == "0" } { return 0 }
   if {$minutesidle > $idletime} {
if {[matchattr $handle -|H $chans]} { putlog "(BlackIdle) $nick is protected"
return 0
}
if {[isbotnick $nick]} { return 0 }
      dccbroadcast "(BlackIdle) $nick are prea mult idle (primeste devoice)"
         
        putserv "MODE $chans -v $nick"
         putlog "(BlackIdle) I-am dat devoice lu $nick de pe $chans deoarece are prea mult idle"
 if {$idle(statmsg) == "1"} {
  puthelp "PRIVMSG $nick :$reason"
 }
      }
    }
}
}


bind raw - 317 idleop

proc idleop {nick int arg} {
  global edu botnick idle
   set nick [string tolower [lindex $arg 1]]
   set idler [string tolower [lindex $arg 2]]
   set handle [nick2hand $nick]
   set minutesidle [expr $idler / 60]
 foreach chans [channels] {
set idletime [channel get $chans opidle]
set reason "$idle(opmsg) (Ai idle :$minutesidle | Maxim este :$idletime)"
 if {[channel get $chans antididle]} {
if {$idletime == "0" } { return 0 }
   if {$minutesidle > $idletime} {
if {[matchattr $handle -|H $chans]} { putlog "(BlackIdle) $nick is protected"
return 0
}
if {[isbotnick $nick]} { return 0 }
      dccbroadcast "(BlackIdle) $nick are prea mult idle (primeste deop)"
         
        putserv "MODE $chans -o $nick"
 if {$idle(tmp) == "1" } { putserv "MODE $chans +v $nick" }
         putlog "(BlackIdle) I-am dat deop lu $nick de pe $chans deoarece are prea mult idle"
 if {$idle(statmsg) == "1"} {
  puthelp "PRIVMSG $nick :$reason"
 }
      }
    }
}
}


proc blackwhois { } {
  global edu botnick idle
        foreach chan [channels] {
      if {[channel get $chan noidle]} {
       dccbroadcast "Caut pe $chan de idle.."
       foreach person [chanlist $chan] { 
         if {[isop $person $chan]} { 
             if {(![matchattr [nick2hand $person $chan] n|VOASM]) && ($person != $botnick)} { putserv "WHOIS $person $person" }
           }
        if {[isvoice $person $chan]} {
  if {(![matchattr [nick2hand $person $chan] n|VOASM]) && ($person != $botnick)} { putserv "WHOIS $person $person" }
}
                      }
         } 
       } 

if {![string match "*blackwhois*" [timers]]} {
 timer $idle(time) blackwhois
  }
}
if {![string match "*blackwhois*" [timers]]} {
 timer $idle(time) blackwhois
  }

putlog "BlackIdle TCL vers. $TheVersion by $TheAutor Loaded"




