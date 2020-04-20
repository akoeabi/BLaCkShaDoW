##########################################################################
#
# AutoTopic 1.0 TCL
#
# !atopic <on>/<off>
# !atopic <set> <topic>
# !atopic <view>
#
#This TcL acts like X, mantaining the topic that is set on the BoT.
#
#                                           BLaCkShaDoW ProductionS
##########################################################################

#Here you set the level required to execute the commands.

set atopic(flags) "nm|MN"

#Here you set the time for the topic checking to be done (minutes)

set atopic(time) "10"

##########################################################################

setudef flag autotopic
setudef str gettopic

bind pub $atopic(flags) !atopic atopic:command


if {![info exists atopic:process_running]} { 
timer $atopic(time) atopic:process
set atopic:process_running 1
}

proc atopic:command {nick host hand chan arg} {
set stat [lindex [split $arg] 0]
set top [join [lrange [split $arg] 1 end]]
if {$stat == ""} { puthelp "NOTICE $nick :Use !atopic <on>/<off> | <set> <topic> | <view>"
return 0
}

switch -exact -- [string tolower $stat] {

on {
if {[channel get $chan autotopic] == "1"} { puthelp "NOTICE $nick :AutoTopic is already activated."
return 0
}
channel set $chan +autotopic
puthelp "NOTICE $nick :ENABLED AutoTopic."
if {[channel get $chan gettopic] != ""} {
putserv "TOPIC $chan :[channel get $chan gettopic]"
}

}

off {
if {[channel get $chan autotopic] == "0"} { puthelp "NOTICE $nick :AutoTopic is already disabled."
return 0
}
channel set $chan -autotopic
puthelp "NOTICE $nick :Disabled AutoTopic."
}

set {
if {$top == ""} { puthelp "NOTICE $nick :Use !atopic <on>/<off> | <set> <topic> | <view>"
return 0
}
channel set $chan gettopic $top
puthelp "NOTICE $nick :Set AutoTopic to : $top"
putserv "TOPIC $chan :$top"
}

view {
if {[channel get $chan autotopic] == "1"} {
set atopicstat "ENABLED"
} else { set atopicstat "DISABLED" }
puthelp "NOTICE $nick :AutoTopic is :$atopicstat"
puthelp "NOTICE $nick :And the TOPIC is :[channel get $chan gettopic]"
}

}
}


proc atopic:process {} {
global atopic
foreach chan [channels] {
if {[channel get $chan autotopic]} {
putlog "Checking topic on $chan..."
if {[channel get $chan gettopic] != ""} {
if {[topic $chan] != [channel get $chan gettopic]} {
putserv "TOPIC $chan :[channel get $chan gettopic]"
}
}
}
}
timer $atopic(time) atopic:process
return 1
}


putlog "AutoTopic 1.0 by BLaCkShaDoW Loaded"
