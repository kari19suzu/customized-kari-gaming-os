#!/usr/bin/env bash
# Prompt for a port number using a native desktop GUI window
PORT=$(zenity --entry --title="UPnP Port Forward" --text="Enter the port number to open (TCP):" --entry-text="7777")

if [ -n "$PORT" ]; then
    # Get local IP dynamically
    LOCAL_IP=$(ip route get 1 | awk '{print $7}')

    # Execute upnpc to forward the port
    upnpc -a "$LOCAL_IP" "$PORT" "$PORT" tcp

    if [ $? -eq 0 ]; then
        zenity --info --title="Success" --text="Port $PORT successfully forwarded for $LOCAL_IP!"
    else
        zenity --error --title="Failed" --text="Could not map port $PORT. Check if UPnP is enabled on your router."
    fi
fi
