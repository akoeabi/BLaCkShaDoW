# Count TcL vers. 1.0
#
#                               BLaCkShaDoW Productions @ #TcL-HeLP
#######################################################################



########################################################################
# Count TCL
#TCL pentru o numarare a userilor care intra pe chan, poate fii activat #pentru orice canal folosind comenzile de mai jos, simplu si usor:D
#Daca setati on , va incepe numaratoarea, dar daca setati off #numaratoarea se va reseta, aceasta incepand de la 0 la urmatoarea #activare
#Folositi pentru activare doar comenzile afisate de mine :P
#Mesajul il puteti edita , este printre ultimile linii
#
#######################################################################

########################################################################
#Pentru activare folositi : !count on
#Pentru dezactivare folositi : !count off
#Pentru a vedea statutul comenzii folositi : !count status
#Pentru a vedea numarul de join-uri !count display
#Desigur numarul de vizitatori va fii afisat si ca greet la join
#######################################################################

########################################################################
#Aici setati caracterul de inceput al comenzii
set count(char) "!"
#######################################################################

########################################################################
#Aici puteti seta ce nivel va putea utiliza comanda
set count(flag) "nm|M"
#######################################################################
set vers "1.0"
set Autor "BLaCkShaDoW"


bind pub $count(flag) $count(char)count pub:count
setudef flag count
proc pub:count {nick host hand chan arg} {
global count
set why [lindex $arg 0]
if {$why == ""} { puthelp "NOTICE $nick :Foloseste $count(char)count on / off / status / display"
return 0
}
if { [channel get $chan count] } { set countstat "on" } else { set countstat "off"}
if {($countstat == "on") && ($why == "on")} { puthelp "NOTICE $nick :Count pentru $chan este deja activat"
return 0
}
if {($countstat == "off") && ($why == "off")} { puthelp "NOTICE $nick :Count pentru $chan este deja dezactivat"
return 0
}

if {([regexp -nocase -- {(#[0-9]+|on|off|status|display)} $why tmp counter]) && (![regexp -nocase -- {\S#} $why])} {
    switch $counter {

on {
channel set $chan +count
set counting [open count($chan).txt w]
puts $counting "0"
close $counting

puthelp "NOTICE $nick :Am activat count pentru $chan"
return 0
}

off {
channel set $chan -count
set counting [open count($chan).txt w]
puts $counting "0"
close $counting
puthelp "NOTICE $nick :Am dezactivat count pentru $chan"
return 0
}

status { 
puthelp "NOTICE $nick :Sistemul count pentru acest canal este : $countstat"
return 0
}
display {
set counting [open count($chan).txt r]
set counts "[gets $counting]"
catch {close $counting}
puthelp "NOTICE $nick :Numaratoarea de join-uri pentru $chan este : $counts"
return 0
}
}
} else { puthelp "NOTICE $nick :Foloseste $count(char)count on / off / status / display" 
return 0
}
}

bind join - "* *" countjoin
proc countjoin {nick host hand chan} {
global botnick count
if {[channel get $chan count]} {
set counting [open count($chan).txt r]
set counts "[gets $counting]"
catch {close $counting}
set countz [expr $counts + 1]
set counting [open count($chan).txt w]
puts $counting "$countz"
close $counting
putquick "NOTICE $nick :Esti user-ul cu numarul $countz care a intrat pe $chan"
return 0
} else { return 0 }
}

putlog "Counting TcL vers $vers by $Autor Loaded"
