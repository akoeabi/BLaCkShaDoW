#######################################################################
# 
#    TOPIC Changer vers. 1.1
#
#Acest TCL va mentine topicul setat pe canalul setat..deci odata la un #interval de timp..va reimprospata ultimul topic setat..ca sa nu se mai #piarda topicul :)
#
#NEW ACUM DOAR PRIN ACTIVARE !
#
#Pentru activare se foloseste .chanset #canal +refresh
#Pentru a activa un refresh in orice moment se foloseste !refresh
#Doar setati timpu in care sa reimprospateze topicu (default 360)
#
#                                          BLaCkShaDoW Productions
#######################################################################


# Aici setezi numarul de minute in care se improspateze topicul

set topic_time 360

#Aici setezi flagurile pe care trebuie sa le ia pentru a activa #refreshu (default o|o)

set flags "o|o"

################################################################
setudef flag refresh
set versions "1.1"

bind pub $flags !refresh pub:refresh

proc pub:refresh {nickname hostname handle channel text} {
global botnick
set thetopic [topic $channel]
set ::topicchannel $channel
set ::topicnickname $nickname
time_topic
}


if {![string match "*topic_time*" [timers]]} {
 timer $topic_time time_topic
}

proc time_topic {} {
 global topic_time time_topic 
set channel $::topicchannel
set thetopic [topic $channel]
if { [channel get $channel refresh] } {
   puthelp "TOPIC $channel : Refreshing topic..."
   puthelp "TOPIC $channel :$thetopic"

 if {![string match "*time_topic*" [timers]]} {
  timer $topic_time time_topic
 }
}
}
putlog "Topic Changer version $versions by BLaCkShaDoW loaded"
