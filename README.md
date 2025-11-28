# note

> The fastest way to capture your thoughts. Zero friction, maximum speed.

A lightning-fast note-taking tool that meets you where you are: terminal, keyboard shortcut, or app launcher. Built for Linux power users who value speed and simplicity.

## Why `note`?

**Because your brain moves faster than your note app.**

- **⚡ Instant**: Add notes in milliseconds from anywhere
- **🎯 Multiple interfaces**: CLI, Rofi popup, or app launcher - your choice
- **🔍 Smart search**: Fuzzy find notes with instant clipboard copying
- **🪶 Zero overhead**: No databases, no configs, no learning curve
- **📝 Markdown native**: All notes in `~/notes.md` - use them with any tool
- **🚀 Blazingly fast**: Written in Rust because every millisecond counts
- **🐧 Linux-first**: Full Wayland and X11 support

## Installation

### One-command install

```bash
git clone https://github.com/yourusername/note.git
cd note
chmod +x install.sh
./install.sh
```

The installer automatically:
- Builds the Rust binary
- Installs to `/usr/local/bin` or `~/.local/bin` (no sudo needed!)
- Sets up Rofi integration scripts
- Creates desktop launchers
- Checks your PATH and guides you if needed

## Usage

### 🖥️ CLI Mode (fastest)

```bash
# Add a note
note "Buy milk on the way home"
note "Check out that new Rust crate for async I/O"
note "Meeting tomorrow at 3pm with the design team"

# List all notes
note list
```

### ⌨️ Rofi Mode (keyboard-first)

**Quick Note Capture:**
1. Launch "Quick Note" from your app launcher (or bind to a hotkey)
2. Type your note in the Rofi popup
3. Press Enter - done! You'll get a desktop notification

**Search & Browse:**
1. Launch "Search Notes" from your app launcher
2. Fuzzy search through all your notes in real-time
3. Select one - it's automatically copied to your clipboard
4. Works on both Wayland (wl-copy) and X11 (xclip)

### 🚀 Power User Setup

**Bind to a global hotkey (recommended!):**

```bash
# For i3/Sway - add to config:
bindsym $mod+n exec note-wrapper.sh
bindsym $mod+Shift+n exec note-search-wrapper.sh

# For KDE - System Settings → Shortcuts → Custom Shortcuts
# Command: note-wrapper.sh

# For GNOME - Settings → Keyboard → Custom Shortcuts
# Command: note-wrapper.sh
```

Now you can capture thoughts with a single keypress from anywhere!

## Real-world workflows

### The Developer's Second Brain
```bash
# In terminal while coding
note "TODO: Refactor authentication module"
note "Bug: Race condition in worker pool on line 342"
note "Idea: Cache this query - it's called 1000x per request"

# Press Super+N anywhere to capture without leaving your IDE
# Press Super+Shift+N to search old notes and paste them
```

### Command History That Actually Works
```bash
# Save commands you always forget
note "ffmpeg -i input.mp4 -vf scale=1280:720 output.mp4"
note "docker system prune -a --volumes"
note "rsync -avz --progress source/ user@server:/backup/"

# Later: Super+Shift+N, type "ffmpeg", paste the exact command
```

### The Inbox for Your Brain
```bash
# Things to check out
note "aurynk, an android device manager and mirroring tool for linux"
note "https://github.com/cool-new-project - star this later"

# Quick TODOs
note "Call dentist on Monday"
note "Review Sarah's PR before EOD"

# Random ideas
note "Blog post: Why note-taking apps are overcomplicated"
```

## Why not use...?

| Tool | Problem | `note` solves it |
|------|---------|----------------|
| Notion/Obsidian | 2-3 seconds to open, mouse required | Keyboard shortcut → instant capture |
| Text editor | Context switching breaks flow | Capture from anywhere, stay focused |
| `echo >> file` | No search, no structure | Rofi fuzzy search + markdown |
| Todo apps | Over-engineered, proprietary | Simple, fast, open format |
| Sticky notes | Lost in 47 browser tabs | One place, instant search |

## Features

### ✅ What it does
- Lightning-fast note capture (CLI or Rofi popup)
- Fuzzy search with clipboard integration
- Desktop notifications
- Keyboard shortcut support
- Works on Wayland and X11
- Plain markdown storage - your data, your control

### ❌ What it doesn't do
- Cloud sync (use git instead - see tips below)
- Rich text / images (it's plain text!)
- Reminders / alarms (use calendar for that)
- Mobile app (Linux desktop only)

Philosophy: Do one thing extremely well.

## Pro tips

### Alias for even faster CLI usage
```bash
alias n='note'
n "This is even faster"
```

### Sync across machines with git
```bash
cd ~
git init
git add notes.md
git commit -m "Initial notes"
git remote add origin git@github.com:yourusername/notes.git
git push -u origin main

# Auto-sync (add to .bashrc)
alias n='note $@ && (cd ~ && git add notes.md && git commit -m "Update notes" && git push &>/dev/null &)'
```

### Integration with other tools
```bash
# Use with fzf in terminal
alias nf='cat ~/notes.md | fzf'

# Preview recent notes
tail -20 ~/notes.md

# Search with grep
grep -i "keyword" ~/notes.md

# Count your notes
wc -l ~/notes.md
```

### Desktop launcher alternatives
If you don't use Rofi, you can use:
- **dmenu**: Replace `rofi -dmenu` with `dmenu` in wrapper scripts
- **wofi**: Replace `rofi` with `wofi` (Wayland-native)
- **fuzzel**: Another Wayland option

## Design philosophy

`note` follows the Unix philosophy:
- **Do one thing well**: Capture and search notes, nothing more
- **Work together with other tools**: Plain markdown works everywhere
- **Text streams**: Pipe it, grep it, sed it, git it
- **Keep it simple**: No databases, no configs, no bloat

Your notes live in `~/notes.md` - a plain markdown file. No lock-in, no proprietary formats, no cloud dependencies. Your notes, your file, your control.

## Performance

**CLI mode:**
```
Time to capture a note: ~2-5ms
```

**Rofi mode:**
```
Keypress to note saved: ~100-200ms (including UI render)
```

Compare that to:
- Opening Notion: ~2-3 seconds
- Opening Evernote: ~1-2 seconds
- Opening OneNote: ~2 seconds
- Opening Obsidian: ~500ms-1s
- Opening Vim: ~100-200ms

**We're not in the same category. We're 10-1000x faster.**

## Requirements

- **Rust** (for building)
- **Rofi** (optional, for GUI mode) - `sudo apt install rofi` or `sudo pacman -S rofi`
- **wl-clipboard** or **xclip** (optional, for clipboard support)
- **libnotify** (optional, for notifications) - usually pre-installed

## Compatibility

Tested on:
- ✅ Arch Linux + i3
- ✅ Ubuntu + GNOME (Wayland)
- ✅ Fedora + KDE (X11)
- ✅ Pop!_OS + COSMIC
- ✅ NixOS + Sway (Wayland)

Should work on any Linux distro with a desktop environment.

## Contributing

Found a bug? Have an idea? PRs welcome!

**Areas we'd love help with:**
- 🐛 Bug fixes
- 📚 Better documentation
- 🎨 Support for other launchers (dmenu, wofi, fuzzel)
- 🧪 Testing on more distros/DEs
- ⚡ Performance improvements

**Not interested in:**
- Feature bloat (keep it simple!)
- Cloud sync (use git)
- GUI applications (we're keyboard-first)

## License

MIT - Because good tools should be free.

---

<div align="center">

**Stop context-switching. Start capturing thoughts.**

Press a hotkey. Type your thought. Press Enter. Done.

Your brain works in milliseconds. Your note-taking tool should too.

`./install.sh` and never lose an idea again.

</div>
