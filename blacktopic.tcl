################################################## #########################
#
# BlackTopic
#
#! topic save (save the current topic in the list)
#! topic add (add a topic to the list)
#! topic list (list topics)
#! topic del numar (delete a topic - the number is removed from the list)
#! topic set number (set a topic in the channel on the channel - number is taken from the list)
#
# BLaCkShaDoW Productions
################################################## #########################

#Here you set the start character of the command

set top (char) "!"

# Here you set who can use the command

set top (flags) "nm | MANn"

################################################## #########################

bind pub nm | MN $ top (char) topic bltopic


proc bltopic {nick host hand chan arg} {
global top
set nop [lindex [split $ arg] 0]
set dir "logs / topic ($ chan) .txt"
set tp [join [lrange [split $ arg] 1 end]]
set number [lindex [split $ arg] 1]
if {$ arg == ""} {puthelp "NOTICE $ nick: use $ top (char) topic save | list | add | del | set |"
return 0
}

 if {([regexp -nocase - {(# [0-9] + | save | list | add | del | set)} $ nop tmp topc]) && (! [regexp -nocase - {\ S #} $ nop])} {
    switch $ topc {


 save {
set t [join [topic $ chan]]
if {$ t == ""} {puthelp "NEWS $ nick: I cannot save topic because it is empty"
return 0
}

if {[file exists $ dir] == 0} {
set file [open $ dir w]
close $ file
}
set file [open $ dir a]
puts $ file $ t
close $ file
puthelp "NEW $ nick: I saved the current topic ..."
}

add {
if {$ tp == ""} {puthelp "NOTICE $ nick: Use $ top (char) topic add <topic>"
return 0
}

if {[file exists $ dir] == 0} {
set file [open $ dir w]
close $ file
}
set file [open $ dir a]
puts $ file $ tp
close $ file
puthelp "NOTICE $ nick: I saved the topic ..."
}

list {

if {[file exists $ dir] == 0} {
set file [open $ dir w]
close $ file
}
set file [open $ dir "r"]
set w [read -nonewline $ file]
close $ file
set data [split $ w "\ n"]
set and 0
if {$ data == ""} {puthelp "NOTICE $ nick: No topics $ chan"
return 0
}
foreach ts $ data {
set i [expr $ i +1]
puthelp "NOTICE $ nick: TOPIC list for $ chan is:"
puthelp "NOTICE $ nick: $ i. $ ts"
}
}

of {
if {$ number == ""} {puthelp "NOTICE $ nick: Use $ top (char) topic of the <number> (take it from the list)"
return 0
}
if {[file exists $ dir] == 0} {
set file [open $ dir w]
close $ file
}

set file [open $ dir "r"]
set data [read -nonewline $ file]
close $ file
set lines [split $ data "\ n"]
set i [expr $ number - 1]
set delete [lreplace $ lines $ i $ i]
set files [open $ dir "w"]
puts $ files [join $ delete "\ n"]
close $ files
set file [open $ dir "r"]
set data [read -nonewline $ file]
close $ file
if {$ data == ""} {
set files [open $ dir "w"]
close $ files
}
puthelp "NOTICE $ nick: I deleted the topic with the number $ number from the list on $ chan"
}

set {
if {$ number == ""} {puthelp "NOTICE $ nick: Use $ top (char) topic set <number> (take it from the list)"
return 0
}
set file [open $ dir "r"]
set data [read -nonewline $ file]
close $ file
set lines [split $ data "\ n"]
set num [expr $ number - 1]
set line [lindex $ lines $ num]
putquick "TOPIC $ chan: Setting topic .."
puthelp "TOPIC $ chan: $ line"
puthelp "NOTICE $ nick: I put the topic with the number $ number on $ chan"
}

}
}
}
putlog "BlackTopic 1.0 by BLaCKShaDoW Loaded"
