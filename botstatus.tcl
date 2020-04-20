########################################################
#		Eggdrop Status TCL
#
#
#Another way to find out information about your eggdrop,
#similar to: .status command from partyline
#
#
#Made by unknown, updating - dunno when.
########################################################


bind pub nm|- .botstatus do_stat

proc do_stat {nick userhost handle channel args} {
  global botname botnick server version admin realname
  if {[validuser $nick]} {
    puthelp "privmsg $channel :*****Eggdrop Status*****"
    puthelp "privmsg $channel :I am on: \037$server\037"
    puthelp "privmsg $channel :My database has: \037[channels]\037 channels, and a total of: \037[countusers]\037 users"
    puthelp "privmsg $channel :BotOwner: \037$admin\037"
    puthelp "privmsg $channel :Botname: \037$botname\037 \002$realname\002"
    puthelp "privmsg $channel :Bot Version: \037[lindex $version 0]\037"
    puthelp "privmsg $channel :Current DCC connections: \037[dcclist]\037"
    puthelp "privmsg $channel :Bots Connected: \037[llength [bots]]\037"
    puthelp "privmsg $channel :Users on the Botnet: \037[llength [whom *]]\037"
    puthelp "privmsg $channel :TCL library: \037[info library]\037"
    puthelp "privmsg $channel :TCL version: \037[info tclversion]\037 & Patch(header) version: \037[info patchlevel]\037"
    global tcl_platform
    puthelp "privmsg $channel :Machine: \037$tcl_platform(machine)\037"
    puthelp "privmsg $channel :OS: \037$tcl_platform(os)\037"
    puthelp "privmsg $channel :OS: version \037$tcl_platform(osVersion)\037"
    puthelp "privmsg $channel :Platform: \037$tcl_platform(platform)\037"
    putlog "(**Command: .status  by '$nick' on '$channel'**)"
  }
}

putlog "Eggdrop status v0.1 by *unknown* loaded"
