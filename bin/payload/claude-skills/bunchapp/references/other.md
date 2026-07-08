# Bunchapp - Other

**Pages:** 10

---

## Introducing Bunch - Bunch.app

**URL:** https://bunchapp.co/docs//

**Contents:**
- Welcome to Bunch
- Q: What’s a Context?
- A "context" is the environment you need for any given task/project
- Set Up Your Workspace
  - Launch/Quit Apps
  - Open Files
  - Open Websites
  - Send Keystrokes
- Tune Your Environment
  - Hide/Show The Dock

Bunch is a macOS utility that uses plain text scripts called “Bunches” to automate context switching. It sits in your menu bar, out of the way. When you click the menu item, it provides a list of your Bunches, each one representing an environment for your work or play. Bunches can open apps, specific files, web pages, and more. For the Power Users, It also allows advanced scripting, system commands, and integration via a URL handler.

I wrote Bunch because I tend to launch a specific group of apps depending on the context I’m working in. These are apps I wouldn’t launch on login, and don’t need running all the time. I just wanted to make starting a new context into one click. It started with little Script Editor and Automator applets, but I found I wanted something easily configured with text files, quick to set up and easy to modify. It grew from there.

Bunch has expanded a lot since that humble beginning. It can serve as a full context switcher, and handle just about everything you’d want to automate when starting a new context (see the Syntax Summary for an overview of all the cool stuff you can do).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 📞Comms
---
Messages
Slack
(dnd off)
```

---

## Changelog - Bunch.app

**URL:** https://bunchapp.co/docs/changelog

**Contents:**
- Bunch Release Notes
      - The latest Bunch blog posts
      - Bunch in the wild

See documentation history

Beta Feature: this feature is currently in development and is only available to those using the preview build. If you want to help test new features, feel free to download and run the beta release.

(hide desktop) command not functioning

Fancy new icon design by Felippe van Eekhout

Allow !!!Triple Negative to quit an app when closing a Bunch without launching on open

Frontmatter keys for running scripts before/after opening a Bunch, and before/after closing

Process variables before importing snippets so that placeholders can be used for snippet fragments (<snippet#${fragmentvar})

All materials copyright © Brett Terpstra 2021

---

## Troubleshooting - Bunch.app

**URL:** https://bunchapp.co/docs/troubleshooting

**Contents:**
- Troubleshooting Bunch
- Debugging Bunches
- Debugging Scripts
- Specific App Not Launching or Quitting
  - Finding a “Registered” Name
  - Getting an App’s “Real” Name
    - Method 1: From Finder
    - Method 2: From Terminal
  - Using the Bundle Identifier
  - Known Exceptions

If you’re having issues with a Bunch not doing what you expected, consult the Bunch Log to see if you can trace the issue.

If needed, split out sections of a longer Bunch into temporary smaller Bunches and test them one at a time to narrow down any issues. Or just create one new, blank Bunch and copy one line at a time into it from the misbehaving Bunch, launching it for each now line until the behavior you’re trying to avoid happens, thus narrowing it down to that line.

If you’re debugging the opening of a Bunch and have your Bunches set to toggle, you can avoid having to repeatedly close the Bunch by holding down the Option key while clicking the menu item, or by using Clear All Checkmarks, which will tell Bunch that the Bunches are closed without actually executing any on-close behaviors or quitting any apps.

Also see the (log) command, which can be useful for pinpointing issues with variable assignment and execution sequence.

If you know which line is problematic and it doesn’t make sense, post about it in the forum. If it seems like a bug in Bunch, please let me know here.

See Debugging Scripts in the Advanced Scripting section for tips on tracking down issues with shell scripts.

If you list an app to launch or quit in your Bunch and nothing happens, the app in question may have a different name in the system than it shows in Finder. First double check that the filename you’re listing in your Bunch exactly matches the name of the application in Finder (minus the .app). If it does, and still doesn’t work, there are a couple of possibilities.

The first thing to try when tracking down the name an app responds to is to open Script Editor and go to File->Open Dictionary (⇧⌘O). If the app has an AppleScript dictionary, it will show up in that list with the name you probably need to use to operate on it. In cases like the app Things, this will reveal that the app is actually called “Things3.”

If that fails, you can locate the app in Finder (easy to do by ⌘-clicking the app icon in the Dock while it’s running). Right click (CTRL-click) on the app and choose [Show Package Contents]. Inside the “Contents” folder you’ll find Info.plist.

If Info.plist is in text format (they usually are), you can open it in your text editor and locate the key CFBundleName. If it’s different than the display name, try that in your Bunch.

If Info.plist is in binary format (which will be obvious when you try to open it in your text editor), you’ll need to use Terminal to get the info you’re looking for.

Open Terminal and enter the following command, substituting [App Name] with the actual application name. If the app is not located in /Applications, you’ll need to correct that part of the path as well.

You can also use an app’s bundle identifier instead of the app name. Use the steps above to read the app’s info, but look for the CFBundleIdentifier key instead.

This is the bundle identifier, and is a string that looks kind of like a URL. For example, Bunch’s bundle identifier is com.brettterpstra.Bunch. If you use the bundle id instead of the app name, it can help Bunch clarify instances where the app responds to a different name than the app’s filename.

If all of these fail, please do leave a note on the discussion forums.

In cases where an app responds to one name when launching but needs a different name to quit the running application (such as those detailed below), you can use a triple negative to quit an app using a different name when closing.

Single Site Browser’s created using Coherence X suffer all kinds of problems in Bunch. They can’t be launched if Chrome is running, you can’t launch more than one, and once they’re launched, quitting them is hit and miss, depending on what else is running. This is because they launch multiple instances of Chrome that NSWorkspace can’t identify as separate applications.

As of v1.4.1, Bunch has a built-in workaround for this. You need to refer to the applications by their bundle identifier. This will usually be com.BZG.Coherence[Name of App], but sometimes (for reasons I’m unclear on) is just com.[Name of App]. So for an app called MindMeister, the bundle id would be com.BZG.CoherenceMindMeister, or possibly com.MindMeister. Try both, or see “Using the Bundle Identifier” to track it down yourself.

If you use the correct bundle id instead of the app name in your Bunch, the app should be able to launch and quit, regardless of whether Chrome/Brave/Canary is running.

Logic Pro is a curious beast. It needs to be called “Logic Pro X” to launch, but “Logic Pro” to quit. Bunch has a workaround for this that should allow you to safely use “Logic Pro X” without issue.

“Visual Studio Code” has the same issue as Logic above. Bunch has a hard coded workaround for VS Code that should allow you to safely use “Visual Studio Code” as the app name.

You can launch the current version with FileMaker Pro 18 Advanced, but Bunch can’t quit using the same name. If you use FileMaker Pro Advanced, Bunch will be able to quit it if it’s already running, but won’t be able to launch it.

In this case Bunch attempts to remove the number from the name when trying to quit the app, so use the numbered version in your Bunch, e.g. FileMaker Pro 18 Advanced or FileMaker Pro 18.

On non-English systems the default system directories (Documents, Photos, etc.) may have localized names displayed. Bunch needs to know the true path of a file in order to locate it, and that may be different from what you see in Finder.

To get the true path to a file, right click on it in Finder to bring up the contextual menu, then hold down the option key to see alternative menu items. Select “Copy ___ as Pathname” (though the menu item will probably look different if your system is non-English, bear with me). You should now have the true path to the selected file in your clipboard. Now just go back to your Bunch and hit ⌘V.

Another option is to open the Go To palette by pressing ⇧⌘G in Finder, clear the field, and drag a file into it. The result should be a path you can copy into a Bunch.

Bunch files absolutely require the extension .bunch. If you have macOS set to hide extensions, it may be assigning another extension in addition to .bunch (e.g. .bunch.txt). If a Bunch isn’t showing up in the menu, open Finder Preferences and check “Show all filename extensions” to double check.

Make sure your Bunch is plain text. If you edit in TextEdit or another Rich Text capable editor, the file may get saved as rich text. Switch to plain text mode and re-save the Bunch (double checking that it still has the .bunch extension).

If you make a change to a Bunch and suddenly your menu is empty, it means that something in the file caused Bunch to choke while reading in your Bunches. If possible, undo the last change and use Refresh Bunches to attempt to reload.

On rare occasions something really screwy happens and Bunch just stops reading files in the chosen directory. The solution is to change your Bunch Folder using Bunch Folder->Add button in Preferences, then change it right back (it will be in the dropdown).

If these steps don’t fix the issue, or the issue you’re having is not mentioned here, see the support page to get in touch.

If you use Bartender to hide the Bunch menu item, you may get weird results when triggering Bunch using the global hotkey (menu appearing off-screen, on secondary displays, etc.). To resolve this, disable the global hotkey in Bunch and add a hotkey for the menu item in Bartender settings (Bartender 4+)

Now when you hit your shortcut key, the Bunch menu item should be made visible momentarily before displaying the menu. Shortcuts for individual Bunches should work as expected once the menu is displayed.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (lua):
```lua
[...]
  <key>CFBundleName</key>
  <string>Google Chrome</string>
  [...]
```

Example 2 (unknown):
```unknown
mdls -name kMDItemDisplayName -r "/Applications/[App Name].app"
```

Example 3 (unknown):
```unknown
mdls -name kMDItemCFBundleIdentifier -r "/Applications/[App Name].app"
```

Example 4 (kotlin):
```kotlin
%FileMaker Pro 18 Advanced
!!!FileMaker Pro Advanced
```

---

## Changelog - Bunch.app

**URL:** https://bunchapp.co/docs/changelog/

**Contents:**
- Bunch Release Notes
      - The latest Bunch blog posts
      - Bunch in the wild

See documentation history

Beta Feature: this feature is currently in development and is only available to those using the preview build. If you want to help test new features, feel free to download and run the beta release.

(hide desktop) command not functioning

Fancy new icon design by Felippe van Eekhout

Allow !!!Triple Negative to quit an app when closing a Bunch without launching on open

Frontmatter keys for running scripts before/after opening a Bunch, and before/after closing

Process variables before importing snippets so that placeholders can be used for snippet fragments (<snippet#${fragmentvar})

All materials copyright © Brett Terpstra 2021

---

## Introducing Bunch - Bunch.app

**URL:** https://bunchapp.co/docs/

**Contents:**
- Welcome to Bunch
- Q: What’s a Context?
- A "context" is the environment you need for any given task/project
- Set Up Your Workspace
  - Launch/Quit Apps
  - Open Files
  - Open Websites
  - Send Keystrokes
- Tune Your Environment
  - Hide/Show The Dock

Bunch is a macOS utility that uses plain text scripts called “Bunches” to automate context switching. It sits in your menu bar, out of the way. When you click the menu item, it provides a list of your Bunches, each one representing an environment for your work or play. Bunches can open apps, specific files, web pages, and more. For the Power Users, It also allows advanced scripting, system commands, and integration via a URL handler.

I wrote Bunch because I tend to launch a specific group of apps depending on the context I’m working in. These are apps I wouldn’t launch on login, and don’t need running all the time. I just wanted to make starting a new context into one click. It started with little Script Editor and Automator applets, but I found I wanted something easily configured with text files, quick to set up and easy to modify. It grew from there.

Bunch has expanded a lot since that humble beginning. It can serve as a full context switcher, and handle just about everything you’d want to automate when starting a new context (see the Syntax Summary for an overview of all the cool stuff you can do).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 📞Comms
---
Messages
Slack
(dnd off)
```

---

## Troubleshooting - Bunch.app

**URL:** https://bunchapp.co/docs/troubleshooting/

**Contents:**
- Troubleshooting Bunch
- Debugging Bunches
- Debugging Scripts
- Specific App Not Launching or Quitting
  - Finding a “Registered” Name
  - Getting an App’s “Real” Name
    - Method 1: From Finder
    - Method 2: From Terminal
  - Using the Bundle Identifier
  - Known Exceptions

If you’re having issues with a Bunch not doing what you expected, consult the Bunch Log to see if you can trace the issue.

If needed, split out sections of a longer Bunch into temporary smaller Bunches and test them one at a time to narrow down any issues. Or just create one new, blank Bunch and copy one line at a time into it from the misbehaving Bunch, launching it for each now line until the behavior you’re trying to avoid happens, thus narrowing it down to that line.

If you’re debugging the opening of a Bunch and have your Bunches set to toggle, you can avoid having to repeatedly close the Bunch by holding down the Option key while clicking the menu item, or by using Clear All Checkmarks, which will tell Bunch that the Bunches are closed without actually executing any on-close behaviors or quitting any apps.

Also see the (log) command, which can be useful for pinpointing issues with variable assignment and execution sequence.

If you know which line is problematic and it doesn’t make sense, post about it in the forum. If it seems like a bug in Bunch, please let me know here.

See Debugging Scripts in the Advanced Scripting section for tips on tracking down issues with shell scripts.

If you list an app to launch or quit in your Bunch and nothing happens, the app in question may have a different name in the system than it shows in Finder. First double check that the filename you’re listing in your Bunch exactly matches the name of the application in Finder (minus the .app). If it does, and still doesn’t work, there are a couple of possibilities.

The first thing to try when tracking down the name an app responds to is to open Script Editor and go to File->Open Dictionary (⇧⌘O). If the app has an AppleScript dictionary, it will show up in that list with the name you probably need to use to operate on it. In cases like the app Things, this will reveal that the app is actually called “Things3.”

If that fails, you can locate the app in Finder (easy to do by ⌘-clicking the app icon in the Dock while it’s running). Right click (CTRL-click) on the app and choose [Show Package Contents]. Inside the “Contents” folder you’ll find Info.plist.

If Info.plist is in text format (they usually are), you can open it in your text editor and locate the key CFBundleName. If it’s different than the display name, try that in your Bunch.

If Info.plist is in binary format (which will be obvious when you try to open it in your text editor), you’ll need to use Terminal to get the info you’re looking for.

Open Terminal and enter the following command, substituting [App Name] with the actual application name. If the app is not located in /Applications, you’ll need to correct that part of the path as well.

You can also use an app’s bundle identifier instead of the app name. Use the steps above to read the app’s info, but look for the CFBundleIdentifier key instead.

This is the bundle identifier, and is a string that looks kind of like a URL. For example, Bunch’s bundle identifier is com.brettterpstra.Bunch. If you use the bundle id instead of the app name, it can help Bunch clarify instances where the app responds to a different name than the app’s filename.

If all of these fail, please do leave a note on the discussion forums.

In cases where an app responds to one name when launching but needs a different name to quit the running application (such as those detailed below), you can use a triple negative to quit an app using a different name when closing.

Single Site Browser’s created using Coherence X suffer all kinds of problems in Bunch. They can’t be launched if Chrome is running, you can’t launch more than one, and once they’re launched, quitting them is hit and miss, depending on what else is running. This is because they launch multiple instances of Chrome that NSWorkspace can’t identify as separate applications.

As of v1.4.1, Bunch has a built-in workaround for this. You need to refer to the applications by their bundle identifier. This will usually be com.BZG.Coherence[Name of App], but sometimes (for reasons I’m unclear on) is just com.[Name of App]. So for an app called MindMeister, the bundle id would be com.BZG.CoherenceMindMeister, or possibly com.MindMeister. Try both, or see “Using the Bundle Identifier” to track it down yourself.

If you use the correct bundle id instead of the app name in your Bunch, the app should be able to launch and quit, regardless of whether Chrome/Brave/Canary is running.

Logic Pro is a curious beast. It needs to be called “Logic Pro X” to launch, but “Logic Pro” to quit. Bunch has a workaround for this that should allow you to safely use “Logic Pro X” without issue.

“Visual Studio Code” has the same issue as Logic above. Bunch has a hard coded workaround for VS Code that should allow you to safely use “Visual Studio Code” as the app name.

You can launch the current version with FileMaker Pro 18 Advanced, but Bunch can’t quit using the same name. If you use FileMaker Pro Advanced, Bunch will be able to quit it if it’s already running, but won’t be able to launch it.

In this case Bunch attempts to remove the number from the name when trying to quit the app, so use the numbered version in your Bunch, e.g. FileMaker Pro 18 Advanced or FileMaker Pro 18.

On non-English systems the default system directories (Documents, Photos, etc.) may have localized names displayed. Bunch needs to know the true path of a file in order to locate it, and that may be different from what you see in Finder.

To get the true path to a file, right click on it in Finder to bring up the contextual menu, then hold down the option key to see alternative menu items. Select “Copy ___ as Pathname” (though the menu item will probably look different if your system is non-English, bear with me). You should now have the true path to the selected file in your clipboard. Now just go back to your Bunch and hit ⌘V.

Another option is to open the Go To palette by pressing ⇧⌘G in Finder, clear the field, and drag a file into it. The result should be a path you can copy into a Bunch.

Bunch files absolutely require the extension .bunch. If you have macOS set to hide extensions, it may be assigning another extension in addition to .bunch (e.g. .bunch.txt). If a Bunch isn’t showing up in the menu, open Finder Preferences and check “Show all filename extensions” to double check.

Make sure your Bunch is plain text. If you edit in TextEdit or another Rich Text capable editor, the file may get saved as rich text. Switch to plain text mode and re-save the Bunch (double checking that it still has the .bunch extension).

If you make a change to a Bunch and suddenly your menu is empty, it means that something in the file caused Bunch to choke while reading in your Bunches. If possible, undo the last change and use Refresh Bunches to attempt to reload.

On rare occasions something really screwy happens and Bunch just stops reading files in the chosen directory. The solution is to change your Bunch Folder using Bunch Folder->Add button in Preferences, then change it right back (it will be in the dropdown).

If these steps don’t fix the issue, or the issue you’re having is not mentioned here, see the support page to get in touch.

If you use Bartender to hide the Bunch menu item, you may get weird results when triggering Bunch using the global hotkey (menu appearing off-screen, on secondary displays, etc.). To resolve this, disable the global hotkey in Bunch and add a hotkey for the menu item in Bartender settings (Bartender 4+)

Now when you hit your shortcut key, the Bunch menu item should be made visible momentarily before displaying the menu. Shortcuts for individual Bunches should work as expected once the menu is displayed.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (lua):
```lua
[...]
  <key>CFBundleName</key>
  <string>Google Chrome</string>
  [...]
```

Example 2 (unknown):
```unknown
mdls -name kMDItemDisplayName -r "/Applications/[App Name].app"
```

Example 3 (unknown):
```unknown
mdls -name kMDItemCFBundleIdentifier -r "/Applications/[App Name].app"
```

Example 4 (kotlin):
```kotlin
%FileMaker Pro 18 Advanced
!!!FileMaker Pro Advanced
```

---

## Introducing Bunch - Bunch.app

**URL:** https://bunchapp.co/docs/index/

**Contents:**
- Welcome to Bunch
- Q: What’s a Context?
- A "context" is the environment you need for any given task/project
- Set Up Your Workspace
  - Launch/Quit Apps
  - Open Files
  - Open Websites
  - Send Keystrokes
- Tune Your Environment
  - Hide/Show The Dock

Bunch is a macOS utility that uses plain text scripts called “Bunches” to automate context switching. It sits in your menu bar, out of the way. When you click the menu item, it provides a list of your Bunches, each one representing an environment for your work or play. Bunches can open apps, specific files, web pages, and more. For the Power Users, It also allows advanced scripting, system commands, and integration via a URL handler.

I wrote Bunch because I tend to launch a specific group of apps depending on the context I’m working in. These are apps I wouldn’t launch on login, and don’t need running all the time. I just wanted to make starting a new context into one click. It started with little Script Editor and Automator applets, but I found I wanted something easily configured with text files, quick to set up and easy to modify. It grew from there.

Bunch has expanded a lot since that humble beginning. It can serve as a full context switcher, and handle just about everything you’d want to automate when starting a new context (see the Syntax Summary for an overview of all the cool stuff you can do).

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: 📞Comms
---
Messages
Slack
(dnd off)
```

---

## Site Index - Bunch.app

**URL:** https://bunchapp.co/docs/site_index

**Contents:**
- Bunch Documentation

Search by keyword or tag:

All materials copyright © Brett Terpstra 2021

---

## Installation - Bunch.app

**URL:** https://bunchapp.co/docs/installation/

**Contents:**
- Download And Install
- Accessibility Permissions
- Additional Permissions
- Notifications
    - See Also:

Just download the DMG and double click it to mount. Drag the Bunch icon to the Applications folder.

You can then launch Bunch from your Applications folder. (Or with Spotlight. Or LaunchBar or Alfred. Or the command line. Or AppleScript…)

When Bunch launches, it will appear in your menu bar (no Dock icon). All of Bunch’s features are accessed by clicking the stem icon in the menu bar.

The first time your run Bunch, you’ll get a welcome screen that will let you set some basic options, such as Launch at Login, which is recommended so you always have Bunch available.

See the configuration section for instructions on personalizing the setup. In Preferences, use the “Reveal” button next to the Bunch Folder setting to go directly to that folder and start editing/adding Bunches.

To use some of Bunch’s features, you’ll need to give it Accessibility permission in System Preferences. During the welcome sequence, Bunch will ask you to give it permission, and provide a shortcut to opening System Preferences.

In System Preferences, go to “Security & Privacy,” then select the “Accessibility” tab from the list on the left. Click the lock icon in the bottom left and unlock the preferences with your system password. If Bunch isn’t already in the list, use the (+) button to add it from your Applications folder. Ensure that the checkbox next to it in the list is checked.

As Bunch attempts to control various apps and features of the operating system, you will be asked to grant Bunch permission to perform new operations. Because Bunch is all about automating other apps, your first runs will include a lot of these dialogs. Once you allow an operation, though, you won’t be asked again in the future.

At some point you will be asked to allow Bunch to send notifications. Please enable this, as some of Bunch’s error reporting is done through the Notification Center in order to allow your Bunches to run without interrupting for non-fatal errors. It’s recommended that you set the notification style to “Alerts” in System Preferences->Notifications. There’s a shortcut to this System Preferences pane in Bunch Preferences.

All materials copyright © Brett Terpstra 2021

---

## Installation - Bunch.app

**URL:** https://bunchapp.co/docs/installation

**Contents:**
- Download And Install
- Accessibility Permissions
- Additional Permissions
- Notifications
    - See Also:

Just download the DMG and double click it to mount. Drag the Bunch icon to the Applications folder.

You can then launch Bunch from your Applications folder. (Or with Spotlight. Or LaunchBar or Alfred. Or the command line. Or AppleScript…)

When Bunch launches, it will appear in your menu bar (no Dock icon). All of Bunch’s features are accessed by clicking the stem icon in the menu bar.

The first time your run Bunch, you’ll get a welcome screen that will let you set some basic options, such as Launch at Login, which is recommended so you always have Bunch available.

See the configuration section for instructions on personalizing the setup. In Preferences, use the “Reveal” button next to the Bunch Folder setting to go directly to that folder and start editing/adding Bunches.

To use some of Bunch’s features, you’ll need to give it Accessibility permission in System Preferences. During the welcome sequence, Bunch will ask you to give it permission, and provide a shortcut to opening System Preferences.

In System Preferences, go to “Security & Privacy,” then select the “Accessibility” tab from the list on the left. Click the lock icon in the bottom left and unlock the preferences with your system password. If Bunch isn’t already in the list, use the (+) button to add it from your Applications folder. Ensure that the checkbox next to it in the list is checked.

As Bunch attempts to control various apps and features of the operating system, you will be asked to grant Bunch permission to perform new operations. Because Bunch is all about automating other apps, your first runs will include a lot of these dialogs. Once you allow an operation, though, you won’t be asked again in the future.

At some point you will be asked to allow Bunch to send notifications. Please enable this, as some of Bunch’s error reporting is done through the Notification Center in order to allow your Bunches to run without interrupting for non-fatal errors. It’s recommended that you set the notification style to “Alerts” in System Preferences->Notifications. There’s a shortcut to this System Preferences pane in Bunch Preferences.

All materials copyright © Brett Terpstra 2021

---
