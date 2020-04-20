#---------------------------------------------------------------------
# chatme.tcl
# Tcl script for IRC bot eggdrop
#
# Upon a public !chat, the bot will attempt to dcc chat the user.
#
# v0: 27-Sep-2003
#---------------------------------------------------------------------

package require eggdrop 1.6.15
package require Tcl 8.0

bind pub nmo|- !chat pub:chatme

proc pub:chatme { nick uhost hand chan text } {

   global botnick 

   # call internal *ctcp:CHAT proc 

   *ctcp:CHAT $nick $uhost $hand $botnick CHAT $text 

   # log the request 

   return 1 


}

putlog "Loaded (version 0): !chatme."

