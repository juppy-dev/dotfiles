# Bunchapp - Using-Bunch

**Pages:** 13

---

## Terminology - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/terminology/

**Contents:**
- Bunch Terminology
- Definitions
- Keyboard Shortcuts

For the purposes of this documentation, here are some definitions.

Keyboard shortcuts are displayed as symbols: ⇧⌘H. Hovering over a keyboard shortcut will display a tooltip showing the natural language version of the key combination, e.g. “Shift-Command-H.”

All materials copyright © Brett Terpstra 2021

---

## Getting Started - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/getting-started/

**Contents:**
- Getting Started With Bunch
- Create Your First Bunch
  - New Bunch With Open Apps
- Using Your Bunches
    - See Also:

Once you’ve gotten acquainted with Bunch Preferences, it’s time to start using Bunch.

The first time you run Bunch, a Bunch Folder will be created in your Documents folder. You can change this location, but you probably won’t need to. See The Bunch Folder for more information.

By default this folder is ~/Documents/Bunches. To get to it quickly, you can open Preferences and click “Reveal” next to the Bunch Folder setting.

The Bunch folder contains Bunch files, also called “Bunches.” A Bunch file is just a plain text file with the extension .bunch. You can edit them in TextEdit (in plain text mode, not Rich Text), in any plain text editor such as VS Code or Sublime Text, or in any Markdown editor.

If using TextEdit, make sure it’s in Plain Text mode for the current file by opening the Format menu and selecting Make Plain Text if that option is showing. If it says Make Rich Text, you’re already in plain text mode.

Each Bunch is a separate file, and the name of the Bunch will be taken from the filename, without the .bunch extension. (You can specify a separate “display name” for the menu item in Frontmatter, but we’ll get to that later.)

You can edit Example.bunch in your Bunch Folder to see what happens, or just use it as a reference for creating a new file. Bunch files just have to be plain text with the extension .bunch. Once you’ve added your own configuration(s), delete Example.bunch (or rename it with an extension other than .bunch).

Bunch files absolutely require the extension .bunch. If you have macOS set to hide extensions, it may be assigning another extension in addition to .bunch (e.g. .bunch.txt). If your Bunches aren’t showing up in the menu, open Finder Preferences and check “Show all filename extensions” to double check.

See the Bunch Files section to learn all about the syntax and features. All of the basic syntax can be found in the Syntax Guide for quick reference.

The fastest way to create a simple Bunch is to open the apps you want your Bunch to launch and choose “New Bunch With Open Apps” from the Bunch menu. Your new Bunch will show up in the menu immediately, ready to try out. Opening and closing this new Bunch will launch and quit all of the apps listed in it. You can edit this file to remove apps you don’t want affected, or prefix lines with % to indicate they should be ignored when closing; the Bunch will launch them when it opens, but not quit them when it closes.

Bunch can do much more than just launch apps, though. Take some time to explore all of the possibilities. You don’t have to learn it all, you can just look up how to do something as you need it. The Syntax Reference offers quick reminders for how to accomplish most tasks in a Bunch.

Once you have one or more .bunch files in your Bunch folder they should show up automatically when you open the Bunch menu by clicking the Bunch icon in the menu bar. Select a Bunch in the menu to perform the actions defined in that Bunch file.

If “Toggle Bunches” is enabled in Preferences, each Bunch gets a circle indicator on the left. When a Bunch is opened its indicator is filled in, indicating it’s open. Selecting an open Bunch will “toggle” the Bunch, quitting any apps it launched (if they’re running and not open in other Bunches), restoring commands, and running any On-Close items.

See the Bunch Menu page for more details and special features.

If “Single Bunch Mode” is enabled, clicking a closed Bunch will close the previous Bunch before opening it.

If neither “Toggle Bunches” nor “Single Bunch Mode” is enabled, clicking a Bunch will always launch the apps and commands in the Bunch, or bring them to front if they’re already running.

All materials copyright © Brett Terpstra 2021

---

## Bunch Logging - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/bunch-log/

**Contents:**
- The Bunch Log
- Log Levels
- Log Entry Structure
    - See Also:

Because Bunch is reading plain text files and running everything in the background, it’s easy for things to not work the way you expected and leave you with little idea what went wrong. That’s where the Bunch Log comes in.

Bunch records every action it takes — and any errors it runs into — in a log file that you can access using Console.app. There’s a handy shortcut under Help->Open Log that will take you right to it. Notification Center error alerts can also open the log, just click the Show Log button on the notification.

You can set the verbosity of the log using Help->Set Log Level. Choose to see only errors, errors and warnings, or all messages. Debug level settings are typically not needed and are fairly verbose, but feel free to peek at Bunch’s underbelly.

The log lines start with an indicator of log level. If it’s just an info message, it has a grey circle. If it’s an alert or warning, it has a yellow circle. Red circles are for errors.

Next is the date and time of the message.

In square brackets is the name of the Bunch that logged the message. If it’s a Bunch called by another Bunch, its lineage will be shown, e.g. [Podcast->Comms->Music].

Lastly, the log message itself.

You should be able to compare the results of opening a Bunch to your Bunch file and see what worked, what didn’t, and what might have had unexpected results.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
⚪2021-01-23 14:​32:​16: Launched ==========================================
⚪2021-01-23 14:​32:​16: [Default] Setting display title to "👍Important Stuff"
⚪2021-01-23 14:​32:​16: [Music] Setting display title to "🎵Easy Listening"
⚪2021-01-23 14:​32:​16: [Misc] Setting display title to "😴Relax"
⚪2021-01-23 14:​32:​16: [Marked Screencast] Setting display title to "🎥Marked Screencast"
⚪2021-01-23 14:​32:​16: [Bunch] Setting display title to "🍇Bunch"
⚪2021-01-23 14:​32:​16: [Marked] Setting display title to "📖Marked"
⚪2021-01-23 14:​32:​16: [Podcast] Setting display title to "🎤Podcast"
⚪2021-01-23 14:​32:​16: [Comms] Setting display title to "📞Comms"
🟡2021-01-23 14:​32:​16: [Comms] Scheduled to open daily starting 2021-01-23 22:21:45 +0000
⚪2021-01-23 14:​32:​16: [nvUltra] Setting display title to "🚀nvUltra"
⚪2021-01-23 14:​32:​16: [Code] Setting display title to "🖥Coding"
⚪2021-01-23 14:​32:​16: [Comms] Open >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
⚪2021-01-23 14:​32:​16: [Comms] Adding 12s delay to (* tell application "Moom" to arrange windows according to snapshot "Comms")
⚪2021-01-23 14:​32:​16: [Comms] Opening app Tweetbot
⚪2021-01-23 14:​32:​16: [Comms] Opening app MailMate
⚪2021-01-23 14:​32:​16: [Comms] Opening app Slack
⚪2021-01-23 14:​32:​16: [Comms] Opening app Messages
⚪2021-01-23 14:​32:​16: [Comms] Opening app Discord
⚪2021-01-23 14:​32:​28: [Comms] Running AppleScript (tell application "Moom" to arrange windows according to snapshot "Comms")
```

---

## The Bunch Menu - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/menu

**Contents:**
- The Bunch Menu
- Bunch List
  - Mouse-Based Menu Functions
- Bunch
- Main Menu
- Preferences
- Help
- Windows
    - See Also:

Just click on the Bunch status item to reveal the menu.

At the top you’ll see your available Bunches. Clicking any of them will launch that Bunch. If you have “Toggle Bunches” enabled, a check mark will appear next to open Bunches in the menu. Clicking a checked Bunch will close it, reversing app launches and commands, and running any “run on close” lines.

Bunches that have an active schedule (e.g. scheduled to launch or waiting to close) will have a timer emoji after their title.

You can control the order Bunches appear in the menu using frontmatter. You can also organize your Bunches into submenus, if needed.

Holding down modifier keys when clicking Bunches in the menu can perform different functions. These only work when using the mouse, they can’t be used in combination with keyboard shortcuts.

To use the Edit command (⌘), be sure to specify your preferred text editor in Preferences.

The “Force” commands cause the Bunch to execute its open or close items even if it’s already open or closed.

Clearing a check mark causes the Bunch to register as closed without executing its close items. This will also remove it from the list of Bunches to restore if “Remember Open Bunches” is enabled.

Holding any modifier combination while the menu is open will display its function at the top of the menu as a reminder.

The Bunch menu is a submenu that contains what would usually be in the application menu of a standard application.

You can hide all windows that Bunch creates (file displays, task monitors, etc.), using the “Hide All Window” and “Unhide All Windows”. These have the shortcuts ⌘H and ⇧⌘H respectively. Keyboard shortcuts are only active when the Bunch menu is showing.

If a Bunch window is active, the menu item “Copy Dimensions of Active Window” will place the current dimensions and position of the window into your clipboard in a format that can be directly pasted into a display command to affect the window parameters next time it opens.

All materials copyright © Brett Terpstra 2021

---

## Keyboard Control - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/keyboard-control/

**Contents:**
- Keyboard Control in Bunch
    - See Also:

In Preferences, assign a hotkey to use to open Bunch. Once this is assigned, you can use it no matter what application you’re in. Pick a combination that won’t conflict with other applications’ default shortcuts. I recommend including Control in the combination, which avoids many conflicts (90% of shortcuts only use Command, Shift, and Option). Or, if you know what a Hyper key is, Hyper combos make good launchers.

In order to have keyboard control over popup dialogs in Bunch, you need to enable access to all controls in System Preferences. Open System Preferences->Keyboard and select the Shortcuts tab. At the bottom, enable the checkbox for “All Controls” (macOS < 11) or “Use keyboard navigation to move focus between controls” (Big Sur).

Once these are set up, hit your hotkey and you’ll see that the Bunches listed in the menu have keyboard shortcuts assigned. By default these are numbers. Just type the number of a Bunch to open (or toggle) it.

You can customize the shortcut for each Bunch with the shortcut frontmatter.

After using the keyboard shortcut to open the Bunch menu, you can also navigate with the arrow keys. Or, if you’re a keyboard pro, you can use ⌃P/⌃N to move up and down (this works in any macOS menu).

Additionally, the following keyboard shortcuts are available when the menu is open:

All materials copyright © Brett Terpstra 2021

---

## Bunch Logging - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/bunch-log

**Contents:**
- The Bunch Log
- Log Levels
- Log Entry Structure
    - See Also:

Because Bunch is reading plain text files and running everything in the background, it’s easy for things to not work the way you expected and leave you with little idea what went wrong. That’s where the Bunch Log comes in.

Bunch records every action it takes — and any errors it runs into — in a log file that you can access using Console.app. There’s a handy shortcut under Help->Open Log that will take you right to it. Notification Center error alerts can also open the log, just click the Show Log button on the notification.

You can set the verbosity of the log using Help->Set Log Level. Choose to see only errors, errors and warnings, or all messages. Debug level settings are typically not needed and are fairly verbose, but feel free to peek at Bunch’s underbelly.

The log lines start with an indicator of log level. If it’s just an info message, it has a grey circle. If it’s an alert or warning, it has a yellow circle. Red circles are for errors.

Next is the date and time of the message.

In square brackets is the name of the Bunch that logged the message. If it’s a Bunch called by another Bunch, its lineage will be shown, e.g. [Podcast->Comms->Music].

Lastly, the log message itself.

You should be able to compare the results of opening a Bunch to your Bunch file and see what worked, what didn’t, and what might have had unexpected results.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
⚪2021-01-23 14:​32:​16: Launched ==========================================
⚪2021-01-23 14:​32:​16: [Default] Setting display title to "👍Important Stuff"
⚪2021-01-23 14:​32:​16: [Music] Setting display title to "🎵Easy Listening"
⚪2021-01-23 14:​32:​16: [Misc] Setting display title to "😴Relax"
⚪2021-01-23 14:​32:​16: [Marked Screencast] Setting display title to "🎥Marked Screencast"
⚪2021-01-23 14:​32:​16: [Bunch] Setting display title to "🍇Bunch"
⚪2021-01-23 14:​32:​16: [Marked] Setting display title to "📖Marked"
⚪2021-01-23 14:​32:​16: [Podcast] Setting display title to "🎤Podcast"
⚪2021-01-23 14:​32:​16: [Comms] Setting display title to "📞Comms"
🟡2021-01-23 14:​32:​16: [Comms] Scheduled to open daily starting 2021-01-23 22:21:45 +0000
⚪2021-01-23 14:​32:​16: [nvUltra] Setting display title to "🚀nvUltra"
⚪2021-01-23 14:​32:​16: [Code] Setting display title to "🖥Coding"
⚪2021-01-23 14:​32:​16: [Comms] Open >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
⚪2021-01-23 14:​32:​16: [Comms] Adding 12s delay to (* tell application "Moom" to arrange windows according to snapshot "Comms")
⚪2021-01-23 14:​32:​16: [Comms] Opening app Tweetbot
⚪2021-01-23 14:​32:​16: [Comms] Opening app MailMate
⚪2021-01-23 14:​32:​16: [Comms] Opening app Slack
⚪2021-01-23 14:​32:​16: [Comms] Opening app Messages
⚪2021-01-23 14:​32:​16: [Comms] Opening app Discord
⚪2021-01-23 14:​32:​28: [Comms] Running AppleScript (tell application "Moom" to arrange windows according to snapshot "Comms")
```

---

## The Bunch Menu - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/menu/

**Contents:**
- The Bunch Menu
- Bunch List
  - Mouse-Based Menu Functions
- Bunch
- Main Menu
- Preferences
- Help
- Windows
    - See Also:

Just click on the Bunch status item to reveal the menu.

At the top you’ll see your available Bunches. Clicking any of them will launch that Bunch. If you have “Toggle Bunches” enabled, a check mark will appear next to open Bunches in the menu. Clicking a checked Bunch will close it, reversing app launches and commands, and running any “run on close” lines.

Bunches that have an active schedule (e.g. scheduled to launch or waiting to close) will have a timer emoji after their title.

You can control the order Bunches appear in the menu using frontmatter. You can also organize your Bunches into submenus, if needed.

Holding down modifier keys when clicking Bunches in the menu can perform different functions. These only work when using the mouse, they can’t be used in combination with keyboard shortcuts.

To use the Edit command (⌘), be sure to specify your preferred text editor in Preferences.

The “Force” commands cause the Bunch to execute its open or close items even if it’s already open or closed.

Clearing a check mark causes the Bunch to register as closed without executing its close items. This will also remove it from the list of Bunches to restore if “Remember Open Bunches” is enabled.

Holding any modifier combination while the menu is open will display its function at the top of the menu as a reminder.

The Bunch menu is a submenu that contains what would usually be in the application menu of a standard application.

You can hide all windows that Bunch creates (file displays, task monitors, etc.), using the “Hide All Window” and “Unhide All Windows”. These have the shortcuts ⌘H and ⇧⌘H respectively. Keyboard shortcuts are only active when the Bunch menu is showing.

If a Bunch window is active, the menu item “Copy Dimensions of Active Window” will place the current dimensions and position of the window into your clipboard in a format that can be directly pasted into a display command to affect the window parameters next time it opens.

All materials copyright © Brett Terpstra 2021

---

## Keyboard Control - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/keyboard-control

**Contents:**
- Keyboard Control in Bunch
    - See Also:

In Preferences, assign a hotkey to use to open Bunch. Once this is assigned, you can use it no matter what application you’re in. Pick a combination that won’t conflict with other applications’ default shortcuts. I recommend including Control in the combination, which avoids many conflicts (90% of shortcuts only use Command, Shift, and Option). Or, if you know what a Hyper key is, Hyper combos make good launchers.

In order to have keyboard control over popup dialogs in Bunch, you need to enable access to all controls in System Preferences. Open System Preferences->Keyboard and select the Shortcuts tab. At the bottom, enable the checkbox for “All Controls” (macOS < 11) or “Use keyboard navigation to move focus between controls” (Big Sur).

Once these are set up, hit your hotkey and you’ll see that the Bunches listed in the menu have keyboard shortcuts assigned. By default these are numbers. Just type the number of a Bunch to open (or toggle) it.

You can customize the shortcut for each Bunch with the shortcut frontmatter.

After using the keyboard shortcut to open the Bunch menu, you can also navigate with the arrow keys. Or, if you’re a keyboard pro, you can use ⌃P/⌃N to move up and down (this works in any macOS menu).

Additionally, the following keyboard shortcuts are available when the menu is open:

All materials copyright © Brett Terpstra 2021

---

## Organizing Bunches - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/organizing-bunches/

**Contents:**
- Organizing the Bunch Menu
- Set Display Titles
- Define Menu Order
- Sort With Submenus
  - Submenu Frontmatter
- Organize With Tags
  - Tag Frontmatter
    - See Also:

If you have a significant number of Bunches, you may want more control over how Bunches appear in the menu.

Start by setting the title displayed in the menu using title frontmatter. You can use emoji in the display title without affecting the alphanumeric sort order.

Just add a block of text at the top of your Bunch:

Whatever you specify in the title frontmatter is what will be shown in the menu instead of the filename.

You can manually control the order of menu items using menu order frontmatter.

Using menu order frontmatter overrides the alphanumeric sorting of Bunches in the menu. Any Bunches that don’t have menu order assigned will still be sorted alphabetically.

Lastly, you can use folders in Finder to create submenus of Bunches. Submenus appear at the end of the list, after any Bunches in the base Bunch Folder.

To add a submenu, create a folder inside of your Bunch Folder (the base folder defined in Preferences) in Finder. Move Bunches you want in the submenu into the new folder. Bunch will automatically create a submenu titled with the name of the subfolder (see below for customizing the title), listing the Bunches it contains.

If you have a file arrangement like this:

The resulting menu would look like:

A few things to note:

If you include a file called folder.frontmatter inside the subfolder, frontmatter keys in this file will be applied to all Bunches it contains, with the exceptions listed below.

A folder.frontmatter file can also exist in the base Bunch Folder, but doesn’t affect subfolders and all submenu-specific keys are ignored. Other keys it contains will be applied to all Bunches in the root folder.

The following frontmatter keys in folder.frontmatter only apply to subfolders and will not affect the Bunches they contain:

All other keys are passed on to the Bunches the folder contains, with the exception of shortcut (which is ignored entirely).

Folder frontmatter can also be used to apply frontmatter keys to every file it contains. See Applying Frontmatter to Multiple Bunches.

If one or more Bunches have frontmatter that includes a tags: key, a Tags submenu will be created. Each tag will have a menu entry, and it will contain all Bunches with that tag. Bunches in a tag can be launched individually, or you can use the Open, Close, and Toggle commands within the tag’s submenu to act on all Bunches with that tag.

The tags: key should contain a list of one or more tags, separated by commas. Tags are case insensitive. You do not need to surround tag lists in quotes or brackets (though either will be ignored if you do). Tags can have spaces, but they’re easiest to manage if they’re one word (hyphenated if needed).

You can create frontmatter that applies to all Bunches with a certain tag by creating a file in your Bunch folder called @[tagname].frontmatter, where [tagname] is the name of the tag to which the frontmatter should apply. Any Bunch with a tag matching [tagname] will receive that frontmatter. Frontmatter keys applied in this manner are low priority, and if values for a given key are supplied using any other means — including in the individual Bunch’s frontmatter — they will override the tag frontmatter.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 🎉My First Bunch!
---
```

Example 2 (yaml):
```yaml
---
title: 👍My Second Bunch
menu order: 2
---
```

Example 3 (unknown):
```unknown
Bunch Folder/
    Bunch 1.bunch
    Bunch 2.bunch
    Subfolder/
        Bunch 3.bunch
        Bunch 4.bunch
        folder.frontmatter (optional, see Customizing the Submenu Title)
```

Example 4 (yaml):
```yaml
---
ignore: true
---
```

---

## Terminology - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/terminology

**Contents:**
- Bunch Terminology
- Definitions
- Keyboard Shortcuts

For the purposes of this documentation, here are some definitions.

Keyboard shortcuts are displayed as symbols: ⇧⌘H. Hovering over a keyboard shortcut will display a tooltip showing the natural language version of the key combination, e.g. “Shift-Command-H.”

All materials copyright © Brett Terpstra 2021

---

## Preferences - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/preferences/

**Contents:**
- Bunch Preferences
- Application Settings
- Bunch Behavior
- Bunch Folder
- Bunch Editor
- Copy UUID
    - See Also:

Click the Bunch icon in the menu bar and select Preferences….

The field next to “Bunch Folder” will show your current Bunch Folder location. If you’ve changed the Bunch Folder location, clicking the popup button will allow you to quickly change between recent locations.

Click the button to select an external editor for your Bunch files. You can hold down Command while clicking any Bunch in the menu to open its file in your editor.

This copies a unique identifier for the current Mac to your clipboard. This can be used in startup and schedule if frontmatter to only run as startup or add schedules on the current Mac. This is useful if you run Bunch on multiple machines and sync your Bunch folder.

All materials copyright © Brett Terpstra 2021

---

## Using Bunch - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch/

**Contents:**
- Let’s Get Started
- Section Contents

Before you start using Bunch, take a moment to set your Preferences, get an overview of Bunch’s features, and learn the basics of building and using Bunches.

All materials copyright © Brett Terpstra 2021

---

## Using Bunch - Bunch.app

**URL:** https://bunchapp.co/docs/using-bunch//

**Contents:**
- Let’s Get Started
- Section Contents

Before you start using Bunch, take a moment to set your Preferences, get an overview of Bunch’s features, and learn the basics of building and using Bunches.

All materials copyright © Brett Terpstra 2021

---
