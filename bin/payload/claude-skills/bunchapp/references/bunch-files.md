# Bunchapp - Bunch-Files

**Pages:** 66

---

## Apps - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/apps/

**Contents:**
- Application Actions
- Launching Apps
- Opening Files
  - Opening Finder Tabs
- Opening Files in Their Default Application
  - Inserting a Pause
- Closing Windows
- Hiding Apps
- Activating Apps
- “Focusing” an App

Within a Bunch file you simply list the apps you want it to launch, one per line. For example, in “Comms.bunch”:

You can add additional lines to perform actions like opening files.

If the app in question is not responding, see the troubleshooting section on App Names.

You can additionally have an app open specific documents, if the app supports that. After the app name, simply add one or more documents on lines that begin with a dash. For example, to have Numbers open two specific spreadsheets:

Paths to documents can use a tilde ~ to represent the home directory. Spaces are fine, no quotes or escaping needed.

You may want to close all open windows before opening new files. To do that, use XX

You can also specify a file as a URL to have Bunch open it in whatever app is defined as the default handler for it. For example, if you put the following on its own line, Bunch would open TaskPaper* with the file (note that spaces are replaced with %20):

This is the same as specifying “default” as the app (see below).

* This assumes TaskPaper is installed.

There’s a special syntax that currently only applies to Finder. If you want multiple folders to open in tabs, list the first folder on a normal file line, then the other folders that should open in the same window with -> preceding them:

You can open multiple windows by starting a new line without the >. The following will open two windows with two tabs each:

For reasons I can’t explain, doing this via System Events is excruciatingly slow. This process will run in the background and it’s OK to click other windows while waiting for the Finder tabs to finish opening.

You can just put the word “Default” on a line before some file lines, and it will open all of those files in whatever app is assigned as the default on your system. PDFs might open in Preview or PDFpen, Pages files would open in Pages, etc.

This is especially handy when using Spotlight searches instead of files.

You can pause between files by inserting a file line containing (pause 5) (for a 5 second pause). The number must be a positive integer representing a number of seconds, with no letters or decimals. This is mostly useful if you want to send keystrokes or wait for a URL to load between actions.

If you include a file line containing only “XX”, then all windows for the app will be closed. This can be included before lines that open new files/windows to start with a clean slate.

This will only work if the app responds to the AppleScript command close every window. Most apps do, but there are exceptions. A warning dialog will be displayed if the command fails and you should remove the instruction from your Bunch.

If you use “@@” alone on a line, Bunch will hide all visible apps. (Menu bar apps like Dash or TextExpander may not hide properly.) This is ideal for use at the very beginning of a Bunch, giving you a clean slate for a new set of apps.

Note that a windowed app in the foreground when you run the Bunch will likely fail to hide. The better option is to focus one of the apps that the Bunch launches.

You can also append an underscore to any single app name and Bunch will attempt to hide it after launching. (This can be flaky depending on how long the app takes to launch.)

By default apps will launch without activating, meaning that if the app allows it, it won’t become the foreground app when it launches, keeping focus on whatever app you’re working in. If the app is already running, it won’t activate, and if it’s hidden, it will remain hidden.

To force an app to become foreground (and unhide if hidden), append a caret (^) to the app name.

If you start an app line with an @ symbol, it will attempt to focus that app (hiding other apps). This should be run as the last line of the file, after all other lines have run. Make sure the app you want to focus has already been launched (this line will not launch the app, only focus a running app).

Everything is launched in the order listed in the Bunch file. Some apps take longer than others to launch or open a file, so execution will continue in the background after the initial launch of the app.

If an app is still launching at the time another app is focused, windows from the slower app may appear after other windows are hidden. To ensure that the app you want focused remains the only app visible, you can add a delay to the focus command. Make it just long enough for other apps to finish launching.

As an alternative to hiding and focusing apps, see the screen command.

Put an exclamation point before the app name to quit that app if it’s open. For example, to quit Mail and launch MailMate instead:

You can also have apps launch when closing the Bunch.

If the app in question is not responding, see the troubleshooting section on App Names.

When you close a Bunch (or “Toggle Bunches” or “Single Bunch Mode” are enabled), any apps launched by the Bunch will be quit. To avoid quitting an app when the Bunch is closed or toggled off, place a percent symbol before it in the Bunch (e.g. %iTerm). This will launch the app as normal, but ignore it when closing the Bunch.

In this example, CodeRunner will launch and quit with the Bunch, but iTerm will only launch if it’s not already running, and will remain running if the Bunch is closed.

If an app is called multiple times in a Bunch (perhaps to focus it or send keystrokes to it after another app has launched), only one instance needs to be marked with % to avoid closing the app. Once an app is marked as “ignore on close” at any point in the Bunch, it won’t be quit when the Bunch closes.

This works for commands as well:

This will enable Dark Mode when opening the Bunch, and leave it in Dark Mode when closing.

Finder is always ignored (won’t be quit) when closing a Bunch. If you want to actually quit Finder when closing a Bunch, use a triple negative:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
Messages
Slack
Mail
Twitter
```

Example 2 (markdown):
```markdown
Numbers
- ~/Documents/job 1.numbers
- ~/Documents/job 2.numbers
```

Example 3 (markdown):
```markdown
Numbers
- XX
- ~/Documents/job 1.numbers
```

Example 4 (yaml):
```yaml
file:///Users/Dropbox/Code/Bunch%20Work/bunch.taskpaper
```

---

## Commands - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands//

**Contents:**
- Bunch Special Commands
- Reversing Commands
- Section Contents

Commands are run by using lines surrounded by parenthesis in Bunch files. These offer shortcuts to some system tasks and special actions.

Most commands are automatically reversed when closing a Bunch (hidden Desktop icons are shown, hidden dock is revealed, wallpapers switch back, etc.). Notable exceptions include Dock positioning, notification, and audio commands, which are not restored to their previous state when the Bunch closes.

To avoid reversing a command when closing the Bunch, precede the line with a % symbol, e.g. %(hide dock) (just like ignoring applications when quitting).

To run the command only when closing a bunch, use an exclamation point (!) before the command, e.g. !(show desktop).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(dark mode [on|off])
(do not disturb [on|off])
(hide dock)
(show dock)
(dock [left|right|bottom])
(hide desktop)
(show desktop)
(wallpaper [path(s)])
(screen)
(audio [input|output] device_name)
(audio [input|output] volume [0-100])
(audio [input|output] [mute|unmute])
(input source [name])
(notify TEXT)
(display FILE)
(sleep [display])
(awake [interval])
(log [MESSAGE])
(shortcut [SHORTCUT NAME])
```

---

## Syntax Reference - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/quick-reference/

**Contents:**
- Quick Reference
- Formatting
  - Indentation
  - Line Breaks
  - Comments
- Bunch Syntax
- Frontmatter
- URL Handler
    - See Also:

Bunch Lines start at the left column unless they’re in an indented logic block. Indentation within a logic block must be consistent with other lines at the same level of the block.

Bunch Lines should be a single line, but can be split by ending the line with a backslash and continuing immediately on the next line. A backslash followed by a blank line will not be joined.

Comments can be block (/*...*/), lines (# Comment), or inline at the end of a line (Preview // inline comment). Comment markers must be followed by a space.

You can control some aspects of your Bunch using Frontmatter, including the title and icons it uses in the menu. See the Frontmatter docs for details.

See documentation for details.

UUID can be retrieved using “Copy UUID” in Preferences. ↩ ↩2

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (julia):
```julia
Messages

if social
	Slack
	Discord
end
```

Example 2 (unknown):
```unknown
(display bunch-internal/first-bunch.html \
 500x600 level:floating)
```

---

## Window Management - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/window-management/

**Contents:**
- Bunch and Window Management

Bunch does not have any window management features (aside from its own windows created via the display command or shell script Task Monitors). This is because there are plenty of dedicated apps that do a far better job than Bunch ever aspires to, and many of them have great automation features that make them perfect for use with Bunch. My favorite example is using Bunch with Moom.

If you’re an intrepid hacker, you can also achieve window management and much more using Hammerspoon.

All materials copyright © Brett Terpstra 2021

---

## Running Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/

**Contents:**
- Running Scripts With Bunch
- Section Contents

Bunch can run Automator Workflows, AppleScripts and AppleScript commands, and shell scripts and shell commands. Choose a section to learn more.

All materials copyright © Brett Terpstra 2021

---

## Awake - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/awake/

**Contents:**
- Awake Commands
- Examples
    - See Also:

(awake) will keep your Screensaver from activating and your display from sleeping. If you specify an interval in the format XhXmXs (e.g. 2h or 1h30m) then Bunch will stop keeping your machine awake after that period of time. Any running awake command will be terminated when the Bunch is closed or the application is quit.

If the application should happen to terminate unexpectedly, the awake command may continue running in the background. In this case, just launch Bunch again and ⌥⌘ the Bunch containing the awake command to force close.

See also: Sleep Commands

All materials copyright © Brett Terpstra 2021

---

## Do Not Disturb - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/do-not-disturb/

**Contents:**
- Do Not Disturb Commands
- Examples
    - See Also:

Toggle notifications. The commands can be abbreviated as (dnd on) and (dnd off). Actually, (dnd on) can just be (dnd), too. I like to make things intuitive by over complicating them sometimes.

If you want to control Focus Modes, you’ll need to do a little extra setup.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(dnd on) // or just (dnd)
(dnd off)
```

---

## Dark Mode - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/dark-mode/

**Contents:**
- Dark Mode Commands
- Examples
    - See Also:

Turn macOS Dark Mode on and off: (dark mode on), (dark mode off). An “on” command can be shortened to just (dark mode), and (dark mode off) can be shortened to (light mode).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(dark mode)
(dark mode off) # or (light mode)
```

---

## Opening Other Bunches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/other-bunches/

**Contents:**
- Bunches Inside Bunches
- Opening Other Bunches
- Setting Frontmatter Variables
- Closing Other Bunches and Launch on Close
- Nesting
- Launching Bunches as Snippets
    - See Also:

Bunch can perform actions on other Bunches from within a Bunch, opening or closing them, as well as passing variables to change their behavior.

You can launch other Bunches just by adding the full name of the Bunch, including the “.bunch” extension, on a line, just like you would an app. Bunches launched in this manner behave as if you clicked them in the menu: it gets an “open” checkbox in the menu, and can be quit separately from the Bunch that launched it.

You can use this in optional snippets to make entire Bunches optional. Create a snippet that calls a Bunch, then reference it with optional syntax.

When closing the parent Bunch, any Bunches launched will also be closed. Use %Name.bunch to ignore the Bunch when closing.

When using subfolders, it’s a good idea to prefix the Bunch name with the subfolder (e.g. Subfolder/Bunch Name.bunch). The Bunch name alone will match a subfolder Bunch, but because Bunches with the same name can exist in different subfolders, using the Bunch name only will find the first match alphanumerically, which may not be the one you’re looking for.

When calling a Bunch from another Bunch, you can override and add to frontmatter keys, which can then be used in variables. To do so, add dashed lines underneath the Bunch call with key=value pairs:

Now when MyOther.bunch launches, it will have the variable myvar populated with my value and it can be used as ${myvar} in MyOther.bunch. This means that a Bunch can do different things when launched from other Bunches, with each parent Bunch setting its own variables.

Frontmatter variables can be used in app lines, file lines, or within arguments for scripts and workflows.

Variables set when the Bunch is opened will persist when the Bunch is closed. So if your variable value caused the Bunch to open an app, for example, that app will be closed when the Bunch is closed.

Bunch lines behave just like app lines, so using !Name.bunch will quit that Bunch, and using !!Name.bunch will launch that Bunch when the containing Bunch closes.

If a Bunch quits another Bunch when it launches (!Name.bunch), the Bunch that was closed will be re-opened when the containing Bunch closes.

If a Bunch is closed that contains apps launched by the parent Bunch, those apps won’t be quit when closing the Bunch. Same goes in the other direction: if opening a Bunch would launch apps that the containing Bunch would quit, those apps are ignored and left running.

You can nest these calls, having one Bunch open another which opens another, but you can’t open or close a Bunch that appears earlier in the chain. This is to avoid infinite loops.

Beware of having a Bunch close or launch other Bunches that also close or launch Bunches. Bunch has safeguards against loops, but if you get crazy enough, it’s turtles all the way down.

You can also use any Bunch file as a snippet. This will incorporate the contents of the Bunch (or any fragment within it) directly into the calling Bunch, starting and quitting items when the calling Bunch opens and closes. In this case the Bunch in the menu does not get a check mark, it’s contents are now part of the Bunch you called it from.

It does have the benefit of directly using things like optional snippets and delays.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
# Open the Comms Bunch as if we had clicked it in the menu.
Comms.bunch
```

Example 2 (unknown):
```unknown
<mysnippet.snippet ?"Launch the Bunch in this snippet?"
```

Example 3 (markdown):
```markdown
MyOther.bunch
- myvar = my value
```

Example 4 (markdown):
```markdown
# Launch the Work fragment of Comms.bunch
# after a 30-second delay
<Comms.bunch#Work ~30

# Ask if we should load the Social fragment
<Comms.bunch#Social ?"Is Social Media a good idea right now?"
```

---

## Bunch Files - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files//

**Contents:**
- Section Contents
    - See Also:

The Bunch menu is created by reading text files from your Bunch folder. To show up in the menu, the file just has to have the extension .bunch. Bunch files contain apps to launch, URLs to open, commands to run, and more. Learn more about the syntax and features below.

You can edit Bunch files in any text editor. That includes TextEdit, but if you’re using TextEdit (or any app that has a Rich Text mode), be sure to switch to Plain Text mode. In TextEdit, that’s under Format->Make Plain Text.

All materials copyright © Brett Terpstra 2021

---

## Keystrokes - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/keystrokes/

**Contents:**
- Sending keystrokes and combos
  - macOS 10.14 (Mojave) and Older
- Sending Key Combinations
  - Repeating Keys
  - System Key Names
  - Sending Global Key Combinations
  - Adding Pauses to Key Combos
- Typing Strings
  - Adding Pauses to Typed Strings
  - Using Variables in Typed Strings

Bunch can send keyboard commands and strings directly to applications, triggering keyboard shortcuts or entering entire strings.

If you’re running macOS 10.15 (Catalina) or newer, Bunch makes use of CGEvents to send keystrokes and key combinations very quickly to apps, even if they’re in the background. This is the ideal way to perform these functions; it’s fast and reliable. But…

If you’re on 10.14 (Mojave) or older, Bunch doesn’t have a reliable way of making sure the app is ready to receive keystrokes while it’s running, so it uses Apple Events, which queue up and wait until the app is ready for them. This is slower and can have significant pauses.

If a file parameter (a dashed line after app name) is surrounded by curly brackets ({}), it is read as a sequence of keyboard shortcuts which are sent to the app. These allow special symbols for modifier keys:

* The Hyper key is a custom key that sends Control, Shift, Option, and Command all at once. It’s the equivalent of ^$~@.

If you want to actually send any of these special keys as part of a key combination, just use the Shift Number equivalent. E.g. to send an actual dollar sign, use $4, or to send a command-%, use @$5.

Example: The Git app Tower doesn’t respond to the AppleScript “close every window” command, so using - XX doesn’t work. Instead, you can send the “Close All Windows” shortcut, Command-Option-W, to the app like this:

To send multiple shortcuts, just separate them with a space, i.e. {@a @c @$~v} to select all, copy, and paste without formatting in the specified app.

You can include system keys (arrows, delete key, function keys, etc.) by using their name, such as @~up (Option-Command-Up Arrow) or @$F12 (Shift-Command-F12). These can also be written as hyphenated strings using the longer formats for modifier keys, e.g. cmd-opt-up or even command-option-up. This format can still be combined with multiple keystrokes separated by spaces, e.g. {opt-left cmd-up} to hit Option-Left Arrow followed by Command-Up Arrow.

Keys can also be referenced by using their Unicode symbols like ↑, ↓ ⌅, and ␣.

Because double quotes are used for typing strings within curly brackets, if you need to send a key combo containing a double quote, specify it as $' (Shift-single quote).

You can repeat key combos multiple times by surrounding them in parenthesis immediately followed by a number. To hit ⌘} to switch tabs 5 times, you would use {(@$])5}. Multiple key combinations can be listed within the parenthesis, so {@t (@d @$d)4} becomes {@t @d @$d @d @$d @d @$d @d @$d}. If you want to see a dumb trick, try that one with iTerm.

The following names are recognized:

The standard way to use key combos is to send them to a specific application, as shown above. It is possible, though, to send a global key command that will trigger any actions, services, or apps with global listeners. To do so, just put the key command on its own line with no preceding dash:

That sends ⇧⌘F1 as a general keystroke. You can trigger global key combos when closing a Bunch by using the “double negative” syntax:

You can include a pause in a key command sequence using ! immediately followed by a number, e.g. !2 for a 2-second pause. So to hit ⌘N to create a new window, then wait a few seconds for the window to load before continuing, you would use:

The delay must be a positive integer representing a number of seconds, with no decimals.

You can also type strings in a specific app using square brackets ([]). To open TextEdit, create a new document, and type out “Testing something,” you would use:

(You can also combine these two lines now, see the next section.)

You can use “escape” codes (letters preceded by a double backslash, e.g. \\n) in a typed string to press some “special” keys:

Example: - [\\n\\n\\tThis has two newlines and a tab indent before it\\n]

Tip: If you want to send a lot of special characters while typing, it’s often better to use the bracket syntax and quote the typed strings, e.g. {(tab)3 "my text" return @s}.

You can pause typing for any number of seconds using \\! followed by a number within a typed string (this works in interpolated strings as well):

The delay must be a positive integer representing a number of seconds, with no decimals.

If you want to insert the contents of a variable in a typed string, you should use the /typed transform to ensure that newlines are converted to \\n when typing it out.

You can also include typed strings within the curly brackets notation for key combos by surrounding the text you want to type with double quotes. These are treated like square bracket lines.

Minimum OS Requirement: typing text strings within curly brackets does not work well on 10.14 (Mojave) or earlier. If you’re on an older version of macOS, stick with sending key combos in curly brackets, and typed strings in square brackets on separate lines.

The example in the above section can be condensed down to:

To send an email in MailMate, you might use something like:

In addition to the ! syntaxes above, you can pause between strings by inserting a file line between key commands containing (pause 5) (for a 5 second pause). The delay must be a positive integer representing a number of seconds, with no letters or decimals.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
Tower
- {@~w}
- ~/Code/Bunch
```

Example 2 (markdown):
```markdown
Gradius
- {↑ ↑ ↓ ↓← → ← → b a ↩}
```

Example 3 (elixir):
```elixir
TextEdit
- {@n !3 "This is a new window"}
```

Example 4 (elixir):
```elixir
TextEdit
- {@n}
- [Testing something]
```

---

## Multiple Choice - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity/multiple-choice/

**Contents:**
- Multiple Choice Dialogs
- Query Arrays
- Query Dictionaries
- Checkbox Arrays
    - See Also:

You can easily define multiple-choice dialogs using simple syntax in your Bunch. You can use these to choose snippets to load, scripts to run, or variables to include.

These syntaxes will be familiar to coders, but should make sense to anyone once you get the hang of it.

Both of the syntaxes below start with a question mark as the first character on the line. This syntax won’t work as an indented Waiting Snippet, but they work in other snippets, so you can call them from a Waiting Snippet. They also work as on-close snippets; just precede the question mark with an exclamation point.

Choosing an item and clicking OK with either syntax will execute that item as if it were included directly in the Bunch. Clicking Cancel will remove the line from the Bunch.

Items executed will be treated as part of the Bunch, meaning they will be quit on close and will prevent other Bunches from quitting them while the Bunch is open.

The simplest syntax for multiple choice is an “array,” which is just a list of items. Whatever the name of the choice is, that’s what will be run, so it’s mostly useful for selecting apps by name.

An array is defined by ?[...]. Items in an array are separated by either a comma or a newline, whitespace (indentation, blank lines) is ignored.

You can optionally include a title for the dialog after the closing bracket in double quotes on the same line as the right bracket.

By combining this with variable assignment, you can have the list directly choose a snippet fragment to run. The following example assigns a snippet variable, then uses that to call a fragment of an embedded snippet.

If you want to display a menu with more complex commands with nicer wording, use the “dictionary” syntax. This is a list of keys (menu titles) and values (commands that item runs) surrounded by curly brackets ({}). The menu is built from the keys, and whichever item is selected, the value for that item will be inserted into the Bunch and run as if it were included to begin with.

The values can only be a single line, but they can be snippet import statements, so you can use them to branch the launch of entire subsets of items.

Dictionaries are defined by ?{key => value}. The separator between key and value is equal sign (=) greater than (>), known in programming as a “fat arrow.” Entries are separated by comma or newline (or both), whitespace (indentation and blank lines) is ignored.

Here’s a query included in a “Coding” Bunch that asks me which project I’m tackling, then loads snippets for each answer.

If you’d like multiple choice dialogs using checkboxes, you can use the Checkbox Array syntax. This consists of GitHub-style checkboxes followed by a title and the snippet or app to load.

Start the lines with -[ ]. If the brackets contain “x” (-[x]), the checkbox will be initially checked. Title and value are separated by =>.

If the (=>) is omitted, the contents of the line will be used for both the item title and the returned value. This can be used to easily offer a list of optional apps to load:

Add one checkbox item per line. All consecutive lines will be grouped into one dialog, empty lines between items are ignored. If you want to create separate dialogs from multiple groupings of options, separate the groups with a horizontal rule (---) or a line starting with at least two hashes (## A divider line).

Checkbox Arrays do not work in on-close Snippets — they can only be used when opening a Bunch.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (lua):
```lua
?[Omnifocus, Things, TaskPaper] "Which Task Manager?"

# or...

?[
    Omnifocus
    Things
    TaskPaper
] "Which Task Manager?"
```

Example 2 (bash):
```bash
snippet = ?[
    First
    Second
    Third
]

<<#${snippet}
___
#[First]
// do something

#[Second]
// do something else

#[Third]
// you get the idea
```

Example 3 (scala):
```scala
?{
    Marked => <coding.snippets#Marked
    Bunch => <coding.snippets#Bunch
    nvUltra => <coding.snippets#nvUltra
} "Whatcha Coding?"
```

Example 4 (scala):
```scala
-[x] Option 1 => <<#One
-[x] Option 2 => <<#Two
-[] Option 3 => <<#Three
___
#[One]
(log Snippet One)
#[Two]
(log Snippet Two)
#[Three]
(log Snippet Three)
```

---

## Display - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/display/

**Contents:**
- Display Command
- HTML Files and Websites
- Text Files
- Other File Types
- Customizing the Window
    - See Also:

The display command is used to open an HTML file, website, or text/log file in a viewer. The command allows for flexible window sizing and positioning. In it’s most basic form it’s just display and a filename:

If the file is in your Bunch folder, it can be a relative path1. The above command would show a 600x600 web view centered on the main display. Read on to learn about the myriad options.

The display command can display HTML files and web URLs. You can provide a full path to a file, or one relative to the current Bunch Folder. For a website, just provide a full URL.

If the file is either a local HTML file (which must have the extension .html) or a URL, it will be viewed in a popup web view that floats above all other windows and can be dismissed with either Enter or Escape. It’s clickable and scrollable.

This is not a “web browser.” However, you can navigate to links, there are back, forward, and refresh buttons, and you can interact with sign-ins and forms. It’s primarily designed for displaying, as the command name indicates, but it can replace opening a browser in a lot of situations. In situations where it’s appropriate, this avoids having to open (possibly duplicate) browser tabs for task-related sites. Think of it as a lightweight Single Site Browser (SSB).

Tip: If you point to a local server with LiveReload enabled, the preview will update appropriately. That makes it a decent preview for writing, say, documentation built on Jekyll (ahem), without opening a tab in your browser.

(display http:​//127.0.0.1:4000/bunch/ 1200x100% right,top)

If you want to use the WebKit Web Inspector on a web display window, you can do it through Safari. If you have the Develop menu enabled, any open Bunch web views will show up under your host name in that menu.

A web view allows navigation to any link. If you’d rather open a link in the web view in your default browser, hold down Command (⌘) when clicking it.

Navigate backwards and forwards with the < and > buttons, or use ⌘[ and ⌘].

Refresh the view with the “Reload” button, or hit ⌘R.

Press the Home button in the toolbar (or hit ⇧⌘H) at any time to return to the URL originally specified for the display command.

If the initial window width is less than 1024, a mobile user agent string will be sent to any remote url requests. This can be overridden (or forced) by using ua:desktop or ua:mobile.

If a file is specified with the extension .txt or .log, it will be displayed as a text file with a monospaced font. The file is watched for changes and the preview will automatically update. The preview will “tail” the file, always scrolling to the end when it changes. Only the last 10,000 characters of the file are displayed.

ANSI escape codes are recognized and rendered. If the file you’re watching contains escape codes, it’s wise to set a background color appropriate for the display of the codes. See below for details on adding colors.

As an example, if your Bunch triggers a shell script that has logging, you can use the display command to tail the log in a floating or desktop-level window.

Use the Pause button to pause watching for file changes (and thus pause the window updates). When you click Resume, all changes that accumulated while paused will be shown.

Note that if you want to preview Markdown or other text markup as HTML files, you should render it to HTML using your processor of choice. Point the display command to the resulting HTML file. That file will be watched for updates, so if you have a script running that refreshes the file, the preview will also refresh.

If the file is any kind other than HTML, it will be viewed using a Quick Look preview. The preview will be contained in a window that can be sized and positioned like the other display windows.

This works for any file that has a Quick Look plugin (pressing ⌘Y on it in Finder shows you a preview). It can be used to display images, Pages files for reference, audio files, or just about anything you can throw at it.

This command was primarily created so I could show some welcome documentation, but it grew from there. Now you can use it to display a local log file, the image output of a shell script, or load up a website that you want to have floating while you work (or play). The latter is the most likely use for the average user. Bunch will store logins between launches, so once you’ve logged into a service like Facebook for messaging or Clockodo for time tracking, you can pop up a window when you open a Bunch to have the tools you need at hand, in a floating window, without opening them in your browser.

You can define which display to open the window on, what size it should be, what position on the screen, foreground and background colors (for text files), and set the window’s opacity. All parameters are optional. Except in the case of shell scripts, the first parameter must be the path to the file. Other parameters can be in any order.

Any of these may be omitted. Each parameter must be preceded by a space.

All options can be abbreviated to one letter, i.e. alpha:90% can be written as a:90%, display:1 can be shortened to d:1.

A display command that uses every option would look like the below. This command displays a text file as a desktop-level “visor” (full-width window at stuck to the top of the screen) on the second display with a light-on-dark color scheme and slight transparency.

Tip: If you leave size and position empty, it will create the window with default settings. Resize and position the window to your liking, then choose “Copy Dimensions of Active Window” from the Bunch menu. A compatible string containing that window’s new dimensions and position will be copied to your clipboard for use in the (display) command.

You can specify that the window open on any connected display. Displays are numbered from left to right, starting at zero. Your leftmost display will be 0, counting up as you move to the right. The command expects a single digit between 0 and 9. (If you have more than 10 displays, I have some followup questions.)

If you specify a screen number higher than the number of attached displays, your main display will be assumed. This means that you can specify a display that isn’t always available, and Bunch will use it when it is, but default to your primary display when it’s not.

The parameter must be preceded by display: but can be shortened to d:

To put a centered window on your second monitor: (display myfile.html d:1 800x800)

To set the size of the window, include a size parameter in the form of WxH, e.g. (display myfile.html 800x600). If this is omitted a default size will be assigned.

You can specify these as percents, with a minimum of 10% and a maximum of 100%: (display myfile.txt 25%x100%). These can be mixed with integers: (display myfile.txt 500x100%).

You can use full in place of 100%: (display myfile.txt 500xfull) displays a 500pt-wide window the full height of the display.

Set a location on the screen using either coordinates or words. The format is X,Y (no space around comma), e.g. (display myfile.html 800x800 left,center).

You can mix integers and words, e.g. : (display myfile.html 500x900 right,800)

integer: X points from origin. 0,0 is the bottom left corner of your screen, and the measurement is to the lower left corner of the window, so 100,500 puts the left side of the window 100 points from the left of the display, and the bottom of the window 500 points from the bottom of the display.

Distances are relative to the bottom left corner of the selected display. Unlike setting a frame using AppleScript or other tool, you don’t have to calculate the width of the first display and add to it to target the second display. Just set the screen number and base your coordinates off of 0,0.

left, center, right: For the X (first) parameter, you can use left, center, or right. These will put the window flush against either side, or centered horizontally. These can be abbreviated as l, c, and r.

top, center, bottom: For the Y (second) parameter, you can use top, center, or bottom. These will put the window flush against the top or bottom of the screen, or vertically centered. These can be abbreviated as t, c, and b.

You can specify a background and foreground color using 3 or 6-character RGB hex codes, starting with #. If only one is specified, it becomes the background color, if two are given, it’s read as BACKGROUND FOREGROUND.

When used with text/log files, background and foreground will accurately set the colors of the display. If a foreground color is omitted, a color that contasts the background will be automatically generated.

With other display types (web, quick look), setting a background color greater than 50% black will cause the window chrome to display in Dark Mode. Foreground color is ignored in these cases.

Example: (display myfile.txt 800x600 #000 #eee)

When specifying a background for a Quick Look display window (any file type other than text or HTML), you can use #clear as the background color to create a transparent window.

Specify an opacity for the window using alpha:XX%. This can be abbreviated as a:75%. Opacity must be between 0 and 100.

Example: (display https://youtube.com 800x600 right,top a:90%)

By default the window behaves like any standard window, clicking it brings it to the front, clicking other windows brings them in front of it. You can make it a floating window (nothing can come in front of it), a desktop window (always behind other windows), or a wallpaper window by adding level: followed by floating, desktop, or wallpaper at the end of the command. level: can be abbreviated as l:, and the options can be abbreviated to f or float, d or desk, and w or wall. To have it behave as a normal window, leave it empty or use n or normal.

A wallpaper level window is not clickable or scrollable and gets no toolbar with close button. Wallpaper windows are closed when the Bunch closes. If you don’t have Toggle Bunches enabled, you have to use Close Items In… to close a wallpaper window opened by a Bunch.

Tip: As an alternative to the (wallpaper) command, you can simulate a wallpaper change by displaying an image at full width and height and setting it to wallpaper level. While the Bunch is running, it will appear you changed the wallpaper, and it will change back when the Bunch closes.

Make a window “chromeless” with chrome:none (or c:n) and it will display a window with no title bar or close/zoom buttons. The window is still be resized from the edges and is draggable (see below). Chromeless windows can be closed with ⌘W.

This setting affects window dragging in the various preview types differently.

“chrome:none” or “c:n” are the only accepted options. Other syntax will be left in the command and will break the path if unintentional.

Example (display my presentation.keynote 600x1000 chrome:none)

In Quick Look previews, hovering over the window will display the title and “traffic light” buttons.

Applies only to web views. By default, if a window has an initial width less than 1024, a mobile user agent string will be sent, indicating to the site that you’re on a mobile device. This often provides a better experience for viewing websites in small windows, simulating an phone or tablet screen. There are times you may want to override this, though, and you can do so using ua:desktop to force desktop mode, or ua:mobile to force mobile.

In the case of Facebook Messenger, for example, sending a mobile user agent makes the site only offer the option to download the iPhone app. To use Messenger in a display window at a narrow width, add ua:desktop to the command.

Example (display https://messenger.com ua:desktop)

This parameter can be abbreviated as ua:d or ua:m.

Tip: Display a “visor” of system.log on secondary display as a desktop-level window:

The log file will be watched for changes and the window will automatically update, “tailing” the file.

Remember that relative paths in Bunches within subfolders are relative to the base Bunch Folder, not the containing subfolder. ↩

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(display myfile.html)
```

Example 2 (json):
```json
(display myfile.txt display:1 100%x500 left,top #111111 #efefef alpha:97% level:desktop)
```

Example 3 (json):
```json
(display Desktop.png d:1 100%x100% l,t l:w)
```

Example 4 (json):
```json
(display /var/log/system.log d:1 100%x300 left,b #333 #b0d17d a:95% l:d)
```

---

## Frontmatter - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/frontmatter

**Contents:**
- Controlling Bunch With Frontmatter
- YAML-ish
- Available Keys
  - Bunch Scheduling
  - Bunch Behavior
  - Setting a Shortcut Key
  - Customizing Menu Display Title
  - Customizing Menu Order
  - Adding Menu Dividers
  - Hiding From the Menu

You can use frontmatter at the top of your Bunch to do things like change the menu display title or schedule launches on a repeating basis.

Frontmatter goes at the very top of a Bunch, and is fenced off by three dashes (minus symbol) at the top and bottom. Within the fence is a series of keys and values separated by colons.

Bunch treats keys the way MultiMarkdown does: it allows spaces and is case insensitive, but they’re compressed and lowercased when read in, so Open at becomes openat. Feel free to make your keys as readable or as efficient as you like. Unrecognized keys have no effect and are saved as arbitrary variables available to snippets.

Bunch frontmatter resembles YAML, but it’s a simplified system. Spaces are allowed in key names, but they are removed when the variable is read in. All keys are lowercased. If your line is First Name: Brett, the variable would be accessed using ${firstname}. However, spaces are also removed from variable placeholders when looking up the value, so ${first name} will also match.

Bunch frontmatter doesn’t support the more complex structures of YAML, such as arrays and blocks. It’s simply single-line keys and string values.

Here are the available keys:

See Scheduling Bunches for details on the open ... and close ... keys.

To learn more about sequential and parallel execution with the sequence key, see Execution Sequence.

The startup key can be set to true, false, or ask. (or yes/no/?) and has the same effect as adding a bunch name to a *.startup script. If set to ask, a confirmation dialog will pop up before opening that Bunch.

Setting single bunch mode: ignore will prevent the Bunch from affecting or being affected by the launch of other Bunches in Single Bunch Mode. This allows you to use Single Bunch Mode to quit one Bunch when opening the next, but have Bunches that can be always-on.

Setting toggles: false will only allow the Bunch to open, but will never register it as Open, meaning it can’t be closed. It won’t get a check mark in the menu, it won’t be remembered as an open Bunch if “Preserve Open Bunches” is on, and other Bunches can’t close it. Apps it has open won’t be registered by other Bunches, and it won’t prevent other Bunches from quitting them. (If you like it better semantically, you can also use only opens: true.)

Setting ignores state: true will allow Bunches to re-open or re-close when scheduled. Normally if a schedule is set for a Bunch to open or close and it already is, that schedule is ignored. With this option set you can have the Bunch re-launch or re-close, restoring the launched or quit apps and running scripts on a schedule. This setting functions independently of toggles/only opens.

Setting quit apps: always will force the Bunch to quit apps it opened regardless of whether the app is open in another Bunch. This correlates with the “Quit Apps Open in Other Bunches” global preference, but allows enabling this on a per-Bunch basis.

Bunch has full keyboard control. Assign a Hotkey key in preferences to open the Bunch menu, and then use keyboard shortcuts to open your Bunches. By default Bunches are given numbers as shortcuts, from 1 to 9 and then 0, assigned in menu display order. Subsequent items are assigned Command-Number, from ⌘1 to ⌘0. You can customize these using the shortcut: frontmatter key.

A shortcut can be anything other than a number, and can include modifiers (control, option, shift, command). A capital letter automatically implies the Shift modifier.

Modifiers are not required and single keystrokes work great for launching Bunches. Just assign shortcut: a, then hit the hotkey to open the menu and type “a” to open the Bunch.;

Modifiers can be specified using symbols:

To use any of these symbols as the actual modifier key, use the Shift-equivalent, i.e. $ would be $6 (Shift-6), and @ would be $2.

To set a menu shortcut of Command-T for your Bunch, you would include this in the frontmatter:

Shortcuts can also use words in the format option-command-t.

If you duplicate a shortcut between two Bunches, only the first one (in menu order) will get the shortcut. The conflicting Bunch will fall back to the auto-assigned numeric shortcuts.

The “title” key changes the display title of the Bunch, as seen in the menu. When calling the Bunch from any other Bunch, you’ll still use the filename.

You can totally use emoji in the frontmatter title and get a sweet looking menu 😁. The menus are sorted alphabetically by display title, so changing the title: key will change the sort order of the list. Sort order ignores emoji, so 😊Bunch A still comes before ♥️Bunch B.

You can also use the “title prefix” key to add a prefix to the display title. If no “title” key is set, this will prefix the filename in the menu title.

The “title prefix” key can be set in tag or folder frontmatter and will apply to all files affected. If multiple tag/folder prefixes apply to a single Bunch, the prefixes are concatenated. The order of concatenation can’t be controlled, but this allows you to use tags to actually “tag” menu items visually.

The “menu order” key defines the sort order of Bunches in the menu that Bunch displays.

Any Bunch with a “menu order” number between 1 and 99 will be sorted by number at the beginning of the menu. If multiple Bunches have the same number, they will be sorted alphanumerically (by display title) within that position.

Bunches without a menu order value will be sorted alphabetically after the numbered bunches.

Bunches with a menu order greater than 99 will be sorted by number and appended to the end of the list. Adding menu order: 100 to a Bunch will force it the the end of the list. Duplicate numbers are sorted alphanumerically.

Tip: If you increment your menu order numbers by 5 or 10 when first starting out, you’ll have room to stick new ones in or move them around without having to re-order everything. E.g. put your top menu item at 10, second one at 20. Then if in the future you want something else at the top of the list or between those two, you can just put it at position 5 or 15 and still have room to fit 4 more in either direction before you have to go through and renumber everything.

You can use the menu divider key to add separators to the Bunch menu. The key can be set to before or after, determining whether the inserted divider comes before or after the Bunch in the menu.

You can use the keys “ignore,” “ignore if,” and “ignore unless” to prevent a Bunch from displaying in the menu.

The “ignore” key is a boolean, either “true” or “false.” If it’s true, the Bunch will not show up in the menu (nor will it be able to be triggered by shortcut key, it’s ignored).

“ignore if” and “ignore unless” take a UUID or a condition.

A UUID is a unique identifier for each Mac. You can get the UUID for the current machine by opening Preferences and pressing “Copy UUID.” The value of startup if: can be a single UUID, or multiple UUIDs separated by commas.

You can use frontmatter to run scripts before and after opening and closing the Bunch. Because variables are defined before any script items are run within the Bunch, it may be useful to have some scripts run prior to processing variables that may read from that script’s output. For example, if you needed to pull some JSON data from an API and populate a text file that could then be read into a query dialog, you would want to run the script that populates the text file before the variable assignment that reads it. See this advanced script for an example.

To run scripts before doing anything else in a Bunch, use the run before: key. The value should be a comma-separated list of shell or AppleScripts to execute. Each script can include arguments. If you don’t provide an absolute path to the script (tildes can be used for your home directory), Bunch will assume the script is relative to your Bunch Folder.

To run scripts after processing all of the items in a Bunch, use run after:.

To run scripts when closing a Bunch but before processing any on-close items, use run before close:.

To run scripts after performing all on-close operations and terminating any other running scripts, use run after close:.

You can add tags to a Bunch using the tags: key:

These tags can be used for organizing Bunches into groups, allowing you to control multiple Bunches at once from the Bunch menu.

You can also open and close tagged groups of Bunches from within a Bunch using \tagname. See the documentation here.

You can add arbitrary key/value pairs in the frontmatter. These will be stored and passed as default values to Bunches, snippets, and scripts. For example, if your snippet had a variable ${say} in it, and the calling Bunch had a say: line in the frontmatter, that value would be passed unless specifically passed as a variable to the snippet.

The order of precedence for snippet variables is: variable defined after the snippet line, then value found for matching key in the frontmatter, then anydefault value defined in the snippet.

These variables are available in Snippets and as environment variables in shell scripts. They are not passed to Automator Workflows because those will error out if given unexpected variables.

In addition to hard coding frontmatter keys and values, you can set them on the fly using several flexible options.

You can use dialogs to set values for frontmatter keys interactively when the Bunch opens. See Interactivity->Variables for details.

When calling a Bunch from another Bunch or via the URL handler, you can pass key/value pairs to override hard coded (or missing) frontmatter keys for use in ${variables}.

If using ${variables} in a Bunch, be sure to include default values (${variable:default value}) or hard coded frontmatter values for the keys for when the Bunch is called directly from the menu and can’t have values passed to it.

You can use from file and from script to load in variables from external sources.

A frontmatter line such as from file: filename.txt would read in additional values from filename.txt. Paths are assumed to be relative to the configured Bunch folder unless they’re absolute paths.

Remember that relative paths in Bunches within subfolders are still relative to the Bunch Folder, so if you want to reference filename.txt located in a subfolder, you should use from file: Subfolder/filename.txt, even if the Bunch itself is already in Subfolder.

The contents of filename.txt should be only colon-separated key-value pairs. This allows external automation to write data to files that affect your Bunch without having to modify the Bunch itself. A file called in this manner will be watched for updates, and the Bunch will be automatically updated if the file changes.

You can also run a shell script, which should also return just key: valuepairs. Most scripting languages have a YAML library that makes it pretty easy to easily output data in a suitable format. Lines with YAML separators (---) will be ignored.

When one of these keys is detected, the file or script results will be merged with the other keys, if any, overwriting values for existing keys.

Frontmatter is only updated when a Bunch is opened, when a change is made to the Bunch file itself, or when an imported file is changed. Changing a referenced script will not trigger an update, but the new data will be parsed before any additional snippets or scripts are opened.

You can also incorporate dialogs in a frontmatter script. See advanced scripting for an example.

Just to demonstrate the capability of dynamic frontmatter, you could have a line in your frontmatter that reads additional data in from a script called frontmatter.rb:

The file frontmatter.rb would exist in your Bunch folder, so no path would be needed. It would do something like:

The above script picks a random name and adds the current date. Now when the Bunch is read in, the frontmatter it actually stores looks like:

Which means that in any snippets that are called within the Bunch, you can reference the name and date variables. Let’s load a snippet called test.snippets that contains:

Reference that snippet in the Bunch but don’t define either of the variables:

When it runs, the name variable will be replaced with a random name, and the current date will be passed. It will update every time the Bunch opens. This is obviously stupid, as you could have just written a script that said this without populating variables and importing snippets, but it illustrates how dynamic frontmatter can work.

See Advanced Scripting for more crazy ideas.

You can apply frontmatter to multiple Bunches using folder and tag frontmatter.

A file called folder.frontmatter can be included in the Bunch folder or any subfolder. This file is primarily designed for use in subfolders to control submenu display, but it can also contain keys that affect all Bunches in the folder (including the base Bunch Folder).

A folder.frontmatter file is just a text file containing frontmatter keys and values. The keys title, menu divider, and ignore only affect the submenu item, and the keys shortcut and tags are always ignored. All other keys are applied to every Bunch in the folder.

This means that you can create a subfolder for Bunches you want to launch at a specific time, and then any Bunch you put in that folder will get an open at schedule applied.

If I have a folder called “Morning” and it contains three Bunches that I want launched at 8am, I could add a folder.frontmatter file to the folder and have the open at it contains applied to all three Bunches.

Note that it’s a good idea to ignore Single Bunch Mode if you’re going to be batch opening multiple Bunches on a schedule. If Single Bunch Mode is enabled, each one that opens will immediately close the one before it.

This allows for some batch manipulation of Bunches, and means that if you have a key you want applied to multiple Bunches, you don’t have to edit them all individually. It does mean that those Bunches have to appear in a submenu, but then modifying which Bunches have the key is as simple as moving a Bunch in or out of that folder, and changing the key for every Bunch is just a matter of editing one file.

This can also be used to apply arbitrary keys to groups of Bunches. An entire folder of Bunches can have a variable assigned, and then modifying that variable for all Bunches can be done just by editing folder.frontmatter.

Assign an arbitrary key, in this case a default browser:

Then any Bunch in the folder (and any Snippets they contain) can reference that variable.

Now if I want to change the browser for any of the Bunches in that folder using that variable, I just edit default browser in folder.frontmatter.

folder.frontmatter files can exist in the root of your Bunch folder as well. Submenu keys like ignore and title are ignored, but arbitrary keys assigned in that file will apply to all Bunches in the root folder.

Another way to apply frontmatter to multiple Bunches is to use tag frontmatter. If a file beginning with @tagname.frontmatter exists, its frontmatter will be applied to all Bunches tagged with tagname.

Some keys such as “title prefix” and “ignore if/unless” are concatenated when they appear in multiple frontmatter. This allows you to assign an “icon” to each tag (with “title prefix”), and have menu items labelled with those icons, or to use tags to ignore (“ignore if/unless”) sets of Bunches on different machines.

UUID can be retrieved using “Copy UUID” in Preferences. ↩ ↩2

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 📞Comms
open at: 8am
startup: true
---
```

Example 2 (yaml):
```yaml
---
shortcut: @t
---
```

Example 3 (yaml):
```yaml
---
title: Just A Bunch
menu order: 10
menu divider: after
---
```

Example 4 (yaml):
```yaml
---
title: Script Example
run before: prescript.sh arg1, otherscript.sh arg2
run after close: postscript.sh
---
```

---

## Startup Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/startup-scripts/

**Contents:**
- Auto-launch Bunches on startup
- With .startup Scripts
- With Frontmatter
  - Interactively
  - Selectively for Synced Macs
  - Batch Launching
- Conflicts
    - See Also:

You can launch Bunches automatically whenever the app starts. This can be useful if you have Bunch set as a Login Item and you have a set of apps you want to launch every time you log in. By using Bunch to do this rather than adding them to the Login Items as well, you can easily quit apps in groups, as well as access Bunch commands and scripts.

There are two ways to launch a Bunch on startup. The first way is with a dedicated “startup script.”

To launch Bunches on startup, create a file in your Bunch directory with the extension “.startup”. Any filename will work, and all files ending in “.startup” will be processed.

The file should contain a list of Bunches to launch, one Bunch per line. The “.bunch” extension is not required. Note that these startup files can only contain names of Bunches to launch, not regular Bunch lines of any kind.

If you have Single Bunch mode enabled, only the last item processed will be launched. Otherwise all lines of all “.startup” files will launch, not that you’d ever need more than one…

You can also add a startup: true key to the frontmatter of any Bunch to have it open when Bunch launches. All Bunches with startup: true will be opened after any .startup files have been processed.

If startup: is set to ask, a prompt will be displayed on launch. Cancelling that prompt will skip opening the Bunch.

If you sync your Bunches to multiple Macs, you may want to specify which Mac(s) run the Bunch as a startup script. To do this, open Preferences and press the “Copy UUID” button. Paste the result as the value of the startup: key and the startup will only be triggered on the Mac that matches this value. Multiple UUIDs can be combined with commas.

You can also use startup unless: instead of startup:. This has the inverse effects for excluding specific Macs by UUID.

You can use folder.frontmatter to apply startup: true to all of the Bunches contained in a subfolder. This makes adding and removing Bunches from startup as easy as moving them in and out of a folder. Just create a subfolder and add a file called folder.frontmatter to it. Include the startup: true key in that file and it will be applied to all of the Bunches it contains.

Be careful when auto-launching Bunches that quit other Bunches, as this can lead to unexpected behavior. Bunches are launched asynchronously, so you can’t be sure what order the events will happen in. Avoid having !Name.bunch lines in any Bunches launched by a startup script.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: My Startup Bunch
startup: true
---
MailMate
Messages
```

---

## Running Automator Workflows - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/automator-workflows

**Contents:**
- Running Automator Workflows
- Using Variables
    - See Also:

If a line starts with an ampersand (&), it will be run as an Automator workflow. These should be created in Automator as a Workflow, and saved with the .workflow extension.

Note that all Workflows for Bunch must have a variable named “Bunch” defined. See the Using Variables section for instructions on adding a variable to a Workflow.

In your Bunch, you can specify a full path to a Workflow like this:

…but if the workflow is in the same folder as your Bunches, you can just list its filename, with or without .workflow. For example, if my Bunch folder contained Do Something.workflow, I could use a line in my Bunch with simply:

If you want to keep a subfolder of Workflows in your Bunch folder, just reference them with a relative path, e.g.

You can pass variables to a workflow the way you pass files to an application in Bunch, using hyphens below the line that calls the workflow, one variable per line:

The spacing around the = doesn’t matter, as long as there is a single key and a value. Additional = in the line will be included in the variable value.

To use these in Automator, they must exist in the workflow; if you pass a variable that doesn’t exist, the workflow will not run. Simply open the Variable palette in Automator by clicking the “stack” button at the bottom of the window, right click in the table view, and select “New Variable”. Make the variable name exactly the same (case sensitive) as the variable you’re passing from Bunch. Now, when the workflow is run, that variable will be populated automatically by the lines in your Bunch.

The variable “Bunch” is automatically populated with the name of the opened Bunch, but you have to add an empty variable with this title or Bunch will get an error when it tries to populate it.

In combination with “Run Shell Script” actions, “Bunch” and your custom variables can be used to run different actions based the arguments provided, allowing re-use of the same workflow in multiple Bunches.

See the Bunch and Timing post for details.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
& ~/Dropbox/MyWorkflow.workflow
```

Example 2 (unknown):
```unknown
& Do Something
```

Example 3 (unknown):
```unknown
& workflows/Do Something
```

Example 4 (markdown):
```markdown
& Do Something
- variable1 = Contents of var 1
```

---

## Running Automator Workflows - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/automator-workflows/

**Contents:**
- Running Automator Workflows
- Using Variables
    - See Also:

If a line starts with an ampersand (&), it will be run as an Automator workflow. These should be created in Automator as a Workflow, and saved with the .workflow extension.

Note that all Workflows for Bunch must have a variable named “Bunch” defined. See the Using Variables section for instructions on adding a variable to a Workflow.

In your Bunch, you can specify a full path to a Workflow like this:

…but if the workflow is in the same folder as your Bunches, you can just list its filename, with or without .workflow. For example, if my Bunch folder contained Do Something.workflow, I could use a line in my Bunch with simply:

If you want to keep a subfolder of Workflows in your Bunch folder, just reference them with a relative path, e.g.

You can pass variables to a workflow the way you pass files to an application in Bunch, using hyphens below the line that calls the workflow, one variable per line:

The spacing around the = doesn’t matter, as long as there is a single key and a value. Additional = in the line will be included in the variable value.

To use these in Automator, they must exist in the workflow; if you pass a variable that doesn’t exist, the workflow will not run. Simply open the Variable palette in Automator by clicking the “stack” button at the bottom of the window, right click in the table view, and select “New Variable”. Make the variable name exactly the same (case sensitive) as the variable you’re passing from Bunch. Now, when the workflow is run, that variable will be populated automatically by the lines in your Bunch.

The variable “Bunch” is automatically populated with the name of the opened Bunch, but you have to add an empty variable with this title or Bunch will get an error when it tries to populate it.

In combination with “Run Shell Script” actions, “Bunch” and your custom variables can be used to run different actions based the arguments provided, allowing re-use of the same workflow in multiple Bunches.

See the Bunch and Timing post for details.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
& ~/Dropbox/MyWorkflow.workflow
```

Example 2 (unknown):
```unknown
& Do Something
```

Example 3 (unknown):
```unknown
& workflows/Do Something
```

Example 4 (markdown):
```markdown
& Do Something
- variable1 = Contents of var 1
```

---

## Running Shell Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/shell-scripts/

**Contents:**
- Running Shell Scripts and Commands
- Scripts
- Embedded Scripts/Heredoc
- Snippets
- Raw commands
- Arguments and environment variables
- Monitoring Scripts
  - Customizing The Task Monitor
- Order of Execution
- Running in a Terminal

Lines starting with a dollar sign ($) are run as shell commands. Anything after the $ will be executed by /bin/sh. This can be a shell script file or a direct command.

Every command a Bunch runs gets its own “shell” and will show up in the menu under “Running Scripts.” Selecting a script in the menu will show you a window with the STDOUT and STDERR of the command, its current status, and buttons for pausing or killing the process. This menu will show scripts for all open Bunches. When a Bunch is closed, its processes are terminated and removed from the list.

If a task monitor isn’t visible for a task, output (both STDOUT and STDERR) from the script will be written to the Bunch Log at Debug level.

Important: in the case of scripts, ensure that your script has a hashbang (a.k.a “shebang”, e.g. #!/usr/bin/env ruby, #!/bin/bash, or #!/usr/bin/osascript -l JavaScript at the top of the file). If your script isn’t set to executable permissions and you call it without specifying the processor, the executable will be determined from the hashbang line.

If the first element of a $ line is a full path to a file, or a path relative to your Bunch folder1, and the file exists, it will be executed directly. This assumes either a binary or an executable file with a proper hashbang in the script. Arguments can be passed on the same line.

Any spaces in filenames or within arguments should be escaped just like they would on the command line, using either double quotes or escaping individual spaces with backslashes.

If the script has a “shebang” line, it will be executed using the specified processor, e.g. #!/usr/bin/ruby will cause the script to be run as /usr/bin/ruby SCRIPT ARGS. If it lacks a shebang, it will be executed using /bin/sh SCRIPT ARGS.

Multi-line scripts can also be embedded using the same heredoc syntax as variable assignment. The contents of the heredoc block will be saved to a temporary file and executed as a script. This allows you to embed multi-line scripts and commands in your Bunch without having to generate external script files for every one.

Heredoc scripts start with $ for shell scripts and * for AppleScripts. If you use $, you should also provide a shebang line (e.g. #!/usr/bin/python) to tell the system what to process the script with. If there’s no shebang, the script will be assumed to be a shell script executable by /usr/bin/sh.

If it’s a * command, a shebang of #!/usr/bin/osascript will be added automatically if one doesn’t exist, so you can just write AppleScript out as if you were in Script Editor.

All lines within a block will be outdented to the indent level of the first line.

Variable placeholders can be used in heredocs. Heredocs do not accept environment variables on file lines following them the way that regular script/command lines do.

You can also use snippet syntax to import shell scripts, allowing for use of fragments to combine multiple scripts into one file (or an embedded snippet).

This works for both shell ($) and AppleScript (*) script lines. In most cases you’ll probably want to just write actual scripts and execute them directly, but if you want to combine multiple scripts with fragment headers or make use of embedded snippets to store scripts for the current Bunch, this syntax will do the trick.

If the content of the $ line is not a recognizable file, it will be executed with /bin/sh -c. It’s possible to chain commands with && and ||.

It’s not recommended that you background commands run by a Bunch (using &).

You can specify direct arguments after the command or shell script path. As with Automator Workflow items, you can also use - ... lines below the script line to set environment variables.

When Bunch launches it checks your default shell ($SHELL) and performs a login in the background to get your usual environment variables. Your path and any custom environment should be picked up before the first time you run a script.

Additionally, the following environment variables are available:

You can fork a script using the $BUNCH variable. If you have a script with common tasks but you need it to differ between Bunches in some way, do something along the lines of (in Bash):

if [[ $BUNCH == Podcast ]]; then...

if ENV['BUNCH'] == "Podcast"

Et cetera. You can also fork on BUNCH_PHASE to perform different tasks when opening and closing a Bunch using the same script.

If you need to provide additional environment variables to your script, include them as “files”:

These will be the equivalent of an export FOO=bar command prior to running your script. If you set HOME, it will override what Bunch sets. If you set PATH, it will overwrite the path that Bunch picked up automatically.

The contents of the Bunch’s frontmatter are also made available as environment variables. For example, if your frontmatter includes Last Name: Meyer, it would be available as $lastname in a shell script. All built-in frontmatter keys and any arbitrary keys defined are accessible.

Remember that you can always manually source your startup or configuration files from your default shell within any shell scripts. For example, if you want to use RVM in a Bunch script, use something like this at the top of the script:

Zsh users will want to note that .zshrc won’t be read by the non-interactive shell that Bunch runs. Environment variables you want picked up should be stored in .zshenv.

Bunch doesn’t do anything with the output of a command other than report it in the log or the task monitor (except in the case of from script frontmatter). If you want to react to shell command output, use Automator with a Run Shell Script action. If you want feedback while running, you can always use AppleScript in your shell script:

Scripts launched by a Bunch show up under “🔴 Shell Scripts” in the Bunch menu. Clicking any script in the list will open a task monitor for that script. The monitor shows STDOUT at the top, STDERR at the bottom, and the status bar shows whether the task is running, paused, completed, or terminated along with any non-zero exit codes.

Closing the window does not terminate the task. Windows can be reopened at any time from the Shell Scripts menu.

The display window understands ANSI colors and emoji in the script or command output.

There’s a Pause button that will suspend the primary task for the monitor. If the primary task is a script that has launched subprocesses (as most scripts do), those subprocesses will not be paused by this button. When a script is paused the button will read “Resume” and will resume the paused task when clicked.

The Kill button will send a SIGSTOP command to the process. This should kill any child processes as well, assuming they haven’t been run in the background by the script. Once a script is terminated or completed, the button changes to read “Restart” and clicking it will re-run the script or command.

Pause and Kill buttons do not appear on windows set to “wallpaper” level. These windows cannot be interacted with, so there’s no point in having buttons. The STDERR output is also set to 20% of the window’s height, as it can’t be manually revealed at wallpaper level.

You can cause a task monitor to display for a task automatically by including (display) at the end of the command:

To use both the task monitor and a delay, the delay must appear after the display:

The display command in a shell command can take the same arguments as the regular display command, just without the file path that the regular command would require. For example, to run a command with a visor-like window on your second display, you can use:

If a background color is specified without a foreground color, a contrasting color will automatically be assigned. If your background color is more than 50% black, the window will be Dark Aqua (dark mode appearance), lighter backgrounds will get regular Aqua (light mode appearance).

All size, positioning, and color arguments are optional, and any combination of them can be used. See the display window documentation for details.

The following runs a script that sets up a local Jekyll server for developing this documentation, with a task monitor in the upper right quarter of my secondary display:

If you have multiple scripts that need to run in order, set the sequence of execution to “sequential.” With this set, you can use | prefixes to launch other items in parallel, if desired, but scripts will wait for the previous script to complete before executing.

As an alternative to using the task monitor, you can send keystrokes to your terminal application to run commands in an interactive shell. The following example works with both Terminal and iTerm.

This sends a ⌘T to open a new tab, then types out commands, pressing return after each.

Remember that relative paths in Bunches within subfolders are relative to the base Bunch Folder, not the containing subfolder. ↩

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
$ say "I'm a shell command!"
```

Example 2 (unknown):
```unknown
$ my\ script.sh "argument 1" arg2
```

Example 3 (bash):
```bash
$ ```
#!/bin/bash
say one
say two
/usr/bin/ruby run_my_script.rb
```
```

Example 4 (sql):
```sql
* <<EOFILE
set source_folder to choose folder with prompt "Please select directory."
-- do some cool stuff
EOFILE
```

---

## Interactivity - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity//

**Contents:**
- Interactive Bunches
- Section Contents
    - See Also:

There are a few ways to add interactivity to a Bunch.

All materials copyright © Brett Terpstra 2021

---

## Scheduling Bunches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scheduling-bunches

**Contents:**
- Scheduling Bunches
- Available Keys
- Schedules, Screensavers, and Sleep
- Open at intervals
- Close After an Interval
- Daily Schedules
  - Opening Daily
  - Closing Daily
- Weekly Schedules
  - Opening Weekly

You can use Bunch like an alarm clock or timer by making use of some frontmatter keys in your Bunch files.

Bunch will always read in these keys and set the alarms and timers when it launches, so it doesn’t matter if you quit the app in between scheduled launches.

Bunches with active schedules will have a timer icon after their title in the menu.

Tip: By default, Bunches that are already open will ignore a scheduled open, and Bunches that aren’t open will ignore a scheduled close. You can override this and have them open or close anyway by using the ignores state: true frontmatter setting.

Bunches scheduled to open or close automatically will work while the screensaver is running or the display is asleep, but will not wake the display or stop the screensaver.

If your Mac is asleep at the scheduled time, it will run when the machine wakes. Bunch will not wake your machine automatically.

The open every key runs the Bunch at timed intervals. The value should be shorthand for hours and minutes to create an interval: 1h30m would run it every hour and a half. You can also just use 1h or 30m.

You can also use “d” to specify days. If you want to launch every other day, use “2d”. This, however, does not allow you to specify a time. So, for most intents and purposes you’ll want to use open at.

It will even let you do seconds (s), if you needed to.

This can be useful for always-open Bunches, though it can be disruptive if launching apps and opening files takes window focus from what you’re working on. This is most useful for small Bunches that use things like Spotlight searches to open files, allowing them to be continually updated.

The close after key defines an interval to wait after opening the Bunch before automatically closing it. It uses the same formatting as open at, e.g. a time string like 1h30m or 1d. This will just start a background timer that will automatically close the Bunch after it’s been open for that period of time.

Closing the bunch manually will cancel the timer. If Bunch is quit, the timer will be lost and reset when the Bunch is opened again (even if it’s restored at launch).

Tip: Keep in mind that you can use % before app names to ignore them when closing. That means your Bunch can do things like turn on Do Not Disturb or toggle Dark Mode and then restore settings after a set period of time. Combine with an open option to toggle things on and off at set intervals. Apps that are already open will be unaffected by Bunch opens.

The “at” commands trigger daily.

The open at key creates a daily “alarm” that will go off at the same time every day, as long as Bunch is running.

Time can be specified with a meridian (am/pm) or as 24 hour time. Whatever time it initially goes off, it will then start repeating at 24 hour intervals. If Bunch isn’t running when the time comes, it will not launch automatically again until the next day.

Multiple times can be listed, separated by commas. To have a Bunch launch at 8am, Noon, and 5pm, use:

You can also use close at to close a Bunch at a set time each day. open at and close at can be used simultaneously. Close at uses the same syntax as open at.

The “on” commands trigger weekly, multiple days are allowed.

You can specify a day of the week and a time to create weekly Bunches, great for end-of-the week reviews, or celebrating the weekend by shutting down Slack.

Multiple days can be listed with a time, separated by commas. Only one time can be used per group of days, but you can repeat the list. To open at different times on Tuesday and Thursday than on Monday, Wednesday, and Friday, use:

Days can be just initial letters or spelled out or abbreviated day names. Single letters can be compressed, longer day names should be separated by spaces. In single-letter form, Thursday must have an “h” and Sunday must have a “u”, e.g. ‘Th’ and ‘Su’. “T” alone triggers Tuesday, and “S” alone triggers Saturday.

To open at two different times on the same day, repeat the day block with a second time:

You can also use close on to close a Bunch weekly at a set day and time. open on and close on can be used simultaneously.

Close on uses the same syntax as open on.

Tip: You can always see what the next scheduled event for a Bunch is by hovering over it in the menu. A tooltip will show up displaying the time of the next scheduled open or close event.

All of the scheduling keys (other than open every) allow natural language dates and times. You can just write 1pm or tue noon and it should figure out what you’re trying to do. You can view the Console to see the confirmation that scheduling is happening. I don’t currently offer a front-end way to see what all is scheduled, but I’d like to eventually.

When launching and closing Bunches on a schedule, Bunch will attempt to show a notification 15 seconds before the action happens. Clicking the notification will cause it to the action to happen immediately, and there’s a cancel button to skip that scheduled launch until the interval comes around again. This notification system is only tested on Big Sur. I highly recommend setting Bunch’s notification style to “Alert” in System Preferences, they work much better for what Bunch uses them for.

If you sync your Bunches to multiple Macs, you may want to be selective about which ones get scheduled. There are two keys that can help with this.

First, schedule if: accepts either a UUID or a logic condition. Because these conditions run before the Bunch actually executes, some logic comparisons may not work as usual. The safest ones are UUID and file [PATH] exists to use a file as a trigger file.

A UUID is a unique identifier for each Mac. You can get the UUID for the current machine by opening Preferences and pressing “Copy UUID.” The value of startup if: can be a single UUID, or multiple UUIDs separated by commas.

Second, schedule unless: takes the same parameters as schedule if: but has the reverse effect. If a condition returns true, scheduling is ignored. If it returns false, scheduling is enabled.

A Bunch this is removed from the menu by an “ignore if” or “ignore unless” frontmatter key will also not be scheduled.

Schedule conditions are only parsed when your Bunches are scanned. This happens when a file in the Bunch folder changes, but not when a trigger file or other condition changes. If a Bunch is already loaded and scheduled, the change in presence of a trigger file or other condition will not immediately turn off scheduling, but the schedule if/unless condition will be checked at the scheduled time and open/close will be cancelled based on the result.

The schedule if/unless keys can be inherited from tag and folder frontmatter. If the Bunch contains its own schedule if or schedule unless, it will override any schedule conditions set in inherited frontmatter. If a Bunch inherits a schedule condition but doesn’t have a schedule to set, the key will be ignored.

If (for whatever reason) both schedule if and schedule unless are defined on a Bunch, only schedule if is used.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (json):
```json
---
open every: 1h30m
---
```

Example 2 (json):
```json
---
open at: 5pm
---
```

Example 3 (json):
```json
---
open at: 8am, 12pm, 5pm
---
```

Example 4 (yaml):
```yaml
---
open on: friday 5pm
---
!Slack
```

---

## External Files - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity/external-files/

**Contents:**
- Populating Dialogs with External Files
- YAML
- JSON
- Plain Text
- Executable Script
- Checkbox Dialogs from External Files
    - See Also:

Similar to snippet syntax, you can read a list of multiple choice dialog options from an external file or script using ?< FILEPATH. Bunch recognizes several different file types (YAML, JSON, text), as well as executable scripts.

Reading from files works for multiple choice dialogs only, not for text input requests or checkbox arrays.

You can specify the title of the dialog by including the desired text in quotes after the filename.

If the file has a .yaml or .yml extension, it’s contents will be read as YAML. The structure should either be an array of strings, or an array of key/value pairs. A dictionary of key/value pairs will work, but order can’t be preserved.

Example YAML input, array of key/value pairs:

If the file has a .json extension, it will be read as JSON. The structure should either be an array of strings or an array of key/value pairs.

Example JSON input, array of key/value pairs:

If a file has the extension .txt, its contents are read as a list, one item per line. If a line is formatted as a dictionary line, e.g. Title => Value, it will be interpreted as such. A line that doesn’t contain => will be interpreted as a regular string, used for both title and value of the menu option.

Example text input, dictionary format:

If the file specified has neither YAML, JSON, or .txt extensions, it’s checked to see if it’s executable. If it is, its output is read and determined to be YAML, JSON, or plain text.

To make your script executable, run chmod a+x /path/to/script in Terminal.

A script should have a shebang line (e.g. #! /bin/zsh) and return output in JSON, YAML, or plain text format. The format will be automatically determined, first by attempting to parse it as JSON, then as YAML, and finally assuming a plain text list of options.

AppleScript .scpt files are not currently supported. If you want to use an AppleScript to populate the menu, save it as a plain text .applescript file, insert #!/usr/bin/osascript as the first line of the file, and make it executable. Then just use ?< MyScript.applescript to run it.

You can’t use ?< syntax to populate a checkbox dialog, but you can use a snippet to directly load options for a menu. As long as the text file is written in the GitHub style checkbox format, you can just include it as a snippet and the options will be presented.

A text file called apps.txt written to by a script (or whatever):

Then in the Bunch, just add:

When the Bunch is opened, the app options are presented. Apps opened by the Bunch are also closed when the Bunch closes (if the Bunch toggles). You could take this a step further and make the whole dialog optional, too:

Now you’ll get a prompt, and if you cancel it the checkbox dialog will be skipped. Just in case you wanted to get crazy with it.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
?< scripts/Menu Source.json "Pick your Poison"
```

Example 2 (json):
```json
---
- Option 1: "This is the value of option 1"
- Option 2: "This is the value of option 2"
```

Example 3 (json):
```json
[
    {"Option 1":"Value 1"},
    {"Option 2":"Value 2"}
]
```

Example 4 (scala):
```scala
Option 1 => Value 1
Option 2 => Value 2
```

---

## Running AppleScript - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/applescript

**Contents:**
- Running AppleScript
- Running a Single AppleScript Command
- Running an AppleScript Script
- Multi-line/Heredoc
- Snippets
- Running with Automator
    - See Also:

There are several ways to use AppleScript within Bunch.

Put a * at the beginning of a line to have the line interpreted as raw AppleScript. There will be some permissions requests and some commands that just refuse to run, but most commands will work fine. If you need to use multiple lines, you can either create an external script file, or use a heredoc or snippet import.

If the content of a * line references an existing filename, that file will be executed as an AppleScript using the osascript command. If the script is in your Bunch directory, you can run it with just the filename (or a relative path to a subfolder1). Otherwise, specify an absolute path to the script.

If your script has a space in the name, you need to either quote the name or escape the spaces, e.g.:

Arguments can be passed to the script on the same line (same escaping rules apply):

Scripts run using * commands are monitored like shell scripts, and show up under the “🔴 Shell Scripts” menu.

Multi-line scripts can also be embedded using the same heredoc syntax as variable assignment. The contents of the heredoc block will be saved to a temporary file and executed as AppleScript. This allows you to embed multi-line AppleScripts in your Bunch without having to generate external script files for every one.

All lines within a block will be outdented to the indent level of the first line.

Variable placeholders can be used in heredocs. Heredocs do not accept environment variables on file lines following them the way that regular script/command lines do.

You can also use snippet syntax to import AppleScript, allowing for use of fragments to combine multiple scripts into one file (or an embedded snippet, as shown below).

This works for both shell ($) and AppleScript (*) script lines. In most cases you’ll probably want to just write actual scripts and execute them directly, but if you want to combine multiple scripts with fragment headers or make use of embedded snippets to store scripts for the current Bunch, this syntax will do the trick.

You can also wrap the AppleScript in an Automator Workflow and run it using & commands. This also makes it easy to use variables and control where output goes.

Remember that relative paths in Bunches within subfolders are relative to the base Bunch Folder, not the containing subfolder. ↩

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
* say "Welcome to the communications context"
* do shell script "/bin/bash my_cli_tool.sh"
* display notification "Bunch Opened"
```

Example 2 (markdown):
```markdown
* MyScript.applescript
* OtherScript.scpt
```

Example 3 (markdown):
```markdown
* "My Script With Spaces.scpt"
* My\ Script\ With\ Spaces.scpt
```

Example 4 (markdown):
```markdown
* MyScript.scpt "argument 1" argument\ 2
```

---

## The Bunch Folder - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/bunch-folder

**Contents:**
- Bunch Folder Setup
    - See Also:

By default, Bunch reads plain text files from a folder at ~/Documents/Bunches (that’s a folder called “Bunches” in your Documents folder). You can add a new folder using the Add button next to the Bunch Folder in Preferences (possibly to a Dropbox or iCloud folder where you can sync with other machines). The dropdown menu there will let you switch between any Bunch folders you’ve added.

Tip (kinda): when you change the Bunch folder location, it doesn’t move or delete any of the Bunches at the previous location. That means that (in a fairly inelegant way) you can use different folders for different sets of Bunches. You can also quickly switch sets using the setPrefs URL handler from other apps.

All materials copyright © Brett Terpstra 2021

---

## Conditional Logic - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/logic/

**Contents:**
- Conditional Logic
- Syntax
  - Boolean Operators
  - Nesting If/Else Blocks
  - Waiting Snippets in If/Else Blocks
- Conditions
- Tips
  - Use Script Results As Conditions
  - Combine Dialogs and Conditions
  - Use Snippets To Run Conditional Logic On Close

If you want to have your Bunches perform different tasks based on various criteria, conditional logic can add flexibility and control.

Bunch supports if/else syntax. There are a number of conditions you can use to determine if a certain block will run. The most basic form of this is the “if” statement. The block starts with an “if condition” line, no indentation, and ends with a line containing just “end”. The contents between the “if” and “end” are indented 4 spaces or one tab.

Indentation must be exactly four (4) spaces or one (1) tab per level, with an additional 4 spaces/1 tab per nested level. If using spaces instead of tabs, every indentation level must be a multiple of 4.

The condition can use a variety of syntax, from human readable to symbolic. See the next section for details. In the example above, Bunch simply tests the contents of a variable called var_one to see if it exists (is defined and has a value that’s not “false” or “no”). If so, it launches Messages and runs a snippet.

You can go further by providing “else” statements. These can be “else if condition”, or just “else” to have a block that runs if nothing else matches. Both are optional. If used, the “else” block should come last.

Conditions can be combined using “AND” and “OR”.

You can group multiple conditions in parentheses and compare multiple groupings.

You can nest if/else blocks, continuing to indent contents 4 spaces or one tab from the last level of indentation. Variables can be changed within blocks and tested again in nested conditions.

Waiting Snippets are specified by indenting 4 spaces or 1 tab, so within an if/else block they should be indented an extra 4 spaces or 1 tab beyond the indentation of the block level.

Variable names in conditions can be “bare,” writing just the variable name. You can optionally use a $, e.g. $variable for clarity. If a variable matching the key isn’t defined, it will return false and not run the block. If your variable name contains spaces, you must either write it without spaces (first name -> firstname) or use curly brackets (${first name}).

All conditions can be negated using “not” or ! condition. Negatives can only be invoked once, e.g. weekday not !Friday will be interpreted as weekday is not Friday.

Syntax: if [condition] where [condition] is one of the following.

Example: if Messages is running

is is optional in all tests, so this works as AppName running, AppName not running

All conditions can be negated with not, e.g. var_name is not less than is the same as var_name is greater than or equal to. Symbols can be negated with !, e.g. var_name !<= 5.

Example: if var_name is greater than 1

Example: if var_name contains "complete"

Remember that you can combine multiple conditions with “OR”, so to have a block run on Tuesday and Thursday, use weekday is Tues OR weekday is Thurs

Example: if weekday is Wednesday

Example: if time is before 12pm

You can use the output of shell scripts to set variables which can then be tested with if/else blocks.

This works with AppleScripts as well (my_var = * ...), as long as the script returns a string or number.

There are a some UNIX commands commands that can make very useful variables with things like your clipboard contents or various date formats.

You can set a variable using a dialog, and then use an if/else block to perform different actions based on the choice. In its simplest form, this is essentially the same as just having a dialog run different snippets based on user selection, but by setting a variable you can have multiple if/else blocks, and the variable is passed to snippets (which can also contain their own if/else blocks).

Because if/else blocks can be used within Snippets, you can use an on-close Snippet to run logic when closing a Bunch.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (julia):
```julia
if var_one
	Messages
	<Snippets.snip#Group 1
end
```

Example 2 (julia):
```julia
if var_one is "Choice 1"
	var_two = "Project 1"
	<<#Load Project
else if var_one is "Choice 2"
	var_two = "Project 2"
	<<#Load Project
else
	<<#Load Default
end
```

Example 3 (julia):
```julia
if condition 1 AND condition 2
	<<#You Win
end
```

Example 4 (julia):
```julia
if (condition 1 AND condition 2) OR (condition 3 AND condition 4)
	<<#You Win
end
```

---

## Running AppleScript - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/applescript/

**Contents:**
- Running AppleScript
- Running a Single AppleScript Command
- Running an AppleScript Script
- Multi-line/Heredoc
- Snippets
- Running with Automator
    - See Also:

There are several ways to use AppleScript within Bunch.

Put a * at the beginning of a line to have the line interpreted as raw AppleScript. There will be some permissions requests and some commands that just refuse to run, but most commands will work fine. If you need to use multiple lines, you can either create an external script file, or use a heredoc or snippet import.

If the content of a * line references an existing filename, that file will be executed as an AppleScript using the osascript command. If the script is in your Bunch directory, you can run it with just the filename (or a relative path to a subfolder1). Otherwise, specify an absolute path to the script.

If your script has a space in the name, you need to either quote the name or escape the spaces, e.g.:

Arguments can be passed to the script on the same line (same escaping rules apply):

Scripts run using * commands are monitored like shell scripts, and show up under the “🔴 Shell Scripts” menu.

Multi-line scripts can also be embedded using the same heredoc syntax as variable assignment. The contents of the heredoc block will be saved to a temporary file and executed as AppleScript. This allows you to embed multi-line AppleScripts in your Bunch without having to generate external script files for every one.

All lines within a block will be outdented to the indent level of the first line.

Variable placeholders can be used in heredocs. Heredocs do not accept environment variables on file lines following them the way that regular script/command lines do.

You can also use snippet syntax to import AppleScript, allowing for use of fragments to combine multiple scripts into one file (or an embedded snippet, as shown below).

This works for both shell ($) and AppleScript (*) script lines. In most cases you’ll probably want to just write actual scripts and execute them directly, but if you want to combine multiple scripts with fragment headers or make use of embedded snippets to store scripts for the current Bunch, this syntax will do the trick.

You can also wrap the AppleScript in an Automator Workflow and run it using & commands. This also makes it easy to use variables and control where output goes.

Remember that relative paths in Bunches within subfolders are relative to the base Bunch Folder, not the containing subfolder. ↩

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
* say "Welcome to the communications context"
* do shell script "/bin/bash my_cli_tool.sh"
* display notification "Bunch Opened"
```

Example 2 (markdown):
```markdown
* MyScript.applescript
* OtherScript.scpt
```

Example 3 (markdown):
```markdown
* "My Script With Spaces.scpt"
* My\ Script\ With\ Spaces.scpt
```

Example 4 (markdown):
```markdown
* MyScript.scpt "argument 1" argument\ 2
```

---

## Input Source - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/input-source/

**Contents:**
- Input Source Commands
    - See Also:

Change your keyboard input source to other languages.

To set an input source, the source must be installed and enabled in System Preferences->Keyboard->Input Sources. The source can be referred to using any part of its name, or by a qualified input source identifier.

The following will set the input source to French.

You can also use a source identifier, if you know it. This can help avoid false matches if you have multiple sources for a language.

Input source commands are reversed when closing a Bunch. The current input source is recorded prior to running the command, and when the Bunch containing the command is closed, the recorded input source is restored. If you want to manually specify what input source to switch to when closing, use an on-close command:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(input source french)
```

Example 2 (unknown):
```unknown
(input source com.apple.keylayout.British)
```

Example 3 (unknown):
```unknown
!(input source US)
```

---

## Optional Snippets - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity/optional-snippets/

**Contents:**
- Optional Snippets With Dialog
    - See Also:

You can have Bunch ask whether a snippet should be loaded when opening a Bunch by adding a query at the end of it. The format for the query is a question mark (?) immediately followed by a double-quoted string. The string within the quotes will be used as the text of the dialog, with buttons “Yes” and “No”.

When the Bunch is launched, a dialog will ask “Load My Snippet?” and request user interaction. Clicking “Yes” will load the referenced snippet, clicking “No” will skip loading it. This can be used with variables and fragments, as well:

You can include multiple optional snippets, but — due to the asynchronous way Bunches are launched — the questions may not be asked in file order. Make the queries descriptive to avoid confusion.

You can also ask about snippets when the Bunch is closing:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
< MySnippet.snippet ?"Load My Snippet?"
```

Example 2 (sass):
```sass
<General.snippets#Spotify ?"Play some music while you work?"
- url=spotify:​playlist:3cSpIL4Q0H3uqdBMbT6c9x
- autoplay=true
```

Example 3 (unknown):
```unknown
!<General.snippets#Goodbye ?"Turn off the lights on your way out?"
```

---

## Running Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts//

**Contents:**
- Running Scripts With Bunch
- Section Contents

Bunch can run Automator Workflows, AppleScripts and AppleScript commands, and shell scripts and shell commands. Choose a section to learn more.

All materials copyright © Brett Terpstra 2021

---

## Spotlight Searches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/spotlight-searches/

**Contents:**
- Using Spotlight Queries
- Tag Search
- Spotlight Search
    - See Also:

In the dashed lines that follow an app, you usually list files you want to open in that app. But you can also run some searches and open the results instead.

You can use hashtags on a line to search for one or more tags. Multiple tags are joined as a boolean AND, meaning files must contain all of the tags to match.

You can limit these searches to one or more directories by including a comma-separated list of paths in square brackets:

By default all searches are limited to 15 results, just so that a wayward search query doesn’t leave you with 1000 files open in random applications. You can override this limit in either direction by adding an exclamation point followed by a number to the end of the line:

Scopes and limits can be combined.

You can also harness the full power of Spotlight using the syntax you’re used to in the floating Spotlight window. Just surround your search in single quotes. A scope can be defined as above, but with this query you can only specify one folder. It defaults to your Home folder and all of its subfolders. The same scope and result limit modifiers as above apply.

You could use this to review files at the end of the day. Schedule a Bunch to launch at 4:30pm, and have it open recent files on your Desktop or in your Downloads folder for review:

Tip: Along the same lines, you can also use the URL handler to create links you can put into OmniFocus or Things to load up a daily review.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
Default
- #Taxes #2020
```

Example 2 (markdown):
```markdown
Default
- #Taxes #2020 [~/Dropbox/Receipts]
```

Example 3 (markdown):
```markdown
Default
- #Taxes #2020 !25
```

Example 4 (json):
```json
Default
- 'kind:"affinity photo" tag:brettterpstra.com name:template' [~/Dropbox] !5
```

---

## Execution Sequence - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/sequence

**Contents:**
- Sequential vs Parallel
- Changing Sequence for a Single Bunch
- Changing Sequence for a Single Item
    - See Also:

Out of the box, Bunch launches items in a Bunch file in sequential order. You can change this using Preferences->Bunch Behavior->Launch Items In Parallel. When this is off, Bunch executes items in the Bunch file in the order they’re listed, sending one item to the queue at a time. The actual order may be out of sequence depending on the execution of the queue by the system, but if you have items (apps, scripts, etc.) that rely on other things happening first, this is ideal.

When this is turned on, all items in the Bunch file are added to the queue to be executed asynchronously, meaning they more or less all happen at the same time, and one item taking a long time won’t stop other items from running. This makes for very fast Bunch opens. If the order of execution in your Bunches as a whole isn’t important, turn this feature on. You can affect it on a per-file or per-item basis as needed.

You can change the sequence of execution for a single Bunch, regardless of the Preference setting, by using the frontmatter key sequence. This can be set to either sequential or parallel. You only need the first letter of either value to trigger it, so sequence: p is all it takes to enable parallel execution for the Bunch.

(Just to make things confusing, you can also use parallel: true|false or sequential: true|false. Whatever makes the most sense to your brain.)

If the “Launch Items in Parallel” preference is turned off, or the Bunch has frontmatter that disables it, you can still affect individual items by putting a pipe (|) in front of the line. This works on everything except snippets, but can be used on items within snippets.

Items marked with a pipe are taken out of the sequence and executed immediately in the background. Execution will not wait until their line in an otherwise sequential Bunch file.

If the script is an on-close script, put the pipe before the exclamation point.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: All At Once
sequence: parallel
---
```

Example 2 (markdown):
```markdown
|$ scripts/parallel1.sh
|$ scripts/parallel2.sh

# On close
|!$ scripts/close1.sh
|!$ scripts/close2.sh
```

---

## Bunch Files - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/

**Contents:**
- Section Contents
    - See Also:

The Bunch menu is created by reading text files from your Bunch folder. To show up in the menu, the file just has to have the extension .bunch. Bunch files contain apps to launch, URLs to open, commands to run, and more. Learn more about the syntax and features below.

You can edit Bunch files in any text editor. That includes TextEdit, but if you’re using TextEdit (or any app that has a Rich Text mode), be sure to switch to Plain Text mode. In TextEdit, that’s under Format->Make Plain Text.

All materials copyright © Brett Terpstra 2021

---

## Notify - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/notify/

**Contents:**
- Notify Commands
- Example
    - See Also:

This simply takes a string of text and creates a Notification Center alert or banner (depending on your settings). Banners are assigned an identifier with the calling Bunch’s name, so subsequent alerts overwrite the first, avoiding a pileup of notifications.

I highly recommend setting your alert style for Bunch to “Alerts” in System Preferences->Notifications. This makes the information from Bunches more useful, and allows some actions (like scheduled Bunches) to provide a cancel method that would otherwise be quickly hidden.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(notify Some text to display)
```

---

## Opening Websites/URL schemes - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/opening-web-pages/

**Contents:**
- Opening URLs
- Opening URLs in a Specific Browser
  - Opening in a Specific Chrome Profile
  - Quitting Browsers On Close (Beta)
- Preventing Duplicate Tabs
- Sending GET/POST Requests
    - See Also:

If you want to open web pages as part of a Bunch, you can just put a URL at the beginning of a line (like you would an app) and that URL will be opened in your default browser. If the URL is a URL scheme for an installed app, it will be executed as if called from a link or via the open command.

If you want to open a url in a specific browser, you can use prefixes before the url. Examples:

The recognized browser prefixes are:

In most cases, you can also send a URL as a file to a browser and it will open it properly, as in:

For the chrome: and canary: prefixes, you can also include a profile name in square brackets to have a url open in a specific profile. This will open a new window with the profile, and multiple links targeting the same profile will open tabs in that window.

Profile names are case insensitive and allow partial matches (“work” will match the profile “Work Profile”). Bunch will go with the first matching name it finds.

Profiles cannot be used when passing URLs as file lines.

Beta Feature: this feature is currently in development and is only available to those using the preview build. If you want to help test new features, feel free to download and run the beta release.

If you set quit browsers: true in frontmatter, browsers opened with browser:url syntax will be quit when the Bunch closes. This can be modified per line with a % prefix to ignore on close.

Bunch doesn’t parse open tabs to determine if a URL would open a duplicate tab, but you can add extensions to your browser to accomplish this.

Some URLs, such as webhook triggers, are meant to be pinged but not opened in your browser. To accomplish this with Bunch, you can use the curl command in a shell script item. See Home Automation for examples of sending GET requests using curl.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
https://hulu.com
https://brettterpstra.com
x-marked://open?file=filename.md
```

Example 2 (yaml):
```yaml
safari:​https://brettterpstra.com
firefox:​https://mozilla.org
```

Example 3 (markdown):
```markdown
Safari
- https://bunchapp.co
```

Example 4 (unknown):
```unknown
chrome[work]:https://brettterpstra.com
chrome[work]:https://duckduckgo.com
chrome[personal]:https://hulu.com
```

---

## Snippets - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/snippets

**Contents:**
- Avoid Repetition With Reusable Snippets
- What Is a Snippet
- Snippet Variables
  - URL Encoding
  - Default Variable Values
- Referencing Fragments
- Adding Interactivity
- Run After Delay
- Run When Closing
- Wait Until Apps Have Launched

If a series of tasks is repeated in multiple Bunches, you can separate them into their own “snippet” files and include the snippet in any Bunch. You can also embed snippets right in a Bunch.

A snippet file can be named with any extension other than .bunch, stored in your Bunch Folder. You can store snippets in a subfolder for organization, you’ll just need to reference them with an appropriate path.

To include a snippet in a bunch, use < snippet.name on a line in the Bunch. If the snippet is in a subfolder, you would use < folder_name/snippet.name.

Snippet contents are treated like part of the Bunch that imports them, so when the Bunch closes, any apps or commands included by the snippet will be closed/reversed.

You can even call other Bunch files as snippets. If you use fragment headers in your Bunch file, you can call just a portion of one Bunch from another, e.g. < Comms.bunch#Social. Fragment headers are ignored when processing a Bunch normally.

To make snippets flexible, Bunch allows variables defined in the containing Bunch to be replaced within the snippet. Existing variable values are passed to the snippet, and you can specify additional/different values when calling the snippet. These are defined like files on the lines following the < line.

Now you can use ${proj_path} anywhere in your snippet file, allowing you to use the same snippet for different projects.

You can also define values for snippet variables using frontmatter.

Replace the dollar sign ($) with a percent symbol (%) in the placeholder and Bunch will URL encode the content. See the Variables documentation for more about value transforms.

If you use a percent (%) instead of a dollar sign ($) in your snippet placeholder, the value will be URL encoded when the variables are inserted. For example, if you have a variable called “foo” and the value passed to it is “This? This needs % encoding” then %{foo} will be replaced with This%3F%20This%20needs%20%25%20encoding, which is safe for use in URLs.

For more details and other transformations, see Variables: Transforming Values.

If a snippet has variable placeholders but no values are provided when it’s called, the placeholders will be removed. You can instead provide default values that will be used if no matching key/value pair is provided. To do this, just use a colon followed by the default within the placeholder:

Only the first colon is used to split the value, so the default value can contain colons.

For more details, see Variables - Default Values.

A snippet or bunch can contain multiple fragments, each beginning with a fragment header. Create a fragment header with a hash (#) or other accepted symbols (see below), and a fragment name in square brackets:

Reference the fragment with the snippet and fragment name, like this:

If you load a snippet containing fragments without using a fragment name, i.e. just <MySnippet.snippet, it will run all of the fragments in the snippet.

If you feel like being creative, Bunch allows the use of several symbols to create the fragment headers, and you can have a variable number of them on either side of the brackets (you do need one symbol on the left).

Begin a fragment header using one of #, -, =, or >. The line must start with one or more of these symbols, followed by the fragment name enclosed in square brackets. In the case of a hyphen, two or more are required at the beginning of the line to avoid confusion with file lines. The other symbols only require a single character. Whitespace is allowed in the fragment header after the first (or second in the case of --) character. Fragment names can also include spaces.

Anything after the closing square bracket is ignored. You can use the rest of the line to continue a divider, add a comment, or just leave it blank.

The following all work as fragment headers:

You get the idea. When you amass a lot of snippets in one file because you’re making great use of fragments, it’s just nice to make them look pretty…

See Interactivity: Optional Snippets for details on adding interactive choices to snippet loading.

Add a tilde and an integer at the end of the line to have the contents of the snippet run after a delay.

A delay can be combined with a query for an optional snippet. The delay should always be the last item on the line.

Like most script types in Bunch, you can precede a snippet line with an exclamation point (!) to run it when the Bunch closes instead of when it opens.

These can also have a delay:

A “Waiting Snippet” is a snippet line indented by 4 spaces or 1 tab.

A Waiting Snippet will try to wait until all of the apps in the bunch have launched (or quit, if they’re !apps). There’s a timeout in case not all apps properly report their launch/termination to the OS.

This is especially handy for running window management scripts (a la Moom) that need all of the apps to have windows present. It’s more flexible than just putting a hard delay on the script, as it will take into account unusually long (or short) launch times. Just put the script line into a snippet or fragment and call it with an indented line.

Waiting Snippets rely on the apps to report that they’ve launched to the operating system. Just because an app has reported that it’s launched doesn’t necessarily mean it’s finished launching. Adding an additional delay is wise if some of the apps you’re waiting on take a long time to display their windows.

You can have multiple Waiting Snippets in a Bunch, but they all wait for all apps and execute at once, not just waiting on the apps that come before them in the list.

You can, however, use waiting snippets to chain multiple Bunches together in a sequence, having the next one launch after the first one finishes loading. Just include e.g. Next Name.bunch as a line in the Waiting Snippet.

Waiting Snippets also work with additional time delays as well as interactive optional snippets (see above).

Waiting Snippets get a 5-second timer attached. If all of the apps the Bunch is waiting for are already launched, it won’t receive any notifications of their launch to trigger the snippet, so if it hasn’t heard back it will check to see if all of the required apps are running (or have been terminated). If its requirements are satisfied, it will launch the Waiting Snippet.

You can create separate snippet files to hold reusable items, but if you just need snippets to make use of features like Waiting Snippets, delayed blocks, or blocks to run on close, you can also embed a snippet right in the Bunch. Add a divider of three or more underscores (___) at the end of the document, and anything after it will be read as a snippet file.

Only a Bunch can contain an embedded snippet. The syntax won’t have any effect on files loaded as snippets.

These work like any snippet file, and you can divide them into fragments to reference by name.

To reference an embedded snippet, just use an additional < instead of a filename:

That would run everything after the ___ as a snippet. You could also divide your embedded snippet into fragments and reference one of them with a fragment name:

Embedded snippets and fragments also work as Waiting Snippets, on-close snippets, and with delays, just like regular snippets. You can pass variables using file lines, and all frontmatter variables and variables assigned using dialogs in the Bunch are available to them.

Embedded snippet example:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
< generic.snippet
- proj_path=~/Code/MyProject
```

Example 2 (markdown):
```markdown
TaskPaper
- ${proj_path}/todo.taskpaper
%iTerm
- ${proj_path}
```

Example 3 (markdown):
```markdown
---
search string: this is a search
---
___
Spotify
- spotify:​search:%{searchstring}

# sends "spotify:​search:this%20is%20a%20search"
```

Example 4 (css):
```css
${proj_path:~/projects}
```

---

## Populating Variables - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity/populating-variables/

**Contents:**
- Populating Variables Interactively
- Text Input
- Menu Selection Input
    - See Also:

You can always write your own scripts with dialogs to return frontmatter keys and values using the from script key, but you can also assign them within a Bunch using any of the dialog options above.

To populate a frontmatter key for use as a variable, just start the line with the variable name, followed by =, and then the syntax for the type of query you want (text, multiple choice, etc.). Variable assignment does not work with Checkbox Arrays.

Note that the dialogs will only display if the frontmatter key is not already assigned. This allows you to have a Bunch offer interactivity when launched directly, but when called from another Bunch, an AppleScript, or the URL handler, you can assign the variable directly and skip the dialog.

To display a text field and request user input, use this in your Bunch:

When the field pops up, type your response and hit OK. Then the myvar variable will be populated for any snippets that include it with ${myvar}.

As an example, you could use this to enter a search term when opening a Bunch:

That will take your input and url encode it into a Spotify URL that is directly opened by Spotify.

You can use the same syntax from Query Arrays or Query Dictionaries (or external files) to offer multiple choice dialogs.

Now you’ll get a dialog asking you to pick a podcast, and then you can use the podcast variable in a snippet. I use something like this when building a new show notes file in nvUltra, creating a note called, for example “Overtired 250.md”.

My choice from the podcast query gets populated just like it is in the array (either “Overtired” or “Systematic”). If I wanted to provide different text for the options than the final values it returns, I would use a Dictionary.

As mentioned above, if I wanted to call this Bunch from the URL handler with a specific podcast pre-defined, I could just define the podcast and episode variables when calling it, and the select and input dialogs would not display:

You can use variable assignment to abstract some of the above examples. Instead of having a dialog immediately call a snippet, you can assign a fragment name to a variable and then use that when calling the snippet. The following sets which_snippet to the result of the dialog, then calls a snippet, passing the result as the fragment to search for:

Include a default value to run in case the dialog is cancelled.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
myvar = ?"Question to ask"
```

Example 2 (markdown):
```markdown
spotifyurl = ?"Spotify Search"
Spotify
- spotify:​search:%{spotifyurl}
```

Example 3 (unknown):
```unknown
podcast = ?[Overtired, Systematic] "Which Podcast are you recording?"
```

Example 4 (julia):
```julia
podcast = ?[Overtired, Systematic] "Which podcast?"
episode = ?"Episode Number"
<<
___
// Open nvUltra, close all windows, open Podcasting notebook using URL handler
// If the script has populated an episode note title, include it in the URL
%nvUltra Beta
- XX
- x-nvultra:​//open?path=/Users/ttscoff/Dropbox/Notes/Podcasting/&note=%{podcast:Podcast}%20${episode}.md
```

---

## Run On Close - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/run-on-close

**Contents:**
- Running Scripts Only When Closing a Bunch
- Launching Multiple Items on Close
- Launch an App When Closing
- Quit an App When Closing
    - See Also:

If you precede any script lines (starting with *, &, or $) with an exclamation point, that script will be ignored when opening a Bunch and instead run only when the Bunch is closed. Here’s an example that uses the same script with different arguments for open and quit:

The same works for commands. To run a command when a Bunch closes, use:

You can also set an entire snippet to open when the Bunch closes using the same syntax. Just use !<snippet.name to have the contents of that snippet or snippet fragment load when the Bunch is closed.

Note that in the case of apps, a single exclamation point (!AppName) quits the app rather than performing an action on close. Bunch doesn’t automatically relaunch apps that are quit this way; you have to explicitly instruct it with !! (a double negative).

The following will force quit Dropbox when opening the Bunch, and then restart it when closing.

To quit Twitter when opening the Bunch, then re-launch it on close:

Normally an app launched by a Bunch would quit when the Bunch closes (unless ignored with %). You can also specify that an app should quit when closing a Bunch — without having to launch it first — by using !!!AppName. If the app is running, it will be quit when the Bunch closes, but the item will have no effect when opening the Bunch.

This can be useful as a workaround when an app like FileMaker Pro Advanced or Visual Studio Code will launch with one name, but needs another to quit. In the case of FileMaker, you would use:

(The specific cases of FileMaker and VS Code are handled automatically by Bunch, but there will almost certainly be other examples of this where you’ll need to manually specify.)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
# Run this when opening the Bunch
$ ~/scripts/myscript.sh open
- STATUS=opening

# Run this when closing the bunch
!$ ~/scripts/myscript.sh close
- STATUS=closing
```

Example 2 (unknown):
```unknown
!(hide dock)
```

Example 3 (markdown):
```markdown
!<<#On Close
___
#[On Close]
Tweetbot
Messages
* tell application "Moom" to arrange windows according to snapshot "Comms"
```

Example 4 (kotlin):
```kotlin
$ killall Dropbox
!!Dropbox
```

---

## Snippets - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/snippets/

**Contents:**
- Avoid Repetition With Reusable Snippets
- What Is a Snippet
- Snippet Variables
  - URL Encoding
  - Default Variable Values
- Referencing Fragments
- Adding Interactivity
- Run After Delay
- Run When Closing
- Wait Until Apps Have Launched

If a series of tasks is repeated in multiple Bunches, you can separate them into their own “snippet” files and include the snippet in any Bunch. You can also embed snippets right in a Bunch.

A snippet file can be named with any extension other than .bunch, stored in your Bunch Folder. You can store snippets in a subfolder for organization, you’ll just need to reference them with an appropriate path.

To include a snippet in a bunch, use < snippet.name on a line in the Bunch. If the snippet is in a subfolder, you would use < folder_name/snippet.name.

Snippet contents are treated like part of the Bunch that imports them, so when the Bunch closes, any apps or commands included by the snippet will be closed/reversed.

You can even call other Bunch files as snippets. If you use fragment headers in your Bunch file, you can call just a portion of one Bunch from another, e.g. < Comms.bunch#Social. Fragment headers are ignored when processing a Bunch normally.

To make snippets flexible, Bunch allows variables defined in the containing Bunch to be replaced within the snippet. Existing variable values are passed to the snippet, and you can specify additional/different values when calling the snippet. These are defined like files on the lines following the < line.

Now you can use ${proj_path} anywhere in your snippet file, allowing you to use the same snippet for different projects.

You can also define values for snippet variables using frontmatter.

Replace the dollar sign ($) with a percent symbol (%) in the placeholder and Bunch will URL encode the content. See the Variables documentation for more about value transforms.

If you use a percent (%) instead of a dollar sign ($) in your snippet placeholder, the value will be URL encoded when the variables are inserted. For example, if you have a variable called “foo” and the value passed to it is “This? This needs % encoding” then %{foo} will be replaced with This%3F%20This%20needs%20%25%20encoding, which is safe for use in URLs.

For more details and other transformations, see Variables: Transforming Values.

If a snippet has variable placeholders but no values are provided when it’s called, the placeholders will be removed. You can instead provide default values that will be used if no matching key/value pair is provided. To do this, just use a colon followed by the default within the placeholder:

Only the first colon is used to split the value, so the default value can contain colons.

For more details, see Variables - Default Values.

A snippet or bunch can contain multiple fragments, each beginning with a fragment header. Create a fragment header with a hash (#) or other accepted symbols (see below), and a fragment name in square brackets:

Reference the fragment with the snippet and fragment name, like this:

If you load a snippet containing fragments without using a fragment name, i.e. just <MySnippet.snippet, it will run all of the fragments in the snippet.

If you feel like being creative, Bunch allows the use of several symbols to create the fragment headers, and you can have a variable number of them on either side of the brackets (you do need one symbol on the left).

Begin a fragment header using one of #, -, =, or >. The line must start with one or more of these symbols, followed by the fragment name enclosed in square brackets. In the case of a hyphen, two or more are required at the beginning of the line to avoid confusion with file lines. The other symbols only require a single character. Whitespace is allowed in the fragment header after the first (or second in the case of --) character. Fragment names can also include spaces.

Anything after the closing square bracket is ignored. You can use the rest of the line to continue a divider, add a comment, or just leave it blank.

The following all work as fragment headers:

You get the idea. When you amass a lot of snippets in one file because you’re making great use of fragments, it’s just nice to make them look pretty…

See Interactivity: Optional Snippets for details on adding interactive choices to snippet loading.

Add a tilde and an integer at the end of the line to have the contents of the snippet run after a delay.

A delay can be combined with a query for an optional snippet. The delay should always be the last item on the line.

Like most script types in Bunch, you can precede a snippet line with an exclamation point (!) to run it when the Bunch closes instead of when it opens.

These can also have a delay:

A “Waiting Snippet” is a snippet line indented by 4 spaces or 1 tab.

A Waiting Snippet will try to wait until all of the apps in the bunch have launched (or quit, if they’re !apps). There’s a timeout in case not all apps properly report their launch/termination to the OS.

This is especially handy for running window management scripts (a la Moom) that need all of the apps to have windows present. It’s more flexible than just putting a hard delay on the script, as it will take into account unusually long (or short) launch times. Just put the script line into a snippet or fragment and call it with an indented line.

Waiting Snippets rely on the apps to report that they’ve launched to the operating system. Just because an app has reported that it’s launched doesn’t necessarily mean it’s finished launching. Adding an additional delay is wise if some of the apps you’re waiting on take a long time to display their windows.

You can have multiple Waiting Snippets in a Bunch, but they all wait for all apps and execute at once, not just waiting on the apps that come before them in the list.

You can, however, use waiting snippets to chain multiple Bunches together in a sequence, having the next one launch after the first one finishes loading. Just include e.g. Next Name.bunch as a line in the Waiting Snippet.

Waiting Snippets also work with additional time delays as well as interactive optional snippets (see above).

Waiting Snippets get a 5-second timer attached. If all of the apps the Bunch is waiting for are already launched, it won’t receive any notifications of their launch to trigger the snippet, so if it hasn’t heard back it will check to see if all of the required apps are running (or have been terminated). If its requirements are satisfied, it will launch the Waiting Snippet.

You can create separate snippet files to hold reusable items, but if you just need snippets to make use of features like Waiting Snippets, delayed blocks, or blocks to run on close, you can also embed a snippet right in the Bunch. Add a divider of three or more underscores (___) at the end of the document, and anything after it will be read as a snippet file.

Only a Bunch can contain an embedded snippet. The syntax won’t have any effect on files loaded as snippets.

These work like any snippet file, and you can divide them into fragments to reference by name.

To reference an embedded snippet, just use an additional < instead of a filename:

That would run everything after the ___ as a snippet. You could also divide your embedded snippet into fragments and reference one of them with a fragment name:

Embedded snippets and fragments also work as Waiting Snippets, on-close snippets, and with delays, just like regular snippets. You can pass variables using file lines, and all frontmatter variables and variables assigned using dialogs in the Bunch are available to them.

Embedded snippet example:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
< generic.snippet
- proj_path=~/Code/MyProject
```

Example 2 (markdown):
```markdown
TaskPaper
- ${proj_path}/todo.taskpaper
%iTerm
- ${proj_path}
```

Example 3 (markdown):
```markdown
---
search string: this is a search
---
___
Spotify
- spotify:​search:%{searchstring}

# sends "spotify:​search:this%20is%20a%20search"
```

Example 4 (css):
```css
${proj_path:~/projects}
```

---

## Commands - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/index/

**Contents:**
- Bunch Special Commands
- Reversing Commands
- Section Contents

Commands are run by using lines surrounded by parenthesis in Bunch files. These offer shortcuts to some system tasks and special actions.

Most commands are automatically reversed when closing a Bunch (hidden Desktop icons are shown, hidden dock is revealed, wallpapers switch back, etc.). Notable exceptions include Dock positioning, notification, and audio commands, which are not restored to their previous state when the Bunch closes.

To avoid reversing a command when closing the Bunch, precede the line with a % symbol, e.g. %(hide dock) (just like ignoring applications when quitting).

To run the command only when closing a bunch, use an exclamation point (!) before the command, e.g. !(show desktop).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(dark mode [on|off])
(do not disturb [on|off])
(hide dock)
(show dock)
(dock [left|right|bottom])
(hide desktop)
(show desktop)
(wallpaper [path(s)])
(screen)
(audio [input|output] device_name)
(audio [input|output] volume [0-100])
(audio [input|output] [mute|unmute])
(input source [name])
(notify TEXT)
(display FILE)
(sleep [display])
(awake [interval])
(log [MESSAGE])
(shortcut [SHORTCUT NAME])
```

---

## Sample Bunches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/samplebunch/

**Contents:**
- Some examples to get you started
- Example.bunch
- Screencasting
- Podcasting
- Communication Apps
- Coding (Multiple Choice)
- Simple Web Development
- CodeKit (Script Variable)
- Dynamic Images
    - See Also:

These are mostly Bunches that I (Brett, the developer) use. Several of them incorporate Embedded Snippets in these examples so I don’t have to also include my snippet files just to let you see what’s going on. Anything in an Embedded Snippet can be moved to an external file as desired.

These examples make use of comments to explain what’s happening.

This example demonstrates the basic syntax for a Bunch file.

Get set up to start recording a screencast.

Here’s my Podcast Record.bunch.

I have this Bunch load on launch. It makes it easy to quit all of these apps at once, and load them back up at my convenience.

Here’s the Bunch I use when I’m ready to code. It offers a choice of my main projects using Query Dictionary syntax. It launches all of the common apps between the projects and tells Bunch not to quit them when the Bunch closes with a %. It uses Embedded Snippets to load the appropriate projects, and Moom in a Waiting Snippet to position the windows according to a snapshot after everything loads.

I have folder sets set up in Forklift, with keystrokes assigned that this Bunch sends.

These docs run on Jekyll. When working on them, I run jekyll serve to create a local server that updates automatically as the Markdown files change. I edit the docs in nvUltra and Sublime Text.

This Bunch opens the server in a task monitor (using colors from the beautiful Nord palette), loads up my editors, and opens a web view of the rendered documents which updates as changes happen (using Jekyll’s LiveReload). The web view opens after a long delay, giving Jekyll enough time to render and launch the server first.

Here’s the servejekyll.sh script that the Bunch runs. Note that it loads up my ruby environment using RVM so that bundle works properly.

The following Bunch combines a multiple choice dialog with a frontmatter key (previewurl) that gets set by running an AppleScript. The multiple choice dialog runs first, which calls snippets that set the current project in CodeKit, then uses an AppleScript call to get the browser preview url. The URL is retrieved prior to running the display command, so it can be inserted into the command as the target URL.

When I was transitioning to a new M1 Mac mini I was using several different machines, switching my display between them and sometimes using VNC to log into them. Because my goal was to make one system behave look and behave like the other, it could get confusing as to which one I was logged into at the time.

I built the following Bunch which takes the host name of the current machine and uses ImageMagick to create a green-on-transparent PNG of the machine’s name, then uses the display command to put it in the lower left corner of the desktop in a wallpaper-level chromeless window with transparent (#clear) background. The Bunch syncs between machines via Dropbox, opens at startup, and shows the name of whatever machine it opens on.

(Requires ImageMagick, brew install imagemagick)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (elixir):
```elixir
# Comments start with `#` or `//` and a space
# blank lines are ignored

/*
Comments can also use a block syntax
for multi-line comments
*/

/*
Use @@ to hide all visible apps. Usually used at the top of the
file before launching the rest of the bunch */
@@

/* Apps to launch start at the beginning of a line, no
need to quote or escape. */
Messages

# Apps launched by a Bunch can be quit when the Bunch is closed
%Terminal // Add a percent symbol to ignore it when quitting (keep it running)

/* Include a line starting with a dash to open specific
   files in the app.
   If the first file listed is "XX", all open windows
   for the app will be closed first */
Finder
- XX
- ~/Desktop
- ~/Documents
-> ~/Pictures // Opens Pictures in a tab of the Documents window

/*
Commands are surrounded by parenthesis. Only commands Bunch
recognizes will be executed
([hide|show] dock) -> Turn Dock autohiding on or off
([hide|show] desktop) -> Show or hide desktop icons
(dnd [on|off]) -> Turn Do Not Disturb on or off
*/
(show dock)

# Use a URL instead of an app to open it in your default browser
https://brettterpstra.com/projects

# You can also use URL schemes from other apps
x-marked://open?file=Work Stuff.md

# Start a line with an exclamation point to quit that app if it's running
!Mail

# Start a line with an asterisk (*) to execute as applescript
* say "Bunch launched"

/* Or run a shell script with a dollar sign ($)
   and set environment variables with "file" markers */
# $ /usr/local/scripts/myscript.sh arg1 arg2
# - KEY=value

/* Or an Automator Workflow with an ampersand (&)
   File markers will set variables for the workflow */
# & ~/Documents/My Workflow.workflow
# - key=val

/* Start a line with @ to "focus" that app (hide others)
   Focus commands should be the last item in the Bunch */
@Marked 2

# See the documentation for more info: https://bunchapp.co/docs
```

Example 2 (yaml):
```yaml
---
title: 🎥Screencast
shortcut: S
---
// General Settings
(hide desktop) // hide desktop icons
(hide dock)    // hide the Dock
(dnd on)       // turn on Do Not Disturb

// Launch Screenflow
// Assume we'll need it open for editing after we're done
// recording, so ignore it when closing (%).
%ScreenFlow

// Ask about specific project, handle setup
?{
  Marked => <<#Marked
  Bunch => <<#Bunch
} "Whatcha workin' on?"

// Focus Screenflow, hiding other apps
@ScreenFlow
___
// Load specific settings for different projects

#[Marked]
(wallpaper ~/Pictures/Desktops/markeddesktop.jpg)
Marked 2

#[Bunch]
(wallpaper ~/Pictures/Desktops/bunchdesktop.jpg)
```

Example 3 (elixir):
```elixir
---
title: 🎤Podcast: Record
---
###### Start podcasting ###################################
## Quit comms Bunch, closing apps it contains. Apps present in this Bunch
## (Messages, Discord) won't be quit by the other Bunch.
!Comms.bunch
Messages
Discord

## Do not disturb mode
(dnd on)

###### Set up audio devices ###############################
## Save audio device settings with a shell script
## https://gist.github.com/c5d61971d5251b8795af2415cc1bbb85
$ ~/scripts/volumetoggle.rb save

## Input/output devices can be referred to using partial names
(audio output macbook)
(audio output mute)
(audio input komplete audio 6)

####### Open the necessary apps ###########################
## Hide all open apps
@@
## Make sure nvUltra is open to my Podcasting notebook for show notes
%nvUltra Beta
- XX
x-nvultra://open/~/Dropbox/Notes/Podcasting

### Open Quip for documents I share with my co-host
Quip

## Open my recording software, then make sure  that only the Session window is
## showing by  sending keystrokes to open the Recordings window then close it
Audio Hijack
- {@0 @w}

## And, well, Skype, because I'm old
Skype

## Quit the bandwidth heavy apps
$ killall Dropbox
$ /Library/Backblaze.bzpkg/bztransmit -pausebackup

## Check for ad spots
firefox:​https://podman.backbeatmedia.com/shows

## Use Moom to position windows after everything has launched
## References the embedded snippet at the end using `<<`
    <<#Position Podcast ~4



# When I'm finished
!$ ~/scripts/volumetoggle.rb restore
!$ /Library/Backblaze.bzpkg/bztransmit -completesync
## Double negatives (!!) to launch apps and other Bunches when closing
!!Dropbox
!!Comms.bunch
___
--[Position Podcast]-----------------------------------------------------------
* tell application "Moom" to arrange windows according to snapshot "Podcasting"
```

Example 4 (yaml):
```yaml
---
title: 📞Comms
startup: true
---
/*
Fragment identifiers allow me to load this Bunch as a snippet and execute
just parts of it as needed. They are ignored when loading as a Bunch.
*/
#[Social]
Tweetbot
## (Facebook runs in a Unite Single Site Browser)
Facebook

/*
Lines beginning with a pipe (|) are executed in parallel, even when 
the default or Bunch-specific execution sequence is "sequential."
*/
#[Work]
|%MailMate
|Slack
|Messages

#[Podcast]
Discord

/*
Use an embedded Waiting Snippet to position windows after everything has
launched (with additional 2s delay)
*/
    <<#Position Comms ~2
___
--[Position Comms]--
* tell application "Moom" to arrange windows according to snapshot "Comms"
```

---

## Running Shell Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scripts/shell-scripts

**Contents:**
- Running Shell Scripts and Commands
- Scripts
- Embedded Scripts/Heredoc
- Snippets
- Raw commands
- Arguments and environment variables
- Monitoring Scripts
  - Customizing The Task Monitor
- Order of Execution
- Running in a Terminal

Lines starting with a dollar sign ($) are run as shell commands. Anything after the $ will be executed by /bin/sh. This can be a shell script file or a direct command.

Every command a Bunch runs gets its own “shell” and will show up in the menu under “Running Scripts.” Selecting a script in the menu will show you a window with the STDOUT and STDERR of the command, its current status, and buttons for pausing or killing the process. This menu will show scripts for all open Bunches. When a Bunch is closed, its processes are terminated and removed from the list.

If a task monitor isn’t visible for a task, output (both STDOUT and STDERR) from the script will be written to the Bunch Log at Debug level.

Important: in the case of scripts, ensure that your script has a hashbang (a.k.a “shebang”, e.g. #!/usr/bin/env ruby, #!/bin/bash, or #!/usr/bin/osascript -l JavaScript at the top of the file). If your script isn’t set to executable permissions and you call it without specifying the processor, the executable will be determined from the hashbang line.

If the first element of a $ line is a full path to a file, or a path relative to your Bunch folder1, and the file exists, it will be executed directly. This assumes either a binary or an executable file with a proper hashbang in the script. Arguments can be passed on the same line.

Any spaces in filenames or within arguments should be escaped just like they would on the command line, using either double quotes or escaping individual spaces with backslashes.

If the script has a “shebang” line, it will be executed using the specified processor, e.g. #!/usr/bin/ruby will cause the script to be run as /usr/bin/ruby SCRIPT ARGS. If it lacks a shebang, it will be executed using /bin/sh SCRIPT ARGS.

Multi-line scripts can also be embedded using the same heredoc syntax as variable assignment. The contents of the heredoc block will be saved to a temporary file and executed as a script. This allows you to embed multi-line scripts and commands in your Bunch without having to generate external script files for every one.

Heredoc scripts start with $ for shell scripts and * for AppleScripts. If you use $, you should also provide a shebang line (e.g. #!/usr/bin/python) to tell the system what to process the script with. If there’s no shebang, the script will be assumed to be a shell script executable by /usr/bin/sh.

If it’s a * command, a shebang of #!/usr/bin/osascript will be added automatically if one doesn’t exist, so you can just write AppleScript out as if you were in Script Editor.

All lines within a block will be outdented to the indent level of the first line.

Variable placeholders can be used in heredocs. Heredocs do not accept environment variables on file lines following them the way that regular script/command lines do.

You can also use snippet syntax to import shell scripts, allowing for use of fragments to combine multiple scripts into one file (or an embedded snippet).

This works for both shell ($) and AppleScript (*) script lines. In most cases you’ll probably want to just write actual scripts and execute them directly, but if you want to combine multiple scripts with fragment headers or make use of embedded snippets to store scripts for the current Bunch, this syntax will do the trick.

If the content of the $ line is not a recognizable file, it will be executed with /bin/sh -c. It’s possible to chain commands with && and ||.

It’s not recommended that you background commands run by a Bunch (using &).

You can specify direct arguments after the command or shell script path. As with Automator Workflow items, you can also use - ... lines below the script line to set environment variables.

When Bunch launches it checks your default shell ($SHELL) and performs a login in the background to get your usual environment variables. Your path and any custom environment should be picked up before the first time you run a script.

Additionally, the following environment variables are available:

You can fork a script using the $BUNCH variable. If you have a script with common tasks but you need it to differ between Bunches in some way, do something along the lines of (in Bash):

if [[ $BUNCH == Podcast ]]; then...

if ENV['BUNCH'] == "Podcast"

Et cetera. You can also fork on BUNCH_PHASE to perform different tasks when opening and closing a Bunch using the same script.

If you need to provide additional environment variables to your script, include them as “files”:

These will be the equivalent of an export FOO=bar command prior to running your script. If you set HOME, it will override what Bunch sets. If you set PATH, it will overwrite the path that Bunch picked up automatically.

The contents of the Bunch’s frontmatter are also made available as environment variables. For example, if your frontmatter includes Last Name: Meyer, it would be available as $lastname in a shell script. All built-in frontmatter keys and any arbitrary keys defined are accessible.

Remember that you can always manually source your startup or configuration files from your default shell within any shell scripts. For example, if you want to use RVM in a Bunch script, use something like this at the top of the script:

Zsh users will want to note that .zshrc won’t be read by the non-interactive shell that Bunch runs. Environment variables you want picked up should be stored in .zshenv.

Bunch doesn’t do anything with the output of a command other than report it in the log or the task monitor (except in the case of from script frontmatter). If you want to react to shell command output, use Automator with a Run Shell Script action. If you want feedback while running, you can always use AppleScript in your shell script:

Scripts launched by a Bunch show up under “🔴 Shell Scripts” in the Bunch menu. Clicking any script in the list will open a task monitor for that script. The monitor shows STDOUT at the top, STDERR at the bottom, and the status bar shows whether the task is running, paused, completed, or terminated along with any non-zero exit codes.

Closing the window does not terminate the task. Windows can be reopened at any time from the Shell Scripts menu.

The display window understands ANSI colors and emoji in the script or command output.

There’s a Pause button that will suspend the primary task for the monitor. If the primary task is a script that has launched subprocesses (as most scripts do), those subprocesses will not be paused by this button. When a script is paused the button will read “Resume” and will resume the paused task when clicked.

The Kill button will send a SIGSTOP command to the process. This should kill any child processes as well, assuming they haven’t been run in the background by the script. Once a script is terminated or completed, the button changes to read “Restart” and clicking it will re-run the script or command.

Pause and Kill buttons do not appear on windows set to “wallpaper” level. These windows cannot be interacted with, so there’s no point in having buttons. The STDERR output is also set to 20% of the window’s height, as it can’t be manually revealed at wallpaper level.

You can cause a task monitor to display for a task automatically by including (display) at the end of the command:

To use both the task monitor and a delay, the delay must appear after the display:

The display command in a shell command can take the same arguments as the regular display command, just without the file path that the regular command would require. For example, to run a command with a visor-like window on your second display, you can use:

If a background color is specified without a foreground color, a contrasting color will automatically be assigned. If your background color is more than 50% black, the window will be Dark Aqua (dark mode appearance), lighter backgrounds will get regular Aqua (light mode appearance).

All size, positioning, and color arguments are optional, and any combination of them can be used. See the display window documentation for details.

The following runs a script that sets up a local Jekyll server for developing this documentation, with a task monitor in the upper right quarter of my secondary display:

If you have multiple scripts that need to run in order, set the sequence of execution to “sequential.” With this set, you can use | prefixes to launch other items in parallel, if desired, but scripts will wait for the previous script to complete before executing.

As an alternative to using the task monitor, you can send keystrokes to your terminal application to run commands in an interactive shell. The following example works with both Terminal and iTerm.

This sends a ⌘T to open a new tab, then types out commands, pressing return after each.

Remember that relative paths in Bunches within subfolders are relative to the base Bunch Folder, not the containing subfolder. ↩

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
$ say "I'm a shell command!"
```

Example 2 (unknown):
```unknown
$ my\ script.sh "argument 1" arg2
```

Example 3 (bash):
```bash
$ ```
#!/bin/bash
say one
say two
/usr/bin/ruby run_my_script.rb
```
```

Example 4 (sql):
```sql
* <<EOFILE
set source_folder to choose folder with prompt "Please select directory."
-- do some cool stuff
EOFILE
```

---

## Delayed Launch - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/delay/

**Contents:**
- Launching After A Delay
- Delaying Groups
- Delay Command

You can have an app, script, or command execute after a delay by adding a tilde immediately followed by a number (integer) at the end of the line. For example, to wait 5 seconds before executing an AppleScript, you would use:

The delay only applies to the line it’s on, it doesn’t delay the processing of lines after it. Anything without a delay specified will launch immediately.

You can use snippets to delay groups of items. Just put the items into a snippet file (or an embedded snippet) and add the tilde+number.

You can also put a delay on snippets that run when the Bunch closes, triggered X seconds after closing the Bunch:

See the Snippets documentation to learn how to have snippets wait until apps have finished launching.

You can also insert delays as commands. This only works when the Bunch’s execution sequence is set to sequential (or Parallel execution is disabled entirely in Preferences).

To pause a Bunch before opening remaining items, use (pause X), where X is a number of seconds to wait (must be a whole, positive integer). You can also use (delay X), which is a synonym for pause.

This will launch Affinity Publisher, then wait 15 seconds. The Bunch menu will be inaccessible during this time, but Affinity Publisher (and any apps/scripts/commands before the pause command) will continue to launch. After 15 seconds, processing will continue, starting with the execution of MyWorkflow.

You can also insert pauses between file lines:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
* say "I've been waiting for you" ~5
```

Example 2 (unknown):
```unknown
< example.snippets ~5
```

Example 3 (unknown):
```unknown
!< example.snippets ~5
```

Example 4 (swift):
```swift
Affinity Publisher
(pause 15)
& MyWorkflow
```

---

## Shortcut - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/shortcut/

**Contents:**
- Shortcut Command
- Examples
- Input/Output
  - Examples
    - See Also:

Trigger a macOS Shortcut by name. The name is case insensitive and fuzzy matched, the only requirement is that it start with the correct letter and all remaining characters are within two positions of each other in the actual shortcut name. Partial names are OK, the shortest matching Shortcut will be selected.

A Shortcut with matching name must exist in the Shortcuts app in order to be triggered by a Bunch. That’s obvious, right?

You can pass input to a shortcut by including text in double quotes after the shortcut name. This can include variables, but must be wrapped in quotes.

Any output returned by the shortcut can be assigned to a variable. Your shortcut must include a “Stop and output” action that returns a value.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (typescript):
```typescript
// works with `sc`, `short`, and `shortcut` as the command
(sc Work Mode)
!(sc work mode off) // or (shortcut work mode off)
```

Example 2 (bash):
```bash
result = (shortcut SearchLink "!g ${LinkText}")
```

---

## Delayed Launch - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/delay

**Contents:**
- Launching After A Delay
- Delaying Groups
- Delay Command

You can have an app, script, or command execute after a delay by adding a tilde immediately followed by a number (integer) at the end of the line. For example, to wait 5 seconds before executing an AppleScript, you would use:

The delay only applies to the line it’s on, it doesn’t delay the processing of lines after it. Anything without a delay specified will launch immediately.

You can use snippets to delay groups of items. Just put the items into a snippet file (or an embedded snippet) and add the tilde+number.

You can also put a delay on snippets that run when the Bunch closes, triggered X seconds after closing the Bunch:

See the Snippets documentation to learn how to have snippets wait until apps have finished launching.

You can also insert delays as commands. This only works when the Bunch’s execution sequence is set to sequential (or Parallel execution is disabled entirely in Preferences).

To pause a Bunch before opening remaining items, use (pause X), where X is a number of seconds to wait (must be a whole, positive integer). You can also use (delay X), which is a synonym for pause.

This will launch Affinity Publisher, then wait 15 seconds. The Bunch menu will be inaccessible during this time, but Affinity Publisher (and any apps/scripts/commands before the pause command) will continue to launch. After 15 seconds, processing will continue, starting with the execution of MyWorkflow.

You can also insert pauses between file lines:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
* say "I've been waiting for you" ~5
```

Example 2 (unknown):
```unknown
< example.snippets ~5
```

Example 3 (unknown):
```unknown
!< example.snippets ~5
```

Example 4 (swift):
```swift
Affinity Publisher
(pause 15)
& MyWorkflow
```

---

## Tags - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/tags/

**Contents:**
- Organizing With Tags

You can add tags: frontmatter to a Bunch for organization and batch operations.

These tags generate a submenu. In the example above, you would now see a new Tags menu item in the Bunch menu, containing tag1 and tag2 submenus. The tagged Bunch would show up in each of the menus, along with any other Bunches containing that menu’s tag.

You can also apply frontmatter keys to all Bunches with a given tag using @tagname.frontmatter files.

From within a Bunch, you can use a backslash to operate on tagged Bunches. To open all Bunches tagged with “tag1”, you would include \tag1 on a Bunch line.

Multiple tags can be combined. Combining with a comma produces an OR boolean, so \tag1,tag2 will launch any Bunches containing either tag1 or tag2. Use a plus sign to combine with AND, so \tag1+tag2 will only launch Bunches tagged with both tag1 and tag2.

You can close tagged Bunches with !\tagname. You can also launch tagged Bunches when closing the parent Bunch using !!\tagname.

Be aware that if you call a \tag command from within a Bunch containing that tag, that Bunch will also be affected. Be cautious as results can be unpredictable if Bunches calling Bunches get nested too deeply.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: My Tagged Bunch
tags: tag1, tag2
---
```

Example 2 (yaml):
```yaml
---
title: Launching other Bunches
---

\tag1
```

---

## Desktop and Dock - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/desktop/

**Contents:**
- Dock Commands
  - Examples
- Menu Bar Commands
  - Examples
- Desktop Commands
  - Examples
    - See Also:

(hide dock) and (show dock) hide and show the Dock (toggle Hiding). Reposition the dock with (dock left), (dock bottom), or (dock right).

Hiding is automatically reversed when closing the Bunch, positioning is not.

macOS 11+ (Big Sur) only.

(hide menu bar) and (show menu bar) hide and show the Menu Bar. Automatically reversed when closing the Bunch.

Hide and show desktop icons: (hide desktop), (show desktop). Automatically reversed when closing the Bunch.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(show dock)
(dock bottom)
```

Example 2 (unknown):
```unknown
(show menu bar)
(hide menu bar)
```

Example 3 (unknown):
```unknown
(show desktop)
(hide desktop)
```

---

## Quit Everything - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/quit-everything/

**Contents:**
- Quit Everything Command

Sometimes you just want a clean slate. The Quit Everything command kills all running applications, with any exceptions that you specify.

The command (quit everything) will quit every app that shows up in the Task Switcher/Dock except for Finder. It will not quit apps that are running in your menu bar or in the background.

To quit everything except certain apps, use (quit everything except...) and include a comma-separated list of app names or bundle identifiers.

This command responds to some variations. You can quit, kill, or burn everything or all, but or except.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(quit everything except MailMate, Firefox, Xcode)
```

Example 2 (unknown):
```unknown
(kill all but iTerm)
(burn everything except nvUltra, MailMate)
(quit all)
```

---

## Execution Sequence - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/sequence/

**Contents:**
- Sequential vs Parallel
- Changing Sequence for a Single Bunch
- Changing Sequence for a Single Item
    - See Also:

Out of the box, Bunch launches items in a Bunch file in sequential order. You can change this using Preferences->Bunch Behavior->Launch Items In Parallel. When this is off, Bunch executes items in the Bunch file in the order they’re listed, sending one item to the queue at a time. The actual order may be out of sequence depending on the execution of the queue by the system, but if you have items (apps, scripts, etc.) that rely on other things happening first, this is ideal.

When this is turned on, all items in the Bunch file are added to the queue to be executed asynchronously, meaning they more or less all happen at the same time, and one item taking a long time won’t stop other items from running. This makes for very fast Bunch opens. If the order of execution in your Bunches as a whole isn’t important, turn this feature on. You can affect it on a per-file or per-item basis as needed.

You can change the sequence of execution for a single Bunch, regardless of the Preference setting, by using the frontmatter key sequence. This can be set to either sequential or parallel. You only need the first letter of either value to trigger it, so sequence: p is all it takes to enable parallel execution for the Bunch.

(Just to make things confusing, you can also use parallel: true|false or sequential: true|false. Whatever makes the most sense to your brain.)

If the “Launch Items in Parallel” preference is turned off, or the Bunch has frontmatter that disables it, you can still affect individual items by putting a pipe (|) in front of the line. This works on everything except snippets, but can be used on items within snippets.

Items marked with a pipe are taken out of the sequence and executed immediately in the background. Execution will not wait until their line in an otherwise sequential Bunch file.

If the script is an on-close script, put the pipe before the exclamation point.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: All At Once
sequence: parallel
---
```

Example 2 (markdown):
```markdown
|$ scripts/parallel1.sh
|$ scripts/parallel2.sh

# On close
|!$ scripts/close1.sh
|!$ scripts/close2.sh
```

---

## Startup Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/startup-scripts

**Contents:**
- Auto-launch Bunches on startup
- With .startup Scripts
- With Frontmatter
  - Interactively
  - Selectively for Synced Macs
  - Batch Launching
- Conflicts
    - See Also:

You can launch Bunches automatically whenever the app starts. This can be useful if you have Bunch set as a Login Item and you have a set of apps you want to launch every time you log in. By using Bunch to do this rather than adding them to the Login Items as well, you can easily quit apps in groups, as well as access Bunch commands and scripts.

There are two ways to launch a Bunch on startup. The first way is with a dedicated “startup script.”

To launch Bunches on startup, create a file in your Bunch directory with the extension “.startup”. Any filename will work, and all files ending in “.startup” will be processed.

The file should contain a list of Bunches to launch, one Bunch per line. The “.bunch” extension is not required. Note that these startup files can only contain names of Bunches to launch, not regular Bunch lines of any kind.

If you have Single Bunch mode enabled, only the last item processed will be launched. Otherwise all lines of all “.startup” files will launch, not that you’d ever need more than one…

You can also add a startup: true key to the frontmatter of any Bunch to have it open when Bunch launches. All Bunches with startup: true will be opened after any .startup files have been processed.

If startup: is set to ask, a prompt will be displayed on launch. Cancelling that prompt will skip opening the Bunch.

If you sync your Bunches to multiple Macs, you may want to specify which Mac(s) run the Bunch as a startup script. To do this, open Preferences and press the “Copy UUID” button. Paste the result as the value of the startup: key and the startup will only be triggered on the Mac that matches this value. Multiple UUIDs can be combined with commas.

You can also use startup unless: instead of startup:. This has the inverse effects for excluding specific Macs by UUID.

You can use folder.frontmatter to apply startup: true to all of the Bunches contained in a subfolder. This makes adding and removing Bunches from startup as easy as moving them in and out of a folder. Just create a subfolder and add a file called folder.frontmatter to it. Include the startup: true key in that file and it will be applied to all of the Bunches it contains.

Be careful when auto-launching Bunches that quit other Bunches, as this can lead to unexpected behavior. Bunches are launched asynchronously, so you can’t be sure what order the events will happen in. Avoid having !Name.bunch lines in any Bunches launched by a startup script.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: My Startup Bunch
startup: true
---
MailMate
Messages
```

---

## Interactivity - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/interactivity/

**Contents:**
- Interactive Bunches
- Section Contents
    - See Also:

There are a few ways to add interactivity to a Bunch.

All materials copyright © Brett Terpstra 2021

---

## Sleep - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/sleep/

**Contents:**
- Sleep Commands
- Examples
    - See Also:

(sleep) will immediately sleep your Mac.

(sleep display) will sleep the display.

(sleep screensaver) will start the screen saver, also locking your machine if you have that set up in System Preferences.

See also: Awake Commands

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(sleep)
(sleep display)
(sleep screensaver)
```

---

## Variables - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/variables/

**Contents:**
- Using Variables
- Default Variables
- Defining Variables
  - Direct Assignment
    - Heredoc
    - Snippet/External File
  - In Frontmatter
    - Dynamic Frontmatter
  - With a Script
  - With a Dialog

Bunch allows the use of variables within Bunches and Snippets, adding flexibility and dynamic capabilities to your Bunches.

Some variables are populated automatically and can be referenced within a Bunch.

In order to use a variable within a Bunch, you need to give it a value. Variables get their values in a variety of ways: from frontmatter, from interactive dialogs, or from arguments passed when opening a Snippet or Bunch from within a Bunch or via automation tools. You can also assign variables directly in the Bunch using strings or file imports.

Direct assignment works like most scripting languages, defining the variable and it’s value like this:

You don’t need to quote or escape the value in any way. This is essentially the same as defining the variable in frontmatter, but allows you to define/modify values within conditional logic blocks.

If you want to create a value with multiple lines, you can use one of Bunch’s heredoc syntaxes.

The first form of this syntax is similar to fenced code blocks in Markdown. You start the block with three backticks (```) and a newline, insert your text, then end the block with another newline and triple backticks.

All content will be outdented to the level of the first line, so you can indent the entire block as much as you like for readability.

The last three backticks must be on a line by themselves, but can be indented with any number of tabs and/or spaces.

The second heredoc syntax is taken from programming languages, using <<MARKER to start the block, and MARKER on a line to end the block. MARKER can be any combination of uppercase alphabetical characters (basic latin A-Z only).

Like the Markdown syntax, all content between the start and end markers will be outdented to the level of the first line.

You can also use Bunch’s snippet syntax when defining a variable, including fragment support.

The contents of the file external.snippet (relative to your Bunch folder) will be imported as the value of my_var. If the file you’re importing makes use of fragments, you can specify that with <external.snippet#fragment name.

This syntax also supports embedded snippets, e.g. my_var = <<#Text Section. As long as nothing else is trying to execute the text section as Bunch lines, you can include any text you want in the embedded snippet or fragment.

A variable is a key and a value. You can define the variable in frontmatter by using a key: value line. As long as the key doesn’t conflict with one of Bunch’s built-in keys, you can use anything you want. Keys should be letters, numbers, and underscores only.

The variable my variable is now available for use in the Bunch and any snippets it calls. See using variables to see how.

Using the dynamic frontmatter options from file or from script, you can set variable values dynamically when opening the Bunch.

Variables set by reading a file or running a script will supersede any values hard coded in the frontmatter.

You can set a frontmatter key’s value using a script (shell script or AppleScript). To do so, use the format:

A script line like this is executed in the order of the Bunch. It should appear before any usage of the variable, but can be added after other script items and will allow their execution before running.

If your script returns more than one line, newlines are translated to \n in the variable’s value. This allows Bunch to treat it as one line, making it available for uses like string comparisons in conditionals. You can output the newlines in various ways; see the notes on transforms.

See the CodeKit example Bunch for a demonstration of this in action.

You can use interactive dialogs to define values for variables. See Interactivity->Variables to learn how. A dialog that sets a variable will only be triggered if the variable is not already assigned a value via another method.

For an example of a Bunch with a multiple choice dialog, see the Coding example Bunch.

You can also directly assign a variable from within a Snippet, including embedded snippets. This abstracts the process, but allows you to use a dialog to load Snippets and have the variable set by the snippet instead of by setting with the dialog itself. A variable set within a snippet is available after the snippet is imported, but will not override a variable already set by other methods (see Variable Precedence).

To assign a variable directly from a Snippet:

Direct assignment also works in a Bunch itself, having the same effect as setting a frontmatter key. For the sake of clarity, it’s better that you use frontmatter in this case.

When you call a Bunch or Snippet from within a Bunch, you can use file lines with key=value pairs to set frontmatter and variable values for them.

For a Bunch, you would use:

This value would override any matching key in MyBunch.bunch’s frontmatter. The value would then be available to MyBunch, any snippets it calls, and any Bunches it opens.

For a Snippet, you would use:

This variable would be set only for the snippet, but would not affect the frontmatter keys for the calling Bunch or any Bunches the snippet calls.

Values set using file lines will supersede any frontmatter or dialog values.

You can also define variables in query strings when using the URL handler. Arbitrary key=value pairs can be added when using the methods for opening, closing, and toggling Bunches, and when running Snippets directly.

When using Bunch’s AppleScript, you can add with variables and include a query string of keys and values, e.g. with variables "variable1=My Value&variable2=Other Value".

Values set in this manner will supersede frontmatter values, but will be overridden by file lines.

With this capability, you can create Bunches that focus efforts around a particular file (or files), but change that file with each opening of the Bunch. Set up a `${placeholder} in the Bunch for the filename, then specify the file in the url when calling the Bunch.

Scenario: you have Hazel watching for new audio files that need processing in a shared Dropbox folder. A new file shows up, and a Hazel script adds an entry to your task manager that includes a Bunch url with the file specified as a parameter. Clicking it not only switches to your audio editing context, but also loads the file in question in your audio editor.

You can use the keyword global when setting a variable and the value will be stored in Bunch’s preferences, accessible to other Bunches and persisting across application launches. To make a variable global just put global in front of the variable name (with a space between):

You can reference a global variable just like any other variable: ${my_global_variable}. It can be used in logic conditions in any Bunch, e.g. if my_global_variable is true.

The last value assigned using the global keyword is what will be stored. Modifying a variable’s value without the global keyword does not affect the global value, only the value local to the current Bunch.

If a variable with a matching name is set within a Bunch, that value will take precedence over the global variable’s value. Global variables have the lowest precedence, so even a value set in a Bunch’s frontmatter will override it.

Because variables can be set in multiple ways, you need to be aware of which value takes precedence. Variables are set in this order, the top available value (lowest number in the list below) being used.

Precedence also takes into account assignment order. If a variable is already assigned (e.g. by a URL handler query string), a dialog that sets that variable (var = ?[]) will be skipped, as will a direct assignment (var = val). This allows you to, for example, skip a dialog if opening via a URL by setting the variable in the URL itself.

If variable values are read from multiple frontmatter files, e.g. @tag.frontmatter where more than one file applies, duplicate keys will receive the value found in the last file read (which is typically the last filename alphanumerically).

Bunch is not (yet) an actual compiler, so things like scope and sequence are different from a scripting language.

Variable placeholders are replaced as soon as their value is known, and variables assigned inside of conditional logic are parsed after placeholders outside of the condition are already updated.

For example, we assign a variable at the top of the Bunch or in frontmatter, then in a conditional block we append more text to its value, and then at the end we use the value in a placeholder. The value at the end will be replaced with the initial value before the conditional block appends the new value, so the changes within the conditional block won’t be reflected in the final use of the placeholder.

To illustrate, the example below will log “Prefix text”, as the appended text isn’t added until after the placeholder in the log statement is already replaced:

The solution to the above example is to use a different value for the initial value and the appended value. If our first variable is defined as pre_text = Prefix, and then in the conditional block we use final_text = ${pre_text} appended text, then we can use ${final_text} in our placeholder at the end, and it won’t be replaced until final_text receives its value.

Once a variable has a value, you can use it in your Bunch or Snippet by adding a placeholder in the format ${variable name}. Remember that spaces are removed and the name will be lower case when looking up the variable’s value, regardless of casing and spacing in the key you defined, so ${Variable Name} is the same as ${variablename}.

In a Bunch or Snippet that might look like:

You can use a placeholder anywhere, including in an app or command line.

Placeholders can not be nested within other placeholders.

You can transform the output of a variable placeholder using a set of pre-defined transforms with the syntax ${VarName/[transform]}. The available transformations are:

Transforms can be used in addition to default values: ${VarName/url:Default%20Value}. Transforms are not applied to default value replacements by default, but can be added if needed: ${VarName/url:Default Value/url}.

When variables are assigned values containing newlines, usually through script output or heredoc syntax, the newlines are converted to the characters “\n”. When output as /raw, these are converted back into actual newlines. This allows contents to be used as part of a Bunch. Say for example you had a text file containing a list of options, perhaps dynamically generated:

The contents of this file can be inserted into a dialog using the /raw transform:

When performing /url transforms, “\n” is first converted to actual newlines, and then the newlines are percent encoded.

When performing /shell transforms, “\n” is left as is, and not double-escaped. Output with echo -e, this results in an actual newline being echoed.

Tip: If you want to use a variable containing newlines in a shell command, you can use $'${variable_name}' to have the shell (/bin/sh) respect the newlines as part of the argument. So if your variable contains one\ntwo, you could use $ say $'${variable/shell}' and you would get the expected results (your Mac would say “one two”).

When performing /typed transforms, “\n” is converted to \\n, so that a Bunch keystroke command (e.g. - [${VarName/typed}]) will send a carriage return in its place.

As a shortcut to the /url transform, you can use a percent symbol (%) instead of a dollar sign ($):

You can (and generally should) define a default value for a placeholder. This will be used if the key is empty by the time the placeholder is reached. Add default values after a colon within the placeholder:

This is especially useful within a main Bunch, allowing the Bunch to function normally when called directly, but changing its functionality when it’s called from other Bunches or via the URL handler.

You can get the contents of your clipboard into a variable using the pbpaste command. Bunch will automatically strip any newlines from the beginning and end of the contents, so you can simply run:

Now you can use the contents of your clipboard in a snippet, e.g. to pass to a URL handler or test as a condition with tests like if starts with or if contains.

Bunch doesn’t have built-in date placeholders, but you can achieve them in a variable using the UNIX date command. This command uses strftime placeholders and can generate just about any format of date/time string you need. See this article for examples and a list of placeholders.

Variables are processed in document order, so you can use any variable that has been assigned in a preceding line as part of a command.

You can use UNIX commands like tr and sed to perform text manipulation, or shell out to your preferred scripting language like Python, Perl, or Ruby with one-liners.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
my_var = The Value

// which can now be used as
* say "${my_var}"
```

Example 2 (unknown):
```unknown
my_var = ```
         line one
         all of this will be outdented
         line three
         ```
```

Example 3 (unknown):
```unknown
my_var = <<EOFILE
         line one
         all of this will be outdented
         line three
         EOFILE
```

Example 4 (unknown):
```unknown
my_var = <external.snippet
```

---

## Bunch Files - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files

**Contents:**
- Section Contents
    - See Also:

The Bunch menu is created by reading text files from your Bunch folder. To show up in the menu, the file just has to have the extension .bunch. Bunch files contain apps to launch, URLs to open, commands to run, and more. Learn more about the syntax and features below.

You can edit Bunch files in any text editor. That includes TextEdit, but if you’re using TextEdit (or any app that has a Rich Text mode), be sure to switch to Plain Text mode. In TextEdit, that’s under Format->Make Plain Text.

All materials copyright © Brett Terpstra 2021

---

## Opening Websites/URL schemes - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/opening-web-pages

**Contents:**
- Opening URLs
- Opening URLs in a Specific Browser
  - Opening in a Specific Chrome Profile
  - Quitting Browsers On Close (Beta)
- Preventing Duplicate Tabs
- Sending GET/POST Requests
    - See Also:

If you want to open web pages as part of a Bunch, you can just put a URL at the beginning of a line (like you would an app) and that URL will be opened in your default browser. If the URL is a URL scheme for an installed app, it will be executed as if called from a link or via the open command.

If you want to open a url in a specific browser, you can use prefixes before the url. Examples:

The recognized browser prefixes are:

In most cases, you can also send a URL as a file to a browser and it will open it properly, as in:

For the chrome: and canary: prefixes, you can also include a profile name in square brackets to have a url open in a specific profile. This will open a new window with the profile, and multiple links targeting the same profile will open tabs in that window.

Profile names are case insensitive and allow partial matches (“work” will match the profile “Work Profile”). Bunch will go with the first matching name it finds.

Profiles cannot be used when passing URLs as file lines.

Beta Feature: this feature is currently in development and is only available to those using the preview build. If you want to help test new features, feel free to download and run the beta release.

If you set quit browsers: true in frontmatter, browsers opened with browser:url syntax will be quit when the Bunch closes. This can be modified per line with a % prefix to ignore on close.

Bunch doesn’t parse open tabs to determine if a URL would open a duplicate tab, but you can add extensions to your browser to accomplish this.

Some URLs, such as webhook triggers, are meant to be pinged but not opened in your browser. To accomplish this with Bunch, you can use the curl command in a shell script item. See Home Automation for examples of sending GET requests using curl.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
https://hulu.com
https://brettterpstra.com
x-marked://open?file=filename.md
```

Example 2 (yaml):
```yaml
safari:​https://brettterpstra.com
firefox:​https://mozilla.org
```

Example 3 (markdown):
```markdown
Safari
- https://bunchapp.co
```

Example 4 (unknown):
```unknown
chrome[work]:https://brettterpstra.com
chrome[work]:https://duckduckgo.com
chrome[personal]:https://hulu.com
```

---

## Desktop Screen - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/screen/

**Contents:**
- Desktop Screen Command
- Examples:
    - See Also:

The (screen) command creates a layer of solid color that can be used to hide applications and Desktop icons. Clicking on the layer will hide everything (except for floating windows), then activating apps using the Dock or ⌘-Tab will bring them in front of the layer.

The screen command accepts two optional arguments, background color and alpha transparency.

Screens are created for all attached displays. If the number of displays changes, the command will regenerate screens to match the new number.

The two parameters can be combined in any order: (screen #666 90%)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(screen #9a9a9a)
(screen #404040 90%)
```

---

## Spotlight Searches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/spotlight-searches

**Contents:**
- Using Spotlight Queries
- Tag Search
- Spotlight Search
    - See Also:

In the dashed lines that follow an app, you usually list files you want to open in that app. But you can also run some searches and open the results instead.

You can use hashtags on a line to search for one or more tags. Multiple tags are joined as a boolean AND, meaning files must contain all of the tags to match.

You can limit these searches to one or more directories by including a comma-separated list of paths in square brackets:

By default all searches are limited to 15 results, just so that a wayward search query doesn’t leave you with 1000 files open in random applications. You can override this limit in either direction by adding an exclamation point followed by a number to the end of the line:

Scopes and limits can be combined.

You can also harness the full power of Spotlight using the syntax you’re used to in the floating Spotlight window. Just surround your search in single quotes. A scope can be defined as above, but with this query you can only specify one folder. It defaults to your Home folder and all of its subfolders. The same scope and result limit modifiers as above apply.

You could use this to review files at the end of the day. Schedule a Bunch to launch at 4:30pm, and have it open recent files on your Desktop or in your Downloads folder for review:

Tip: Along the same lines, you can also use the URL handler to create links you can put into OmniFocus or Things to load up a daily review.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
Default
- #Taxes #2020
```

Example 2 (markdown):
```markdown
Default
- #Taxes #2020 [~/Dropbox/Receipts]
```

Example 3 (markdown):
```markdown
Default
- #Taxes #2020 !25
```

Example 4 (json):
```json
Default
- 'kind:"affinity photo" tag:brettterpstra.com name:template' [~/Dropbox] !5
```

---

## Log - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/log/

**Contents:**
- Log Command
- Examples
    - See Also:

The log command simply logs a string to the Bunch Log. The contents of the command will show up in the log as a Warning level item (with a yellow indicator).

This is mostly useful for debugging Bunches and can be used to see what a variable is being set to in the Bunch. Because variables can take their value from scripts, frontmatter, dialogs, and outside settings like URL handler parameters, it can be useful to see what setting it ends up with depending on how it’s called.

If your Log Level is set to Errors Only, log commands won’t register in the log. See the Bunch Log documentation for details on setting the Log Level.

You can also use it when debugging by setting the execution order to sequential and placing log statements at various points in the Bunch to see when they’re reached.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (bash):
```bash
(log myvariable is set to ${myvariable})
```

Example 2 (yaml):
```yaml
---
title: Debug Bunch
sequence: sequential
---
Messages
(log Messages launched)

Discord
(log Discord launched)
```

---

## Audio - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/audio/

**Contents:**
- Audio Commands
- Examples
    - See Also:

Change your system input and output devices, as well as control the volume of either.

To set an audio device, you just need to specify input or output, and then provide all or a unique part of the name of an existing device (case insensitive, first match wins). For example, (audio input scarlett) would set my system input to my Scarlett Solo. (audio output io hub) would change my system audio output to my iO Hub.

The audio device names Bunch looks for are the same as what’s in the volume menu in the menu bar. On Big Sur, open the control center and option-click on the Sounds title. On previous OSs, option-click the volume icon for a full list.

The volume command defaults to output volume if input or output is not specified (e.g. (audio volume 50)). Specify input or output before a volume or mute command to affect one channel or the other. (audio output 0) will simulate mute — use (audio output mute) to actually mute the channel while preserving volume setting (unmute with (audio output unmute)). (All of the preceding commands will work with either input or output.)

See Bunch gets audio control for more info.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(audio output Macbook Pro)
(audio output volume 50)
(audio input Scarlett)
(audio input mute)
```

---

## Comments - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/comments/

**Contents:**
- Commenting a Bunch
- Line comments
- Block Comments

Comments can be included in your Bunch files. They can be used to remind yourself what a long key combo string or a why apps are in a specific sequence, or they can be used to explain things when sharing Bunches with others. (Admittedly, they’re mostly so I can clearly explain things in example Bunches.)

Line comments are preceded by # or //. They can be at the beginning of a line, or included with a regular line at the end. Comment indicators must be followed by one or more spaces, and inline comments (comments at the end of a line) must also be preceded by one or more spaces, e.g. AppName // Inline comment.

Inline comments can not be used on the same line as fragment headers, variable assignment lines, or script lines.

Block comments can also be used. These are delineated with /* at the beginning, and */ at the end. These markers can be on the same line or on their own line.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (elixir):
```elixir
// This is a line comment
# This is also a line comment

%MailMate // this is an inline comment
@Xcode # This is also an inline comment

# Not to be confused with snippet fragment identifiers,
# which don't have a space before or after
<Useful.snippets#Fragment ID

# Though you can use comments *after* a fragment ID...
<Useful.snippets#Fragment ID # as long as it's surrounded by spaces

// Also not to be confused with fragment identifiers in snippets,
// which function as comments but also require square brackets
###[My Fragment]###

// But they won't work on a fragment divider line
###[My Fragment]### # This fragment won't be found.

// Inline comments also won't work on script lines
$ echo # This comment is part of the command, even though the shell will ignore it
// Or on variable assignments
my_var = Value # This comment is read as part of the value
```

Example 2 (julia):
```julia
/* This is a block comment
   It has a couple of lines */

/******************************
/* This is also a block comment
/* with some decoration.
/*
/* It will keep going until the
/* end marker.
/******************************/

/*
Or keep it simple
*/
```

---

## Commands - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/

**Contents:**
- Bunch Special Commands
- Reversing Commands
- Section Contents

Commands are run by using lines surrounded by parenthesis in Bunch files. These offer shortcuts to some system tasks and special actions.

Most commands are automatically reversed when closing a Bunch (hidden Desktop icons are shown, hidden dock is revealed, wallpapers switch back, etc.). Notable exceptions include Dock positioning, notification, and audio commands, which are not restored to their previous state when the Bunch closes.

To avoid reversing a command when closing the Bunch, precede the line with a % symbol, e.g. %(hide dock) (just like ignoring applications when quitting).

To run the command only when closing a bunch, use an exclamation point (!) before the command, e.g. !(show desktop).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(dark mode [on|off])
(do not disturb [on|off])
(hide dock)
(show dock)
(dock [left|right|bottom])
(hide desktop)
(show desktop)
(wallpaper [path(s)])
(screen)
(audio [input|output] device_name)
(audio [input|output] volume [0-100])
(audio [input|output] [mute|unmute])
(input source [name])
(notify TEXT)
(display FILE)
(sleep [display])
(awake [interval])
(log [MESSAGE])
(shortcut [SHORTCUT NAME])
```

---

## Apps - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/apps

**Contents:**
- Application Actions
- Launching Apps
- Opening Files
  - Opening Finder Tabs
- Opening Files in Their Default Application
  - Inserting a Pause
- Closing Windows
- Hiding Apps
- Activating Apps
- “Focusing” an App

Within a Bunch file you simply list the apps you want it to launch, one per line. For example, in “Comms.bunch”:

You can add additional lines to perform actions like opening files.

If the app in question is not responding, see the troubleshooting section on App Names.

You can additionally have an app open specific documents, if the app supports that. After the app name, simply add one or more documents on lines that begin with a dash. For example, to have Numbers open two specific spreadsheets:

Paths to documents can use a tilde ~ to represent the home directory. Spaces are fine, no quotes or escaping needed.

You may want to close all open windows before opening new files. To do that, use XX

You can also specify a file as a URL to have Bunch open it in whatever app is defined as the default handler for it. For example, if you put the following on its own line, Bunch would open TaskPaper* with the file (note that spaces are replaced with %20):

This is the same as specifying “default” as the app (see below).

* This assumes TaskPaper is installed.

There’s a special syntax that currently only applies to Finder. If you want multiple folders to open in tabs, list the first folder on a normal file line, then the other folders that should open in the same window with -> preceding them:

You can open multiple windows by starting a new line without the >. The following will open two windows with two tabs each:

For reasons I can’t explain, doing this via System Events is excruciatingly slow. This process will run in the background and it’s OK to click other windows while waiting for the Finder tabs to finish opening.

You can just put the word “Default” on a line before some file lines, and it will open all of those files in whatever app is assigned as the default on your system. PDFs might open in Preview or PDFpen, Pages files would open in Pages, etc.

This is especially handy when using Spotlight searches instead of files.

You can pause between files by inserting a file line containing (pause 5) (for a 5 second pause). The number must be a positive integer representing a number of seconds, with no letters or decimals. This is mostly useful if you want to send keystrokes or wait for a URL to load between actions.

If you include a file line containing only “XX”, then all windows for the app will be closed. This can be included before lines that open new files/windows to start with a clean slate.

This will only work if the app responds to the AppleScript command close every window. Most apps do, but there are exceptions. A warning dialog will be displayed if the command fails and you should remove the instruction from your Bunch.

If you use “@@” alone on a line, Bunch will hide all visible apps. (Menu bar apps like Dash or TextExpander may not hide properly.) This is ideal for use at the very beginning of a Bunch, giving you a clean slate for a new set of apps.

Note that a windowed app in the foreground when you run the Bunch will likely fail to hide. The better option is to focus one of the apps that the Bunch launches.

You can also append an underscore to any single app name and Bunch will attempt to hide it after launching. (This can be flaky depending on how long the app takes to launch.)

By default apps will launch without activating, meaning that if the app allows it, it won’t become the foreground app when it launches, keeping focus on whatever app you’re working in. If the app is already running, it won’t activate, and if it’s hidden, it will remain hidden.

To force an app to become foreground (and unhide if hidden), append a caret (^) to the app name.

If you start an app line with an @ symbol, it will attempt to focus that app (hiding other apps). This should be run as the last line of the file, after all other lines have run. Make sure the app you want to focus has already been launched (this line will not launch the app, only focus a running app).

Everything is launched in the order listed in the Bunch file. Some apps take longer than others to launch or open a file, so execution will continue in the background after the initial launch of the app.

If an app is still launching at the time another app is focused, windows from the slower app may appear after other windows are hidden. To ensure that the app you want focused remains the only app visible, you can add a delay to the focus command. Make it just long enough for other apps to finish launching.

As an alternative to hiding and focusing apps, see the screen command.

Put an exclamation point before the app name to quit that app if it’s open. For example, to quit Mail and launch MailMate instead:

You can also have apps launch when closing the Bunch.

If the app in question is not responding, see the troubleshooting section on App Names.

When you close a Bunch (or “Toggle Bunches” or “Single Bunch Mode” are enabled), any apps launched by the Bunch will be quit. To avoid quitting an app when the Bunch is closed or toggled off, place a percent symbol before it in the Bunch (e.g. %iTerm). This will launch the app as normal, but ignore it when closing the Bunch.

In this example, CodeRunner will launch and quit with the Bunch, but iTerm will only launch if it’s not already running, and will remain running if the Bunch is closed.

If an app is called multiple times in a Bunch (perhaps to focus it or send keystrokes to it after another app has launched), only one instance needs to be marked with % to avoid closing the app. Once an app is marked as “ignore on close” at any point in the Bunch, it won’t be quit when the Bunch closes.

This works for commands as well:

This will enable Dark Mode when opening the Bunch, and leave it in Dark Mode when closing.

Finder is always ignored (won’t be quit) when closing a Bunch. If you want to actually quit Finder when closing a Bunch, use a triple negative:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
Messages
Slack
Mail
Twitter
```

Example 2 (markdown):
```markdown
Numbers
- ~/Documents/job 1.numbers
- ~/Documents/job 2.numbers
```

Example 3 (markdown):
```markdown
Numbers
- XX
- ~/Documents/job 1.numbers
```

Example 4 (yaml):
```yaml
file:///Users/Dropbox/Code/Bunch%20Work/bunch.taskpaper
```

---

## Wallpaper - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/commands/wallpaper/

**Contents:**
- Wallpaper Commands
- Examples

Set the Desktop Image for one or more displays. Provide a full path to the image, e.g. (wallpaper ~/Pictures/my desktop.jpg). If a single path is given, all available displays will be set to that image. If multiple paths separated by a pipe (|) are provided, images will be applied to the available displays in order (first image path to first display, second path to second display, etc.). If you declare more paths than you have displays, additional paths will be ignored.

The desktop image(s) that are in place when Bunch first launches will be restored when quitting any Bunch.

Tip: If you manually change the Desktop wallpaper while Bunch is running, use Save Current Wallpaper as Default from the main menu to update the fallback image(s).

Tip: Alternatively, you can simulate a wallpaper change while a Bunch is running using the (display) command with a background image. See the tip in the (display) documentation for an example.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
(wallpaper ~/Pictures/Desktop 1.jpg|~/Pictures/Desktop 2.jpg)
```

---

## The Bunch Folder - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/bunch-folder/

**Contents:**
- Bunch Folder Setup
    - See Also:

By default, Bunch reads plain text files from a folder at ~/Documents/Bunches (that’s a folder called “Bunches” in your Documents folder). You can add a new folder using the Add button next to the Bunch Folder in Preferences (possibly to a Dropbox or iCloud folder where you can sync with other machines). The dropdown menu there will let you switch between any Bunch folders you’ve added.

Tip (kinda): when you change the Bunch folder location, it doesn’t move or delete any of the Bunches at the previous location. That means that (in a fairly inelegant way) you can use different folders for different sets of Bunches. You can also quickly switch sets using the setPrefs URL handler from other apps.

All materials copyright © Brett Terpstra 2021

---

## Frontmatter - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/frontmatter/

**Contents:**
- Controlling Bunch With Frontmatter
- YAML-ish
- Available Keys
  - Bunch Scheduling
  - Bunch Behavior
  - Setting a Shortcut Key
  - Customizing Menu Display Title
  - Customizing Menu Order
  - Adding Menu Dividers
  - Hiding From the Menu

You can use frontmatter at the top of your Bunch to do things like change the menu display title or schedule launches on a repeating basis.

Frontmatter goes at the very top of a Bunch, and is fenced off by three dashes (minus symbol) at the top and bottom. Within the fence is a series of keys and values separated by colons.

Bunch treats keys the way MultiMarkdown does: it allows spaces and is case insensitive, but they’re compressed and lowercased when read in, so Open at becomes openat. Feel free to make your keys as readable or as efficient as you like. Unrecognized keys have no effect and are saved as arbitrary variables available to snippets.

Bunch frontmatter resembles YAML, but it’s a simplified system. Spaces are allowed in key names, but they are removed when the variable is read in. All keys are lowercased. If your line is First Name: Brett, the variable would be accessed using ${firstname}. However, spaces are also removed from variable placeholders when looking up the value, so ${first name} will also match.

Bunch frontmatter doesn’t support the more complex structures of YAML, such as arrays and blocks. It’s simply single-line keys and string values.

Here are the available keys:

See Scheduling Bunches for details on the open ... and close ... keys.

To learn more about sequential and parallel execution with the sequence key, see Execution Sequence.

The startup key can be set to true, false, or ask. (or yes/no/?) and has the same effect as adding a bunch name to a *.startup script. If set to ask, a confirmation dialog will pop up before opening that Bunch.

Setting single bunch mode: ignore will prevent the Bunch from affecting or being affected by the launch of other Bunches in Single Bunch Mode. This allows you to use Single Bunch Mode to quit one Bunch when opening the next, but have Bunches that can be always-on.

Setting toggles: false will only allow the Bunch to open, but will never register it as Open, meaning it can’t be closed. It won’t get a check mark in the menu, it won’t be remembered as an open Bunch if “Preserve Open Bunches” is on, and other Bunches can’t close it. Apps it has open won’t be registered by other Bunches, and it won’t prevent other Bunches from quitting them. (If you like it better semantically, you can also use only opens: true.)

Setting ignores state: true will allow Bunches to re-open or re-close when scheduled. Normally if a schedule is set for a Bunch to open or close and it already is, that schedule is ignored. With this option set you can have the Bunch re-launch or re-close, restoring the launched or quit apps and running scripts on a schedule. This setting functions independently of toggles/only opens.

Setting quit apps: always will force the Bunch to quit apps it opened regardless of whether the app is open in another Bunch. This correlates with the “Quit Apps Open in Other Bunches” global preference, but allows enabling this on a per-Bunch basis.

Bunch has full keyboard control. Assign a Hotkey key in preferences to open the Bunch menu, and then use keyboard shortcuts to open your Bunches. By default Bunches are given numbers as shortcuts, from 1 to 9 and then 0, assigned in menu display order. Subsequent items are assigned Command-Number, from ⌘1 to ⌘0. You can customize these using the shortcut: frontmatter key.

A shortcut can be anything other than a number, and can include modifiers (control, option, shift, command). A capital letter automatically implies the Shift modifier.

Modifiers are not required and single keystrokes work great for launching Bunches. Just assign shortcut: a, then hit the hotkey to open the menu and type “a” to open the Bunch.;

Modifiers can be specified using symbols:

To use any of these symbols as the actual modifier key, use the Shift-equivalent, i.e. $ would be $6 (Shift-6), and @ would be $2.

To set a menu shortcut of Command-T for your Bunch, you would include this in the frontmatter:

Shortcuts can also use words in the format option-command-t.

If you duplicate a shortcut between two Bunches, only the first one (in menu order) will get the shortcut. The conflicting Bunch will fall back to the auto-assigned numeric shortcuts.

The “title” key changes the display title of the Bunch, as seen in the menu. When calling the Bunch from any other Bunch, you’ll still use the filename.

You can totally use emoji in the frontmatter title and get a sweet looking menu 😁. The menus are sorted alphabetically by display title, so changing the title: key will change the sort order of the list. Sort order ignores emoji, so 😊Bunch A still comes before ♥️Bunch B.

You can also use the “title prefix” key to add a prefix to the display title. If no “title” key is set, this will prefix the filename in the menu title.

The “title prefix” key can be set in tag or folder frontmatter and will apply to all files affected. If multiple tag/folder prefixes apply to a single Bunch, the prefixes are concatenated. The order of concatenation can’t be controlled, but this allows you to use tags to actually “tag” menu items visually.

The “menu order” key defines the sort order of Bunches in the menu that Bunch displays.

Any Bunch with a “menu order” number between 1 and 99 will be sorted by number at the beginning of the menu. If multiple Bunches have the same number, they will be sorted alphanumerically (by display title) within that position.

Bunches without a menu order value will be sorted alphabetically after the numbered bunches.

Bunches with a menu order greater than 99 will be sorted by number and appended to the end of the list. Adding menu order: 100 to a Bunch will force it the the end of the list. Duplicate numbers are sorted alphanumerically.

Tip: If you increment your menu order numbers by 5 or 10 when first starting out, you’ll have room to stick new ones in or move them around without having to re-order everything. E.g. put your top menu item at 10, second one at 20. Then if in the future you want something else at the top of the list or between those two, you can just put it at position 5 or 15 and still have room to fit 4 more in either direction before you have to go through and renumber everything.

You can use the menu divider key to add separators to the Bunch menu. The key can be set to before or after, determining whether the inserted divider comes before or after the Bunch in the menu.

You can use the keys “ignore,” “ignore if,” and “ignore unless” to prevent a Bunch from displaying in the menu.

The “ignore” key is a boolean, either “true” or “false.” If it’s true, the Bunch will not show up in the menu (nor will it be able to be triggered by shortcut key, it’s ignored).

“ignore if” and “ignore unless” take a UUID or a condition.

A UUID is a unique identifier for each Mac. You can get the UUID for the current machine by opening Preferences and pressing “Copy UUID.” The value of startup if: can be a single UUID, or multiple UUIDs separated by commas.

You can use frontmatter to run scripts before and after opening and closing the Bunch. Because variables are defined before any script items are run within the Bunch, it may be useful to have some scripts run prior to processing variables that may read from that script’s output. For example, if you needed to pull some JSON data from an API and populate a text file that could then be read into a query dialog, you would want to run the script that populates the text file before the variable assignment that reads it. See this advanced script for an example.

To run scripts before doing anything else in a Bunch, use the run before: key. The value should be a comma-separated list of shell or AppleScripts to execute. Each script can include arguments. If you don’t provide an absolute path to the script (tildes can be used for your home directory), Bunch will assume the script is relative to your Bunch Folder.

To run scripts after processing all of the items in a Bunch, use run after:.

To run scripts when closing a Bunch but before processing any on-close items, use run before close:.

To run scripts after performing all on-close operations and terminating any other running scripts, use run after close:.

You can add tags to a Bunch using the tags: key:

These tags can be used for organizing Bunches into groups, allowing you to control multiple Bunches at once from the Bunch menu.

You can also open and close tagged groups of Bunches from within a Bunch using \tagname. See the documentation here.

You can add arbitrary key/value pairs in the frontmatter. These will be stored and passed as default values to Bunches, snippets, and scripts. For example, if your snippet had a variable ${say} in it, and the calling Bunch had a say: line in the frontmatter, that value would be passed unless specifically passed as a variable to the snippet.

The order of precedence for snippet variables is: variable defined after the snippet line, then value found for matching key in the frontmatter, then anydefault value defined in the snippet.

These variables are available in Snippets and as environment variables in shell scripts. They are not passed to Automator Workflows because those will error out if given unexpected variables.

In addition to hard coding frontmatter keys and values, you can set them on the fly using several flexible options.

You can use dialogs to set values for frontmatter keys interactively when the Bunch opens. See Interactivity->Variables for details.

When calling a Bunch from another Bunch or via the URL handler, you can pass key/value pairs to override hard coded (or missing) frontmatter keys for use in ${variables}.

If using ${variables} in a Bunch, be sure to include default values (${variable:default value}) or hard coded frontmatter values for the keys for when the Bunch is called directly from the menu and can’t have values passed to it.

You can use from file and from script to load in variables from external sources.

A frontmatter line such as from file: filename.txt would read in additional values from filename.txt. Paths are assumed to be relative to the configured Bunch folder unless they’re absolute paths.

Remember that relative paths in Bunches within subfolders are still relative to the Bunch Folder, so if you want to reference filename.txt located in a subfolder, you should use from file: Subfolder/filename.txt, even if the Bunch itself is already in Subfolder.

The contents of filename.txt should be only colon-separated key-value pairs. This allows external automation to write data to files that affect your Bunch without having to modify the Bunch itself. A file called in this manner will be watched for updates, and the Bunch will be automatically updated if the file changes.

You can also run a shell script, which should also return just key: valuepairs. Most scripting languages have a YAML library that makes it pretty easy to easily output data in a suitable format. Lines with YAML separators (---) will be ignored.

When one of these keys is detected, the file or script results will be merged with the other keys, if any, overwriting values for existing keys.

Frontmatter is only updated when a Bunch is opened, when a change is made to the Bunch file itself, or when an imported file is changed. Changing a referenced script will not trigger an update, but the new data will be parsed before any additional snippets or scripts are opened.

You can also incorporate dialogs in a frontmatter script. See advanced scripting for an example.

Just to demonstrate the capability of dynamic frontmatter, you could have a line in your frontmatter that reads additional data in from a script called frontmatter.rb:

The file frontmatter.rb would exist in your Bunch folder, so no path would be needed. It would do something like:

The above script picks a random name and adds the current date. Now when the Bunch is read in, the frontmatter it actually stores looks like:

Which means that in any snippets that are called within the Bunch, you can reference the name and date variables. Let’s load a snippet called test.snippets that contains:

Reference that snippet in the Bunch but don’t define either of the variables:

When it runs, the name variable will be replaced with a random name, and the current date will be passed. It will update every time the Bunch opens. This is obviously stupid, as you could have just written a script that said this without populating variables and importing snippets, but it illustrates how dynamic frontmatter can work.

See Advanced Scripting for more crazy ideas.

You can apply frontmatter to multiple Bunches using folder and tag frontmatter.

A file called folder.frontmatter can be included in the Bunch folder or any subfolder. This file is primarily designed for use in subfolders to control submenu display, but it can also contain keys that affect all Bunches in the folder (including the base Bunch Folder).

A folder.frontmatter file is just a text file containing frontmatter keys and values. The keys title, menu divider, and ignore only affect the submenu item, and the keys shortcut and tags are always ignored. All other keys are applied to every Bunch in the folder.

This means that you can create a subfolder for Bunches you want to launch at a specific time, and then any Bunch you put in that folder will get an open at schedule applied.

If I have a folder called “Morning” and it contains three Bunches that I want launched at 8am, I could add a folder.frontmatter file to the folder and have the open at it contains applied to all three Bunches.

Note that it’s a good idea to ignore Single Bunch Mode if you’re going to be batch opening multiple Bunches on a schedule. If Single Bunch Mode is enabled, each one that opens will immediately close the one before it.

This allows for some batch manipulation of Bunches, and means that if you have a key you want applied to multiple Bunches, you don’t have to edit them all individually. It does mean that those Bunches have to appear in a submenu, but then modifying which Bunches have the key is as simple as moving a Bunch in or out of that folder, and changing the key for every Bunch is just a matter of editing one file.

This can also be used to apply arbitrary keys to groups of Bunches. An entire folder of Bunches can have a variable assigned, and then modifying that variable for all Bunches can be done just by editing folder.frontmatter.

Assign an arbitrary key, in this case a default browser:

Then any Bunch in the folder (and any Snippets they contain) can reference that variable.

Now if I want to change the browser for any of the Bunches in that folder using that variable, I just edit default browser in folder.frontmatter.

folder.frontmatter files can exist in the root of your Bunch folder as well. Submenu keys like ignore and title are ignored, but arbitrary keys assigned in that file will apply to all Bunches in the root folder.

Another way to apply frontmatter to multiple Bunches is to use tag frontmatter. If a file beginning with @tagname.frontmatter exists, its frontmatter will be applied to all Bunches tagged with tagname.

Some keys such as “title prefix” and “ignore if/unless” are concatenated when they appear in multiple frontmatter. This allows you to assign an “icon” to each tag (with “title prefix”), and have menu items labelled with those icons, or to use tags to ignore (“ignore if/unless”) sets of Bunches on different machines.

UUID can be retrieved using “Copy UUID” in Preferences. ↩ ↩2

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 📞Comms
open at: 8am
startup: true
---
```

Example 2 (yaml):
```yaml
---
shortcut: @t
---
```

Example 3 (yaml):
```yaml
---
title: Just A Bunch
menu order: 10
menu divider: after
---
```

Example 4 (yaml):
```yaml
---
title: Script Example
run before: prescript.sh arg1, otherscript.sh arg2
run after close: postscript.sh
---
```

---

## Scheduling Bunches - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/scheduling-bunches/

**Contents:**
- Scheduling Bunches
- Available Keys
- Schedules, Screensavers, and Sleep
- Open at intervals
- Close After an Interval
- Daily Schedules
  - Opening Daily
  - Closing Daily
- Weekly Schedules
  - Opening Weekly

You can use Bunch like an alarm clock or timer by making use of some frontmatter keys in your Bunch files.

Bunch will always read in these keys and set the alarms and timers when it launches, so it doesn’t matter if you quit the app in between scheduled launches.

Bunches with active schedules will have a timer icon after their title in the menu.

Tip: By default, Bunches that are already open will ignore a scheduled open, and Bunches that aren’t open will ignore a scheduled close. You can override this and have them open or close anyway by using the ignores state: true frontmatter setting.

Bunches scheduled to open or close automatically will work while the screensaver is running or the display is asleep, but will not wake the display or stop the screensaver.

If your Mac is asleep at the scheduled time, it will run when the machine wakes. Bunch will not wake your machine automatically.

The open every key runs the Bunch at timed intervals. The value should be shorthand for hours and minutes to create an interval: 1h30m would run it every hour and a half. You can also just use 1h or 30m.

You can also use “d” to specify days. If you want to launch every other day, use “2d”. This, however, does not allow you to specify a time. So, for most intents and purposes you’ll want to use open at.

It will even let you do seconds (s), if you needed to.

This can be useful for always-open Bunches, though it can be disruptive if launching apps and opening files takes window focus from what you’re working on. This is most useful for small Bunches that use things like Spotlight searches to open files, allowing them to be continually updated.

The close after key defines an interval to wait after opening the Bunch before automatically closing it. It uses the same formatting as open at, e.g. a time string like 1h30m or 1d. This will just start a background timer that will automatically close the Bunch after it’s been open for that period of time.

Closing the bunch manually will cancel the timer. If Bunch is quit, the timer will be lost and reset when the Bunch is opened again (even if it’s restored at launch).

Tip: Keep in mind that you can use % before app names to ignore them when closing. That means your Bunch can do things like turn on Do Not Disturb or toggle Dark Mode and then restore settings after a set period of time. Combine with an open option to toggle things on and off at set intervals. Apps that are already open will be unaffected by Bunch opens.

The “at” commands trigger daily.

The open at key creates a daily “alarm” that will go off at the same time every day, as long as Bunch is running.

Time can be specified with a meridian (am/pm) or as 24 hour time. Whatever time it initially goes off, it will then start repeating at 24 hour intervals. If Bunch isn’t running when the time comes, it will not launch automatically again until the next day.

Multiple times can be listed, separated by commas. To have a Bunch launch at 8am, Noon, and 5pm, use:

You can also use close at to close a Bunch at a set time each day. open at and close at can be used simultaneously. Close at uses the same syntax as open at.

The “on” commands trigger weekly, multiple days are allowed.

You can specify a day of the week and a time to create weekly Bunches, great for end-of-the week reviews, or celebrating the weekend by shutting down Slack.

Multiple days can be listed with a time, separated by commas. Only one time can be used per group of days, but you can repeat the list. To open at different times on Tuesday and Thursday than on Monday, Wednesday, and Friday, use:

Days can be just initial letters or spelled out or abbreviated day names. Single letters can be compressed, longer day names should be separated by spaces. In single-letter form, Thursday must have an “h” and Sunday must have a “u”, e.g. ‘Th’ and ‘Su’. “T” alone triggers Tuesday, and “S” alone triggers Saturday.

To open at two different times on the same day, repeat the day block with a second time:

You can also use close on to close a Bunch weekly at a set day and time. open on and close on can be used simultaneously.

Close on uses the same syntax as open on.

Tip: You can always see what the next scheduled event for a Bunch is by hovering over it in the menu. A tooltip will show up displaying the time of the next scheduled open or close event.

All of the scheduling keys (other than open every) allow natural language dates and times. You can just write 1pm or tue noon and it should figure out what you’re trying to do. You can view the Console to see the confirmation that scheduling is happening. I don’t currently offer a front-end way to see what all is scheduled, but I’d like to eventually.

When launching and closing Bunches on a schedule, Bunch will attempt to show a notification 15 seconds before the action happens. Clicking the notification will cause it to the action to happen immediately, and there’s a cancel button to skip that scheduled launch until the interval comes around again. This notification system is only tested on Big Sur. I highly recommend setting Bunch’s notification style to “Alert” in System Preferences, they work much better for what Bunch uses them for.

If you sync your Bunches to multiple Macs, you may want to be selective about which ones get scheduled. There are two keys that can help with this.

First, schedule if: accepts either a UUID or a logic condition. Because these conditions run before the Bunch actually executes, some logic comparisons may not work as usual. The safest ones are UUID and file [PATH] exists to use a file as a trigger file.

A UUID is a unique identifier for each Mac. You can get the UUID for the current machine by opening Preferences and pressing “Copy UUID.” The value of startup if: can be a single UUID, or multiple UUIDs separated by commas.

Second, schedule unless: takes the same parameters as schedule if: but has the reverse effect. If a condition returns true, scheduling is ignored. If it returns false, scheduling is enabled.

A Bunch this is removed from the menu by an “ignore if” or “ignore unless” frontmatter key will also not be scheduled.

Schedule conditions are only parsed when your Bunches are scanned. This happens when a file in the Bunch folder changes, but not when a trigger file or other condition changes. If a Bunch is already loaded and scheduled, the change in presence of a trigger file or other condition will not immediately turn off scheduling, but the schedule if/unless condition will be checked at the scheduled time and open/close will be cancelled based on the result.

The schedule if/unless keys can be inherited from tag and folder frontmatter. If the Bunch contains its own schedule if or schedule unless, it will override any schedule conditions set in inherited frontmatter. If a Bunch inherits a schedule condition but doesn’t have a schedule to set, the key will be ignored.

If (for whatever reason) both schedule if and schedule unless are defined on a Bunch, only schedule if is used.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (json):
```json
---
open every: 1h30m
---
```

Example 2 (json):
```json
---
open at: 5pm
---
```

Example 3 (json):
```json
---
open at: 8am, 12pm, 5pm
---
```

Example 4 (yaml):
```yaml
---
open on: friday 5pm
---
!Slack
```

---

## Run On Close - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/run-on-close/

**Contents:**
- Running Scripts Only When Closing a Bunch
- Launching Multiple Items on Close
- Launch an App When Closing
- Quit an App When Closing
    - See Also:

If you precede any script lines (starting with *, &, or $) with an exclamation point, that script will be ignored when opening a Bunch and instead run only when the Bunch is closed. Here’s an example that uses the same script with different arguments for open and quit:

The same works for commands. To run a command when a Bunch closes, use:

You can also set an entire snippet to open when the Bunch closes using the same syntax. Just use !<snippet.name to have the contents of that snippet or snippet fragment load when the Bunch is closed.

Note that in the case of apps, a single exclamation point (!AppName) quits the app rather than performing an action on close. Bunch doesn’t automatically relaunch apps that are quit this way; you have to explicitly instruct it with !! (a double negative).

The following will force quit Dropbox when opening the Bunch, and then restart it when closing.

To quit Twitter when opening the Bunch, then re-launch it on close:

Normally an app launched by a Bunch would quit when the Bunch closes (unless ignored with %). You can also specify that an app should quit when closing a Bunch — without having to launch it first — by using !!!AppName. If the app is running, it will be quit when the Bunch closes, but the item will have no effect when opening the Bunch.

This can be useful as a workaround when an app like FileMaker Pro Advanced or Visual Studio Code will launch with one name, but needs another to quit. In the case of FileMaker, you would use:

(The specific cases of FileMaker and VS Code are handled automatically by Bunch, but there will almost certainly be other examples of this where you’ll need to manually specify.)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
# Run this when opening the Bunch
$ ~/scripts/myscript.sh open
- STATUS=opening

# Run this when closing the bunch
!$ ~/scripts/myscript.sh close
- STATUS=closing
```

Example 2 (unknown):
```unknown
!(hide dock)
```

Example 3 (markdown):
```markdown
!<<#On Close
___
#[On Close]
Tweetbot
Messages
* tell application "Moom" to arrange windows according to snapshot "Comms"
```

Example 4 (kotlin):
```kotlin
$ killall Dropbox
!!Dropbox
```

---

## Syntax Reference - Bunch.app

**URL:** https://bunchapp.co/docs/bunch-files/quick-reference

**Contents:**
- Quick Reference
- Formatting
  - Indentation
  - Line Breaks
  - Comments
- Bunch Syntax
- Frontmatter
- URL Handler
    - See Also:

Bunch Lines start at the left column unless they’re in an indented logic block. Indentation within a logic block must be consistent with other lines at the same level of the block.

Bunch Lines should be a single line, but can be split by ending the line with a backslash and continuing immediately on the next line. A backslash followed by a blank line will not be joined.

Comments can be block (/*...*/), lines (# Comment), or inline at the end of a line (Preview // inline comment). Comment markers must be followed by a space.

You can control some aspects of your Bunch using Frontmatter, including the title and icons it uses in the menu. See the Frontmatter docs for details.

See documentation for details.

UUID can be retrieved using “Copy UUID” in Preferences. ↩ ↩2

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (julia):
```julia
Messages

if social
	Slack
	Discord
end
```

Example 2 (unknown):
```unknown
(display bunch-internal/first-bunch.html \
 500x600 level:floating)
```

---
