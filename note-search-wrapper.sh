#!/bin/bash
# Wrapper script for searching notes with rofi
# Lists all notes and allows searching/filtering with rofi

# Find the note binary
if command -v note &> /dev/null; then
    NOTE_BIN="note"
elif [ -f "/usr/local/bin/note" ]; then
    NOTE_BIN="/usr/local/bin/note"
elif [ -f "$HOME/.local/bin/note" ]; then
    NOTE_BIN="$HOME/.local/bin/note"
else
    notify-send "Error" "note binary not found"
    exit 1
fi

# Get all notes
SELECTED_NOTE=$("$NOTE_BIN" list | rofi -dmenu -i -p "Search Notes" -theme-str 'window { width: 50%; } listview { lines: 15; }')

# If user selected a note (didn't cancel)
if [ -n "$SELECTED_NOTE" ]; then
    # Copy to clipboard (prefer wl-copy on Wayland)
    if [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy &> /dev/null; then
        echo -n "$SELECTED_NOTE" | wl-copy
        CLIPBOARD_MSG="(copied to clipboard)"
    elif command -v xclip &> /dev/null; then
        echo -n "$SELECTED_NOTE" | xclip -selection clipboard
        CLIPBOARD_MSG="(copied to clipboard)"
    elif command -v wl-copy &> /dev/null; then
        echo -n "$SELECTED_NOTE" | wl-copy
        CLIPBOARD_MSG="(copied to clipboard)"
    else
        CLIPBOARD_MSG="(clipboard tool not found)"
    fi

    # Show notification
    if command -v notify-send &> /dev/null; then
        notify-send "Note Selected" "$SELECTED_NOTE $CLIPBOARD_MSG"
    fi
fi
