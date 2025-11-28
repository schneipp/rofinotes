#!/bin/bash
# Wrapper script for note CLI tool
# Prompts for note text using rofi and appends to notes file

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

# Prompt for note text using rofi
NOTE_TEXT=$(rofi -dmenu -p "Quick Note" -lines 0 -theme-str 'entry { placeholder: "Type your note here..."; }')

# If user entered something (didn't cancel), add the note
if [ -n "$NOTE_TEXT" ]; then
    "$NOTE_BIN" "$NOTE_TEXT"
    # Show notification that note was added
    if command -v notify-send &> /dev/null; then
        notify-send "Quick Note" "Note saved: $NOTE_TEXT"
    fi
fi
