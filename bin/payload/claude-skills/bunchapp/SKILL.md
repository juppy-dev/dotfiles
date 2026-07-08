---
name: bunchapp
description: Use when authoring or debugging .bunch files for Bunch.app — the macOS context-switching utility that launches/quits apps, opens files, runs scripts, sends keystrokes, controls system state, and integrates with tools like BetterTouchTool, MailMate, Alfred, and Moom via plain-text Bunch files
---

# Bunchapp Skill

Bunch (bunchapp.co) is a macOS menu-bar utility by Brett Terpstra that automates *context switching*. A "Bunch" is a plain-text `.bunch` file describing a working environment: which apps to launch, which files to open, which system settings to flip, which scripts to run, and what to undo when you close it. Selecting a Bunch from the menu opens that environment; selecting it again (in Toggle Mode) tears it down.

This skill synthesizes the official docs at `https://bunchapp.co/docs` (4 source files, 128 documented pages) into a working reference for writing and troubleshooting `.bunch` files.

## When to Use This Skill

Trigger this skill when the user is:
- **Authoring a `.bunch` file** — designing a context (Comms, Coding, Podcast, etc.) that launches a set of apps with files, websites, or scripts
- **Debugging a Bunch that misbehaves** — apps not closing, focus not landing right, hide/show commands not reversing, snippets not loading
- **Adding interactivity** — multiple-choice dialogs, query prompts, conditional logic based on script output or variables
- **Integrating Bunch with other tools** — BetterTouchTool triggers, MailMate `emate`, Alfred/LaunchBar/Raycast workflows, Moom window layouts, Hazel, AppleScript
- **Reading or writing Bunch syntax** — frontmatter, snippets, fragments, variables (`${var}`), heredocs, embedded scripts (`*` AppleScript, `$` shell, `&` Automator)
- **Setting up automation** — scheduling Bunches (open/close at times), startup Bunches, URL-handler triggers (`x-bunch://`), CLI use (`bunch Coding`)

Do **not** use this skill for general macOS automation outside of Bunch (use AppleScript/Shortcuts/Automator skills directly), or for Brett Terpstra's other apps (TaskPaper, Marked, nvUltra) unless they are being driven from a Bunch.

## Key Concepts

| Term | Meaning |
|---|---|
| **Bunch** | A `.bunch` plain-text file in `~/Documents/Bunches/` (default). Filename without extension is the menu name. |
| **Bunch Folder** | The directory Bunch watches. Set in Preferences. All relative paths in Bunches resolve from here. |
| **Frontmatter** | YAML-ish key/value block at the top, fenced by `---`. Sets `title:`, `shortcut:`, scheduling, variables, etc. Keys are lowercased and spaces stripped (`First Name` → `firstname`). Does NOT support YAML arrays/blocks. |
| **Snippet** | A `.snippet` file (or fragment within one) imported via `<<filename` or `<<#Embedded Name`. Used to share blocks of Bunch lines across Bunches. |
| **Fragment** | A named section inside a snippet/Bunch, declared with `---[Name]` (external) or `#[Name]` (multiple-choice block). |
| **Command** | A parenthesized directive like `(dnd on)`, `(hide dock)`, `(wallpaper ~/Pictures/x.jpg)`. Most auto-reverse on close. |
| **Toggle Mode** | When enabled in Preferences, clicking an open Bunch closes it (quitting apps it launched, restoring commands). |
| **Single Bunch Mode** | Opening a Bunch first closes any currently open Bunch. |
| **URL Handler** | `x-bunch://open/Name`, `x-bunch://close/Name`, `x-bunch://toggle/Name`, `x-bunch://snippet/...?key=value`. |

### Line-Prefix Cheatsheet

These single-character prefixes are the heart of Bunch syntax. Memorize them:

| Prefix | Meaning | Example |
|---|---|---|
| *(none)* | Launch app / open URL | `Slack` |
| `- ` | File to open in the previous app | `- ~/Documents/notes.md` |
| `-> ` | Open in same Finder window as a tab | `-> ~/Pictures` |
| `XX` | Close all windows for the previous app first | `- XX` |
| `@@` | Hide all visible apps (use at top of Bunch) | `@@` |
| `@` | Focus this app, hiding others (use as last line) | `@Marked 2` |
| `^` | Force foreground / unhide on launch | `Mail^` |
| `_` | Hide app after launching | `Slack_` |
| `!` | Quit this app if running | `!Mail` |
| `!!` | Launch when **closing** the Bunch | `!!Backup.app` |
| `!!!` | Quit on close, do not launch on open (triple negative) | `!!!Finder` |
| `%` | Ignore on close (don't quit when Bunch closes) | `%iTerm` |
| `(...)` | Run a Bunch command | `(dnd on)` |
| `!(...)` | Run command only on close | `!(show desktop)` |
| `%(...)` | Don't reverse this command on close | `%(hide dock)` |
| `*` | Run line as AppleScript | `* say "ready"` |
| `$` | Run line as shell script | `$ ~/scripts/setup.sh` |
| `&` | Run an Automator workflow | `& ~/Documents/Workflow.workflow` |
| `<<` | Import snippet (or `<<#` for embedded fragment) | `<<config.snippet` |
| `?{...}` | Multiple-choice dialog | `?{Yes => <<#Y, No => <<#N} "Pick one"` |
| `?"..."` | Query (text input) prompt | `subject = ?"Subject?"` |
| `#` or `//` | Comment (must be followed by a space) | `# this is a comment` |
| `/* ... */` | Block comment | `/* multi\nline */` |
| `${var}` | Variable interpolation (with optional `:default`) | `${name:World}` |

## Quick Reference

### A Minimal Bunch (from official "Comms" example)

```yaml
---
title: 📞Comms
---
Messages
Slack
(dnd off)
```

The frontmatter sets the menu title with an emoji; the body launches Messages and Slack and turns off Do Not Disturb.

### Opening Files in an App (from `bunch-files/apps/`)

```
Numbers
- ~/Documents/job 1.numbers
- ~/Documents/job 2.numbers
```

The dash-prefixed lines are documents passed to the app on the line above. Tilde expands to home; spaces are fine, no quoting.

### Close All Windows Before Opening New Ones

```
Numbers
- XX
- ~/Documents/job 1.numbers
```

`- XX` invokes the app's AppleScript "close every window" first. Some apps (e.g. Tower) do not respond — use `- {@~w}` to send Cmd-W keystrokes instead:

```
Tower
- {@~w}
- ~/Code/Bunch
```

### Open a File in the Default App via URL

```
file:///Users/Dropbox/Code/Bunch%20Work/bunch.taskpaper
```

Spaces become `%20`. This is equivalent to using `Default` as the app name.

### CLI Usage (from `integration/cli/`)

```bash
# Open or toggle Coding.bunch
bunch Coding

# Force open (no toggle), even if already open
bunch -o Coding
```

### Multiple-Choice Dialog with Snippet Branches (from "Screencast" example)

```yaml
---
title: 🎥Screencast
shortcut: S
---
(hide desktop)
(hide dock)
(dnd on)
%ScreenFlow

?{
  Marked => <<#Marked
  Bunch  => <<#Bunch
} "Whatcha workin' on?"

@ScreenFlow
___
#[Marked]
(wallpaper ~/Pictures/Desktops/markeddesktop.jpg)
Marked 2

#[Bunch]
(wallpaper ~/Pictures/Desktops/bunchdesktop.jpg)
```

`___` separates the executable Bunch from embedded fragments. `?{...}` shows a picker; the chosen value's snippet is loaded.

### Conditional Logic on Script Output

```
my_var = $ test_script.sh // captures STDOUT into my_var

if my_var is "result one"
    <<#First Result
else if my_var is "result two"
    <<#Second Result
end
```

`if`/`else if`/`end` blocks support `is`, `is not`, `contains`, `matches` (regex), and existence checks.

### Sending Keystrokes Mid-Bunch

```
- [This is a dramatic \!5pause]
```

Square-bracket strings are sent as keystrokes. `\!5` inserts a 5-second pause. Use `\n`, `\t`, and `{@key}` (modifier+key) escapes inside.

### Display an Image as a Pinned Window

```
(display Desktop.png d:1 100%x100% l,t l:w)
```

Renders the image on display 1, full-size, at left/top, as a wallpaper-level window. Useful for HUD overlays and "which machine am I on" labels.

### Multi-Select Dialog via AppleScript (from `integration/advanced-scripting/multi-select/`)

```applescript
set _res to choose from list {"Comms", "Podcast Record", "Podcast Edit", "Music"} ¬
    with prompt "What next?" OK button name "Launch" ¬
    with multiple selections allowed and empty selection allowed

repeat with _bunch in _res
    do shell script "open 'x-bunch://open/" & _bunch & "'"
end repeat
```

Demonstrates calling Bunch back into itself via the URL handler from a script.

### Trigger BetterTouchTool from a Bunch

```
btt://execute_assigned_actions_for_trigger/?uuid=4D05E320-E682-411A-81A5-BD9B82DD8B4D
```

Or by name:

```
btt://trigger_named/?trigger_name=TriggerName
```

A bare URL line is opened with the system handler, which BTT registers for `btt://`.

### Send Email via MailMate's `emate` (from `integration/mailmate/`)

```bash
recipient = ?[address1@example.com, address2@example.com, address3@example.com]
subject   = ?"What email subject?"

$ echo -e "# Just Testing\n\n- See how this goes\n" \
    | /usr/local/bin/emate mailto \
        --to "${recipient}" -f "tester@example.com" \
        --subject "${subject}" \
        --header "#markup: markdown" --send-now
```

`?[...]` is a dropdown variable; `?"..."` is a free-text prompt; `${var}` interpolates into the shell line.

### Snippets and On-Close Hooks

```
<<#First Fragment        # import immediately
!<<#On Close             # import on close (prefixed !)
<<#After Pause ~5        # import after 5-second delay
    <<#After Launch      # indented = run after parent launches
___
---[First Fragment]
* say "first"

---[After Pause]
* say "I've been waiting"

---[On Close]
* say "Closing"

---[After Launch]
* say "Done launching"
```

Embedded fragments live below `___`. Use `~N` to defer, `!` to run on close, indentation to chain after launch.

### A Full Annotated Example.bunch (from `bunch-files/samplebunch/`)

```bash
# Comments start with `#` or `//` and a space
@@                              # hide all visible apps

Messages
%Terminal                       # launch but don't quit on close

Finder
- XX
- ~/Desktop
- ~/Documents
-> ~/Pictures                   # opens as a tab in the Documents window

(show dock)

https://brettterpstra.com/projects   # open URL in default browser
x-marked://open?file=Work Stuff.md   # custom URL scheme

!Mail                           # quit Mail if running
* say "Bunch launched"          # AppleScript line

@Marked 2                       # focus Marked (last line)
```

## Reference Files

The `references/` directory contains the full official docs, organized by source page-set. Confidence is **medium** for all (auto-scraped from `bunchapp.co/docs`).

- **`bunch-files.md`** (~230 KB, 66 pages) — **Primary syntax reference.** Apps, Commands, Frontmatter, Variables, Snippets, Conditional Logic, Keystrokes, Window Management, Scheduling, Sample Bunches. Start here for any "how do I write X" question.
- **`integration.md`** (~77 KB, 39 pages) — Third-party tool integration: BetterTouchTool, MailMate, Moom, Alfred/LaunchBar/Raycast, Hazel, AppleScript, custom dialogs, multi-select, home automation, the CLI tool.
- **`using-bunch.md`** (~25 KB, 13 pages) — App-level usage: Terminology, Getting Started, Bunch Log (debugging), Preferences, Bunch Menu, Bunch Folder. Read this first if you're new to Bunch as an end-user.
- **`other.md`** (~29 KB, 10 pages) — Introducing Bunch, Changelog, Troubleshooting (especially **App Names** for non-responsive apps).
- **`index.md`** — Table of contents only.

## Working with This Skill

### For New Users
Read `using-bunch.md` first to understand the menu-bar UX and the Bunch Folder. Then skim `other.md` for the high-level pitch and troubleshooting basics.

### For Authors
Open `bunch-files.md` and search by feature heading (`## Apps`, `## Commands`, `## Frontmatter`, `## Variables`, `## Snippets`, `## Conditional Logic`, `## Keystrokes`, `## Sample Bunches`). The Sample Bunches section is the best source of complete, real-world `.bunch` files.

### For Integrators
Start in `integration.md`. The CLI tool, URL handler (`x-bunch://`), and AppleScript dictionary make Bunch trivially callable from Hazel, BetterTouchTool, Alfred, Raycast, Shortcuts, and any script.

### For Debuggers
1. Open Bunch's log via **Help → Open Log** (Console.app). Each Bunch action and error is recorded with severity.
2. Set log level via **Help → Set Log Level** (Errors / Warnings / Info / Debug).
3. Lineage like `[Podcast->Comms->Music]` shows snippet/Bunch call chains.
4. App-name mismatches are the #1 pitfall — see `other.md` Troubleshooting → App Names. Use `mdls -name kMDItemDisplayName -r "/Applications/[App].app"` to confirm the exact name.

## Common Gotchas

- **App not responding to `XX`** — the app doesn't implement `close every window`. Fall back to keystroke `- {@~w}` (Cmd-W).
- **Hidden apps reappear** — a slower-launching app may finish after your `@Focus` ran. Add a delay to the focus line.
- **`@@` doesn't hide foreground app** — known limitation. Use `@TargetApp` as the last line instead.
- **Frontmatter keys with spaces** — they're lowercased and spaces stripped at parse time. `First Name` becomes `${firstname}` (and `${first name}` also resolves).
- **Comment markers need a trailing space** — `#comment` is not a comment; `# comment` is.
- **`Finder` is never auto-quit on close** — use `!!!Finder` (triple negative) to actually quit it.
- **Variable precedence** (low → high): global → frontmatter → dialog/script → URL/AppleScript params → file-line `key=value` overrides.
- **Snippets imported into a variable** — `my_var = <<#Section` works, but the section won't be executed as Bunch lines.
- **App quits unexpectedly when Bunch closes** — prefix with `%` (e.g. `%iTerm`) once anywhere in the Bunch to mark "ignore on close."

## Source Notes

This skill is synthesized from a single source (the official `bunchapp.co/docs` site) split across 4 page-sets. No conflicting sources were detected; all examples and rules in this file are drawn directly from the scraped reference docs included in `references/`. When you need authoritative detail, jump to the matching `## Heading` in `bunch-files.md` or `integration.md`.

All Bunch documentation is © Brett Terpstra. Bunch.app is a macOS-only utility (Catalina+).
