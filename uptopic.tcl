################################################## #####################
#
# UpTopic.tcl
#
#At a time change the topic with the server uptime where the #hostat eggdrop is.
#For activation .chanset #channel +uptopic (in DCC)
#
# BLaCkShaDoW ProductionS
################################################## #####################

# Here's how you want it to be topically set

set topic_up "Server UP - Clock:% time%, Uptime:% days% days,% hour% hours"


#Here you set how long to refresh the topic (minutes)

set change_time "10"

# Here you set offtopic (topic that will be put in case the uptimo cannot be executed

set of_topic "Uptime is currently unavailable"


################################################## #####################
setudef flag uptopic
if {! [info exists topicchange_running]} {
timer $ change_time topicchange
set topicchange_running 1
}


proc topicchange {} {
global change_time topic_up of_topic
catch {exec uptime} shelluptime
set text [split $ shelluptime]; #
set time [lindex $ text 0]
set days [lindex $ text 3]
set hour [lindex $ text 6]
set hours [string trim $ hour ","]
set replace (% time%) $ time
set replace (% days%) $ days
set replace (% hour%) $ hours
set topics [string map [array get replace] $ topic_up]
foreach chan [channels] {
if {[channel get $ chan uptopic]} {
if {$ shelluptime == ""} {putquick "TOPIC $ chan: $ of_topic"}
putquick "TOPIC $ chan: Getting new UPTIME .."
puthelp "TOPIC $ chan: $ topics"
}
}
timer $ change_time topicchange
return 1
}

putlog "UpTopic TCl by BLaCkShaDoW Loaded"
