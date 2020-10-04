#!/bin/sh
if [ -e /usr/bin/spacefm ]; then
	eval "`spacefm -g --label "Authentication required for $USER" --hbox --icon password --password --button cancel --button ok --title Authentication`"
	PASSWD="$dialog_password1"
elif [ -e /usr/bin/yad ]; then
	PASSWD="$(yad --entry --entry-label "Password" --hide-text --image=password --window-icon=dialog-password --text="Authentication required for $USER" --title=Authentication --center)"
else
	PASSWD="$(zenity --password --title =Authentication)"
fi

if [ "$dialog_pressed_label" = 'cancel' ]; then
	echo "triggered cancel"
	exit
elif [ -z "$PASSWD" ]; then
	echo "triggered empty"
	exit
else
	echo triggered PW
	echo "$PASSWD" | sudo -S "$@"
fi

if [ $? = 1 ]; then
	if [ -e /usr/bin/spacefm ]; then
		eval "`spacefm -g --label "Wrong password, retry" --hbox --icon dialog-error --password --window-icon=dialog-password --button cancel --button ok --title Authentication`"
		PASSWD="$dialog_password1"
	elif [ -e /usr/bin/yad ]; then
		PASSWD="$(yad --entry --entry-label "Password" --hide-text --image=dialog-error --window-icon=dialog-password --text="Wrong password, retry" --title=Authentication --center)"
	else
		PASSWD="$(zenity --password --title="Wrong password, retry")"
	fi
	echo "$PASSWD" | sudo -S "$@"
fi
