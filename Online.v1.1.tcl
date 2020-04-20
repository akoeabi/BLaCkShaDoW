##########################################################################
#
# Online 1.1 TCL.
#
#!helper <on> | <off>
#
#
#- Script pentru canale de help ce va permite sa va setati statutul de ONLINE/OFFLINE
#- userii ce vor intra pe canal vor fii anuntati care membrii sunt ONLINE
#- daca uitati sa va treceti OFFLINE, botul va va trece automat OFFLINE
#daca aveti idle mai mare decat cel specificat in tcl.
#
#- NEW -
#- Acum scriptul va trece automat pe ONLINE user-ul daca acesta este gasit fara IDLE
#
#                                               BLaCkShaDoW ProductionS
##########################################################################

#Aici setezi canalul unde va functiona

set mainchan "#BlackTools"

#Aici setezi idle maxim pentru membrii

set maxidle "60"

#Aici setezi intervalul de timp in care sa scaneze.

set scantime "10"

#Aici setezi ce flaguri trebuie sa aibe userii pentru a fii trecuti
#in lista de admini si care pot folosii comanda publica

set admflags "nm|oMOAS"

##########################################################################
#
#
##########################################################################

bind pub $admflags !helper pub:helper
bind join - * helper:join


if {![info exists helper:check_running]} { 
timer $scantime helper:check
set helper:check_running 1
}

proc pub:helper {nick host hand chan arg} {
set cmd [lindex [split $arg] 0]
if {$cmd == ""} { puthelp "NOTICE $nick :Use !helper <on> | <off>"
return 0
}
switch -exact -- [string tolower $cmd] {

on {
puthelp "NOTICE $nick :Te-am setat ca ONLINE"
setuser $hand XTRA STATUS ON
}

off {
puthelp "NOTICE $nick :Te-am setat ca OFFLINE"
setuser $hand XTRA STATUS OFF
}
}
}

proc helper:join {nick host hand chan} {
global mainchan admflags
array set ontime [list]
if {[string match -nocase $chan $mainchan]} {
foreach user [chanlist $chan] {
if {![isbotnick $user]} {
set handle [nick2hand $user]
if {[matchattr $handle $admflags $chan]} {
set status [getuser $handle XTRA STATUS]
if {[string match -nocase $status "ON"]} {
lappend ontime($user) $handle
}
}
}
}

foreach nic [array names ontime] {
lappend list $nic
}
if {![info exists list]} {
lappend list "NONE"
}
puthelp "NOTICE $nick :1Bun venit"
puthelp "NOTICE $nick :12Membrii ONLINE: 4[join $list ", "]"
}
}


proc helper:check {} {
global mainchan scantime admflags
foreach chan [channels] {
if {[string match -nocase $chan $mainchan]} {
foreach user [chanlist $chan] { 
set handle [nick2hand $user]
if {![isbotnick $user]} {
if {[matchattr $handle $admflags $chan]} {
putserv "WHOIS $user $user"
}
}
}
}
}
putlog "Checking for helper status.."
timer $scantime helper:check
return 1
}

bind raw - 317 helper:idle

proc helper:idle {nick int arg} {
global maxidle mainchan admflags
set nick [string tolower [lindex $arg 1]]
set handle [nick2hand $nick]
set idler [string tolower [lindex $arg 2]]
set minutesidle [expr $idler / 60]
foreach chan [channels] {
if {[string match -nocase $chan $mainchan]} {
if {[matchattr $handle $admflags $chan]} {
if {$minutesidle > $maxidle} {
setuser $handle XTRA STATUS OFF
} else { setuser $handle XTRA STATUS ON }

}
}
}
}


putlog "Online 1.1 tcl by BLaCkShaDoW Loaded"


