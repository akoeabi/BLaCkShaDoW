###########################################################################
#
#                                BlackTopic
#
#!topic save ( salveaza topicul curent in lista )
#!topic add ( adauga un topic in lista )
#!topic list ( listeaza topic-urile )
#!topic del numar ( stergi un topic - numaru este luat din lista )
#!topic set numar ( setezi pe canal un topic din lista - numaru e luat din lista )
#
#                                            BLaCkShaDoW Productions
###########################################################################

#Aici setezi caracterul de inceput al comenzii

set top(char) "!"

#Aici setezi cine poate folosii comanda

set top(flags) "nm|MANn"

###########################################################################

bind pub nm|MN $top(char)topic bltopic


proc bltopic {nick host hand chan arg} {
global top
set nop [lindex [split $arg] 0]
set dir "logs/topic($chan).txt"
set tp [join [lrange [split $arg] 1 end]]
set number [lindex [split $arg] 1]
if {$arg == ""} { puthelp "NOTICE $nick :use $top(char)topic save | list | add | del | set |" 
return 0
}

 if {([regexp -nocase -- {(#[0-9]+|save|list|add|del|set)} $nop tmp topc]) && (![regexp -nocase -- {\S#} $nop])} {
    switch $topc {


 save {
set t [join [topic $chan]]
if {$t == ""} { puthelp "NOTICE $nick :Nu pot salva topic-ul deoarece este gol"
return 0
}

if {[file exists $dir] == 0} {
set file [open $dir w]
close $file
}
set file [open $dir a]
puts $file $t
close $file
puthelp "NOTICE $nick :Am salvat topic-ul curent..."
}

add {
if {$tp == ""} { puthelp "NOTICE $nick :Use $top(char)topic add <topic>"
return 0
}

if {[file exists $dir] == 0} {
set file [open $dir w]
close $file
}
set file [open $dir a]
puts $file $tp
close $file
puthelp "NOTICE $nick :Am salvat topic-ul..."
}

list {

if {[file exists $dir] == 0} {
set file [open $dir w]
close $file
}
set file [open $dir "r"]
set w [read -nonewline $file]
close $file
set data [split $w "\n"]
set i 0
if {$data == ""} { puthelp "NOTICE $nick :Nu sunt topic-uri $chan"
return 0
}
foreach ts $data {
set i [expr $i +1]
puthelp "NOTICE $nick :Lista de TOPIC pentru $chan este:"
puthelp "NOTICE $nick :$i. $ts"
}
}

del {
if {$number == ""} { puthelp "NOTICE $nick :Use $top(char)topic del <numar> ( il iei din lista )"
return 0
}
if {[file exists $dir] == 0} {
set file [open $dir w]
close $file
}

set file [open $dir "r"]
set data [read -nonewline $file]
close $file
set lines [split $data "\n"]
set i [expr $number - 1]
set delete [lreplace $lines $i $i]
set files [open $dir "w"]
puts $files [join $delete "\n"]
close $files
set file [open $dir "r"]
set data [read -nonewline $file]
close $file
if {$data == ""} {
set files [open $dir "w"]
close $files
}
puthelp "NOTICE $nick :Am sters topic-ul cu numarul $number din lista de pe $chan"
}

set {
if {$number == ""} { puthelp "NOTICE $nick :Use $top(char)topic set <numar> ( il iei din lista )"
return 0
}
set file [open $dir "r"]
set data [read -nonewline $file]
close $file
set lines [split $data "\n"]
set num [expr $number - 1]
set line [lindex $lines $num]
putquick "TOPIC $chan :Setting topic.."
puthelp "TOPIC $chan :$line"
puthelp "NOTICE $nick :Am pus topic-ul cu numarul $number pe $chan"
}

}
}
}
putlog "BlackTopic 1.0 by BLaCKShaDoW Loaded"
