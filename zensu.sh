#!/bin/sh
if [ -e /usr/bin/kdialog ]; then
	PASSWD=$(kdialog --title "Authentication" --password "Authentication required for $USER")
elif [ -e /usr/bin/yad ]; then
	PASSWD="$(yad --entry --entry-label "Password" --hide-text --image=password --window-icon=dialog-password --text="Authentication required for $USER" --title=Authentication --center)"
elif [ -e /usr/bin/zenity ]; then
	PASSWD="$(zenity --password --title Authentication)"
else
	echo "Dependency not available.\n Please install at least one of: spacefm, kdialog, yad, zenity"
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
	if [ -e /usr/bin/kdialog ]; then
		PASSWD=$(kdialog --title "Wrong password, retry" --password "Authentication required for $USER")
	elif [ -e /usr/bin/yad ]; then
		PASSWD="$(yad --entry --entry-label "Password" --hide-text --image=dialog-error --window-icon=dialog-password --text="Wrong password, retry" --title=Authentication --center)"
	else
		PASSWD="$(zenity --password --title="Wrong password, retry")"
	fi
	echo "$PASSWD" | sudo -S "$@"
fi
