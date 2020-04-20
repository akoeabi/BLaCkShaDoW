###########################################################################
#
#                                JoinCount TCL
#
#Numeroteaza join-urile la userii care se afla in baza de date a eggului
#si are access pe canalul respectiv unde se activeaza.
#
#Pentru vizualizare
#
#!joincount on/off
#!joincount show <user> ( arata join-urile la <user> )
#!joincount top ( arata topul cu cei care au access )
#
#                                             BLaCkShaDoW ProductionS
###########################################################################


#Aici setezi caracterul de inceput al comenzii

set joinc(char) "!"


#Aici setezi ce flaguri pot folosii comanda !joincount

set joinc(flags) "nm|OAVSMNom"


#Aici setezi ce flaguri sa aibe userii care vor fii numerotati in ceea
#ce privesc joinurile


set joinc(joinflags) "nmoN|OAVSMNom"

############################################################################
setudef flag joincount
bind join - * joinc
bind pub $joinc(flags) $joinc(char)joincount joincount

proc joinc {nick host hand chan} {
global joinc
if {[channel get $chan joincount]} {
if {[matchattr $hand $joinc(joinflags) $chan]} {
set countz [getuser $hand XTRA joins($chan)]
if {$countz == ""} { set countz 0 }
set counts [expr $countz + 1]
setuser $hand XTRA joins($chan) $counts
}
}
}


proc joincount {nick host hand chan arg} {
global joinc
set why [lindex [split $arg] 0]
set user [lindex [split $arg] 1]
set flag "joincount"
if {($why == "") && [matchattr $hand nm|MN $chan] } { puthelp "NOTICE $nick :Use $joinc(char)joincount <on/off> | $joinc(char)joincount show <user> | $joinc(char)joincount top."
return 0
}
if {$why == ""} { puthelp "NOTICE $nick :Use $joinc(char)joincount show <user> | $joinc(char)joincount top."
return 0
}
if {([regexp -nocase -- {(#[0-9]+|on|off|show|top)} $why tmp joint]) && (![regexp -nocase -- {\S#} $why])} {
    switch $joint {
on {
if {[matchattr $hand nm|MN $chan] } {
channel set $chan +$flag
puthelp "NOTICE $nick :Am activat countjoin pe $chan"
}
}

off {
if {[matchattr $hand nm|MN $chan] } {
channel set $chan -$flag
puthelp "NOTICE $nick :Am dezactivat countjoin pe $chan"
}
}

show {

if {![validuser $user]} { puthelp "NOTICE $nick :Error. $user nu se afla in memoria mea"
return 0
}

if {![matchattr $user $joinc(joinflags) $chan]} { puthelp "NOTICE $nick :Error. $user nu are access pe acest canal"
return 0
}

set joinum [getuser $user XTRA joins($chan)]
if {$joinum == ""} { set joinum 0 }
puthelp "PRIVMSG $chan :$user are $joinum join-uri pe $chan"
}

top {

array set joins [list] 
set list [userlist $joinc(joinflags) $chan] 
set i 0
foreach user $list { 
 set j [getuser $user XTRA joins($chan)] 
 if {$j == ""} { set j 0 }
if {$j > 0} { 
 lappend joins($j) $user
}
}

foreach joinq [lsort -integer -decreasing [array names joins]] {
set i [expr $i +1]
lappend topjoin 1- $i - : 1[join $joins($joinq) ,] 12($joinq) | 
}
if {![info exists topjoin]} { puthelp "NOTICE $nick :Nu sunt useri in top"
return 0
}
puthelp "PRIVMSG $chan :Topul ce contine numarul join-urilor este urmatorul.. :"
foreach txt [wordwrap [join $topjoin " "] 300] {
puthelp "PRIVMSG $chan :$txt"
}
}
}
}
}

proc wordwrap {str {len 100} {splitChr { }}} { 
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

putlog "JoinCount TCL by BLaCkShaDoW Loaded"
