#Set this to your ident you like to use with this Eggdrop
set ident "YourIdent"

#Set this to the full path of your .oidentd.conf [/home/username/.oidentd.conf]
# WARNING! This file will be overwritten!
set oidentdconf "/home/YourUsername/.oidentd.conf"

# -------------------------------------------------------------------------

proc setident {type} {
	global ident oidentdconf
	putlog "Set ident to $ident"
	set file [open $oidentdconf "w"]

	puts $file "global { reply \"$ident\"}"
	close $file		
	}

putlog "oidentd.tcl v1.0 loaded"
bind evnt - connect-server setident
