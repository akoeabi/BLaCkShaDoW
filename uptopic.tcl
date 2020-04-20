#######################################################################
# 
#UpTopic.tcl
#
#La un interval de timp schimba topicu cu uptimu server-ului unde este #hostat eggdrop-ul.
#Pentru activare .chanset #canal +uptopic (in DCC)
#
#                                       BLaCkShaDoW ProductionS
#######################################################################

#Aici setezi cum vrei sa fie topicu setat

set topic_up "Server UP - Ceas : %time% , Uptime : %days% zile , %hour% ore"


#Aici setezi dupa cat timp sa reimprospateze topicu (minute)

set change_time "10"

#Aici setezi offtopic (topic care va fii pus in caz ca uptimu nu se #poate executa

set of_topic "Uptime nu este disponibil momentan"


#######################################################################
setudef flag uptopic
if {![info exists topicchange_running]} {
timer $change_time topicchange
set topicchange_running 1
}


proc topicchange {} {
global change_time topic_up of_topic
catch {exec uptime} shelluptime
set text [split $shelluptime];#
set time [lindex $text 0]
set days [lindex $text 3]
set hour [lindex $text 6]
set hours [string trim $hour ","]
set replace(%time%) $time
set replace(%days%) $days
set replace(%hour%) $hours
set topics [string map [array get replace] $topic_up]
foreach chan [channels] {
if {[channel get $chan uptopic]} {
if {$shelluptime == ""} { putquick "TOPIC $chan :$of_topic" }
putquick "TOPIC $chan :Getting new UPTIME.."
puthelp "TOPIC $chan :$topics"
}
}
timer $change_time topicchange
return 1
}

putlog "UpTopic TCl by BLaCkShaDoW Loaded"
