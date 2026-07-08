# Bunchapp - Integration

**Pages:** 39

---

## MailMate - Bunch.app

**URL:** https://bunchapp.co/docs/integration/mailmate/

**Contents:**
- Integrating with MailMate
    - See Also:

You can use MailMate for sending automated emails. There’s a utility included with MailMate called emate. To install it, run:

Then in a Bunch, you can call it to send an email, substituting variables to allow dynamic emails.

By default the emate command will create the email and open the Compose window, ready to send. To send the email immediately without interaction, include the flag --send-now.

To have the contents processed as Markdown, include the flag --header "#markup: markdown".

A Bunch script item might look like this:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
ln -s /Applications/MailMate.app/Contents/Resources/emate /usr/local/bin/
```

Example 2 (bash):
```bash
// Dropdown selection for recipient email
recipient = ?[address1@example.com, address2@example.com, address3@example.com]
// Text input for email subject
subject = ?"What email subject?"

$ echo -e "# Just Testing\n\n- See how this goes\n- Should make a Markdown list\n"|/usr/local/bin/emate mailto --to "${recipient}" -f "tester@example.com" --subject "${subject}" --header "#markup: markdown" --send-now
```

---

## BetterTouchTool - Bunch.app

**URL:** https://bunchapp.co/docs/integration/bettertouchtool

**Contents:**
- Integrating with BetterTouchTool
- Triggering BetterTouchTool from Bunch
- Triggering Bunch from BetterTouchTool
    - See Also:

BetterTouchTool is an amazing automation utility for building actions for your trackpad, keyboard, touch bar, and more. It’s available via Setapp and as a standalone purchase. It also happens to have a fully-fledged url scheme that can be used to trigger actions, save and set variables, and even things like updating text in your touch bar or displaying webviews and HUDs.

Possibilities include adding mouse movement and click actions to your Bunches, positioning and sizing windows, controlling music players, connecting/disconnecting Bluetooth devices, modifying system settings that Bunch doesn’t handle, and more, all without having to write scripts (although scripting is also an option).

See the BetterTouchTool URL handler documentation to see what’s possible. When you’re ready to trigger an action from your Bunch, it’s as easy as dropping a URL into your Bunch file.

You can click any action and choose “Copy Link to Activate Trigger” to get a URL ready to paste directly into your Bunch. It will look like:

To trigger a named trigger:

You can also control BetterTouchTool with its extensive AppleScript library, if you prefer. Just be sure to enable external scripting in Preferences->General.

You can also use BetterTouchTool to add system tools that trigger Bunches outside of the Bunch menu. Whether it’s assigning a Bunch trigger to a gesture, or adding Touch Bar icons for Bunches to your MacBook Pro, BetterTouchTool makes it easy.

Just add the type of trigger you want, then assign an Execute Shell Script action to it, using open '[BUNCH URL]', using the Bunch URL handler to act on the desired Bunch. (Using the Execute Shell Script action instead of Open URL prevents BetterTouchTool from first opening your default browser.)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
btt://execute_assigned_actions_for_trigger/?uuid=4D05E320-E682-411A-81A5-BD9B82DD8B4D
```

Example 2 (sass):
```sass
btt://trigger_named/?trigger_name=TriggerName
```

---

## Multi-Select Dialog - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/multi-select/

**Contents:**
- Dialogs Allowing Multiple Selections
    - See Also:

Bunch offers several methods for creating interactive Bunches, but you can also use a little scripting if you need more flexibility. In this case, we’ll add a dialog that allows the user to select multiple options and then act on them.

Since writing this howto, multi-select dialogs have been added to Bunch. That said, this is still a good example of scripting within a Bunch.

You can use AppleScript to display a multiple choice dialog allowing multiple selections. This can be used to launch multiple bunches with user interaction.

Call a script like that within one Bunch, and it can lead to launching other Bunches based on user response.

This strategy can be used with simple yes/no dialogs as well, taking alternate paths based on the response. Any script that can accept user responses via a GUI can use the Bunch URL handler to continue processing Bunches.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (swift):
```swift
set _res to choose from list {"Comms", "Podcast Record", "Podcast Edit", "Music"} with prompt "What next?" OK button name "Launch" with multiple selections allowed and empty selection allowed

repeat with _bunch in _res
    do shell script "open 'x-bunch://open/" & _bunch & "'"
end repeat
```

---

## Command Line Tool - Bunch.app

**URL:** https://bunchapp.co/docs/integration/cli/

**Contents:**
- The Bunch CLI
    - See Also:

The latest version is Bunch CLI v1.1.14.

If using Bunch Beta, use the pre-release version of the CLI: gem install bunchcli --pre.

Install the Bunch CLI using gem install bunchcli.

Installing the gem provides the executable bunch, which should now be in your path.

Run bunch -h for usage instructions.

The command line tool can also be used to generate Bunch URLs for use in other applications. To output any command as a URL instead of executing it, add -u:

To generate a URL interactively, run:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
CLI for Bunch.app v1.1.14
    -l, --list                       List available Bunches
    -s, --show BUNCH                 Show contents of Bunch
    -o, --open                       Open Bunch ignoring "Toggle Bunches" preference
    -c, --close                      Close Bunch ignoring "Toggle Bunches" preference
    -t, --toggle                     Toggle Bunch ignoring "Toggle Bunches" preference
        --snippet                    Load as snippet
        --fragment=FRAGMENT          Run a specific section
        --vars=VARS                  Variables to pass to a snippet, comma-separated
        --pref                       Set a preference. Run without argument to list available preferences.
    -u, --url                        Output URL instead of opening
    -i, --interactive                Interactively generate a Bunch url
        --show-config                Display all configuration values
        --show-config-key KEY        Display a config value [dir, toggle, method]
    -f, --force-refresh              Force refresh cached preferences
    -h, --help                       Display this screen
    -v, --version                    Display Bunch version

Usage: bunch [options] BUNCH_NAME|PATH_TO_FILE

Bunch names are case insensitive and will execute shortest match
Use 'bunch -h' to display options
```

Example 2 (markdown):
```markdown
# Open or Toggle Coding.bunch
bunch Coding

# Force open Coding.bunch
bunch -o Coding
```

Example 3 (unknown):
```unknown
bunch -o Coding -u
```

---

## LaunchBar, Alfred, and Raycast - Bunch.app

**URL:** https://bunchapp.co/docs/integration/launchbar-and-alfred

**Contents:**
- LaunchBar, Alfred, and Raycast
- LaunchBar
- Alfred
- Raycast
    - See Also:

Despite Bunch having plenty of its own keyboard shortcuts, you may want to integrate with your favorite launcher. There are existing options for doing so with LaunchBar, Alfred, and Raycast.

You can also create integrations with Keyboard Maestro or BetterTouchTool to fit other workflows.

Download the Bunches Action for LaunchBar

I’ve added a LaunchBar action for Bunch. Download, unzip it, then double click the unzipped action to install.

Selecting the Bunch action in LaunchBar and pressing return will list your available Bunches. If you have “Toggle Bunches” enabled, selecting a Bunch from the list will toggle it (quitting apps if it’s already been opened), otherwise it will simply open the Bunch. Each Bunch in the menu will also have a submenu you can access by pressing the right arrow which contains the actions (open, close, toggle) that aren’t the default action.

Holding modifier keys when opening the action changes the default methods for that run:

The menu also contains the ability to switch your opening preference between “Open” and “Toggle.” This will affect your Bunch preferences directly.

If you bring up the Bunches action and press Space, you can type or paste raw Bunch commands to be executed.

See “Better Bunch for LaunchBar” for the latest changes to the Action.

Jay Miller has created an Alfred action for use with Bunch.

koinzhang has created a Raycast extension for Bunch.

All materials copyright © Brett Terpstra 2021

---

## Dialogs From Files - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/dialogs-from-files/

**Contents:**
- Dialogs From Files
- The Roundabout Way
    - See Also:

As of v1.4.4, Bunch can directly read external files to generate options for interactive dialogs. Options can be returned as JSON, YAML, or just a plain text list. See Interactivity/External Files for more details.

You can also build dialogs dynamically by reading the contents of an external file into a variable, then using the variable as the options for a dialog.

Let’s assume you have a script that reads JSON data from an API and outputs a text file in a format Bunch can use for an interactive dialog. You would want to run the script before processing the Bunch in order to populate the text file before calling the dialog. Do this using run before: frontmatter.

That script would output a text file. Assuming we’re building a dictionary-style dialog, we can output the options to a text file like this:

Now, within the Bunch, we’ll read that text file into a variable using cat:

Then we can use the /raw transform on the variable to substitute the raw contents of that variable into a query dialog:

When we open this Bunch, it will now run the script (not shown) to generate a Bunch-compatible list of options in a text file before running other items. Then, within the Bunch, read that text file into a variable and use it to display a menu of options. Putting it all together:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: Dialogs from Files
run before: get_json.rb
---
```

Example 2 (scala):
```scala
Option 1 => Value 1
Option 2 => Value 2
Option 3 => Value 3
```

Example 3 (unknown):
```unknown
options = $ cat ~/scripts/json_results.txt
```

Example 4 (bash):
```bash
choice = ?{${options/raw}}
```

---

## Advanced Scripting - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting//

**Contents:**
- Advanced Scripting Examples
- Section Contents
    - See Also:

These are just some examples of things you can do with external scripting and Bunch. Most are a bit silly, and are intended to serve as demonstrations for your own exploration.

All materials copyright © Brett Terpstra 2021

---

## Moom - Bunch.app

**URL:** https://bunchapp.co/docs/integration/moom/

**Contents:**
- Integrating with Moom
    - See Also:

(Check out this great post on Moom 4 and Bunch from Stephen Millard)

You can integrate with the fantastic window manager, Moom, for detailed control over how windows are organized after a Bunch launches.

I originally wrote about this on my blog. Since writing that, Bunch has added the delayed launching feature, which is ideal for having Moom wait until all apps in the Bunch have loaded before attempting to modify their window positions.

First, launch the Bunch and time how long it takes all of the apps to fully load. Then arrange the windows as desired, and use Moom’s Save Window Layout Snapshot… feature to store a snapshot with a unique title. If needed, see my original post for more details.

Once you have the named snapshot, you can add a line to your Bunch calling it with AppleScript:

Note the ~10 at the end of the line, telling Bunch to wait 10 seconds before running the command. Change that to however long it takes this particular Bunch to load.

Alternatively, put the script line in a snippet and call it with the Waiting Snippet feature.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
%nvUltra
Audio Hijack
Skype

* tell application "Moom" to arrange windows according to snapshot "Podcasting" ~10
```

---

## Custom Dialogs - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/custom-dialogs/

**Contents:**
- Multiple Choice Dialogs
- Selecting A Spotify Playlist
    - See Also:

Bunch’s multiple choice interactivity feature can make this example a simpler process, but it serves as a demonstration of using external scripting to provide a multiple choice menu. It can be used to extend beyond the basic menuing that Bunch provides.

Here’s an example using from script frontmatter to let you pick from your favorite Spotify playlists or perform a Spotify search.

The script is in JavaScript (for Automation) and saved in a scripts folder inside my Bunch folder. I can reference it with the relative path scripts/ChoosePlaylist.applescript.

The script would take some modification with your own playlists and titles, but would be easy to change:

The above script offers a list with the keys from the playlists object. If you cancel, it outputs Spotify’s base url handler, ‘spotify:’. If you select “Search,” it pops up a second dialog asking for a search string, then formats that into a URL encoded Spotify URL for searching. If you pick a playlist, it returns the value for that key, which is already a full Spotify URI.

Now create a Bunch that just contains:

When the Bunch is opened, it runs the above script and stores the spotifyurl variable. The embedded snippet launches Spotify and passes the URL to it. Having Silicio and Spotify in the Bunch means that when I close it, both apps quit, making music listening easy to manage. You could also add automation for setting audio devices and volumes, running Moom to position windows, etc.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (json):
```json
#!/usr/bin/osascript -l JavaScript

var app = Application.currentApplication()
app.includeStandardAdditions = true

var playlists = {
    "Mellow": "spotify:​playlist:37i9dQZF1E35F7NsH3aWbs",
    "Pop": "spotify:​playlist:37i9dQZF1E39mpAvbgovri",
    "Punk": "spotify:​playlist:37i9dQZF1E3930Ag6USpnA",
    "Indie": "spotify:​playlist:37i9dQZF1E39UzhnpcOJqd",
    "Metal": "spotify:​playlist:37i9dQZF1E35o96rAfTenf",
    "Rock": "spotify:​playlist:37i9dQZF1E38gxK1HWfQU0",
    "Search": ""
}


var list = app.chooseFromList(Object.keys(playlists), {
    withPrompt: "What to play?",
    defaultItems: ["Search"]})[0];

if (list === undefined) {
    'spotify url: spotify:'
} else if (playlists[list] === "") {
  var search = app.displayDialog("What to search for?", {
    defaultAnswer: "",
    buttons: ["Cancel", "Search"],
    defaultButton: "Search"
  });
  `spotify url: spotify:​search:${encodeURIComponent(search.textReturned)}`
} else {
  `spotify url: ${playlists[list]}`
}
```

Example 2 (yaml):
```yaml
---
title: 🎵Listen
from script: scripts/ChoosePlaylist.applescript
---
Silicio
<<#Search Spotify
___
---[Search Spotify]---
Spotify
- ${spotifyurl}
```

Example 3 (yaml):
```yaml
---
title: 🎵Listen
from script: scripts/ChoosePlaylist.applescript
---
(audio output Komplete Audio)
Silicio
<<#Search Spotify
___
-[Search Spotify]
Spotify
- ${spotifyurl}
# Alternatively to the file parameter,
# you could use this to start playing immediately:
# * tell app "Spotify" to play track "${spotifyurl}"
```

---

## Home Automation - Bunch.app

**URL:** https://bunchapp.co/docs/integration/other-automation/

**Contents:**
- Home Automation
- Home Automation with Indigo
- IFTTT
- HomeKit and Shortcuts
- Others?
    - See Also:

Bunch doesn’t have any built in tools for home automation integration, but depending on your setup, you can still control just about any device from within a Bunch.

If you use Indigo, there’s a whole REST API available that you can incorporate using URLs. You can also use AppleScripts that you can call using * lines in your Bunch.

Example REST call to turn my office lights on to 100%:

Using curl and a shell command prevents Bunch from trying to open the URL in the browser, performing the HTTP GET request in the background. You can also use curl to perform POST requests, add headers and body content, and anything else you need to do.

Like the Indigo automation, you can set up IFTTT applets to respond to Webhooks and call them with curl. You’ll need your Maker key, which you can get when you’re signed in: visit this link, and click “Documentation.” Create a new applet with a Webhook for the “If”, give it an event name, and add your “Then” actions. Your URL will look like:

You can invoke any Shortcut in a Bunch by name using the shortcut command:

Shortcuts can control HomeKit devices, which means you can use the Shortcuts app to add home automation to a Bunch.

If you have a home automation system that’s scriptable, I’d love to include details here. Please pop into the Discussions and let me know.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
$ curl 'http:​//192.168.1.9:8177/devices/office%20lights.json?brightness=100&_method=put'
```

Example 2 (unknown):
```unknown
$ curl -X POST https:​//maker.ifttt.com/trigger/EVENTNAME/with/key/YOURMAKERKEY
```

Example 3 (unknown):
```unknown
(shortcut Shortcut Name)
```

---

## Touch Bar Status Board - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/bunch-status-board/

**Contents:**
- Creating a Bunch Status Board in Your Touch Bar
    - See Also:

I’ve created a BetterTouchTool-Widgets script which can generate all of the Bunch widgets in your Touch Bar, get their UUIDs for updating, and handle refreshing the widgets. To use the script with Bunch:

Add (or update) a folder.frontmatter file in your Bunch folder with the following keys:

The above scripts make use of the built-in frontmatter key basename, which returns the actual filename of your Bunch, ignoring any display title settings. The keys that the script creates based on the AppleScript response to tell app "Bunch" to list bunches will match the value of basename key for whatever Bunch is calling it.

Note that this method applies the run after: scripts to every Bunch in the folder. If you’re using run after: scripts in any of your individual Bunches, you’ll need to append this script after the existing ones in Bunches containing that key, as that will override the setting in folder.frontmatter. You can run multiple scripts by separating with a comma:

Now whenever a Bunch opens or closes, its associated Touch Bar button will be updated with its state. The script to handle checking state is created and linked automatically when running btt_stats.rb add touch bunch.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
 run after: /path/to/btt_stats.rb refresh "bunch:${basename}"
 run after close: /path/to/btt_stats.rb refresh "bunch:${basename}"
 ---
```

Example 2 (yaml):
```yaml
---
run after: my_original_script.sh, /path/to/btt_stats.rb refresh "bunch:${basename}"
run after close: my_original_script.sh, /path/to/btt_stats.rb refresh "bunch:${basename}"
---
```

---

## Moom - Bunch.app

**URL:** https://bunchapp.co/docs/integration/moom

**Contents:**
- Integrating with Moom
    - See Also:

(Check out this great post on Moom 4 and Bunch from Stephen Millard)

You can integrate with the fantastic window manager, Moom, for detailed control over how windows are organized after a Bunch launches.

I originally wrote about this on my blog. Since writing that, Bunch has added the delayed launching feature, which is ideal for having Moom wait until all apps in the Bunch have loaded before attempting to modify their window positions.

First, launch the Bunch and time how long it takes all of the apps to fully load. Then arrange the windows as desired, and use Moom’s Save Window Layout Snapshot… feature to store a snapshot with a unique title. If needed, see my original post for more details.

Once you have the named snapshot, you can add a line to your Bunch calling it with AppleScript:

Note the ~10 at the end of the line, telling Bunch to wait 10 seconds before running the command. Change that to however long it takes this particular Bunch to load.

Alternatively, put the script line in a snippet and call it with the Waiting Snippet feature.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
%nvUltra
Audio Hijack
Skype

* tell application "Moom" to arrange windows according to snapshot "Podcasting" ~10
```

---

## Getting Preferences - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/defaults/

**Contents:**
- Getting Bunch Preferences in a Script
- Using AppleScript
- Using the Command Line Tool
- Using the defaults Command
    - See Also:

There are several ways to access Bunch’s preferences from scripts. The most useful preference to get to is the location of your current Bunch Folder, but you may have cause to check other settings.

Lastly, you can retrieve some settings via AppleScript:

See the AppleScript documentation for more details.

You can also use the Bunch CLI to query specific keys.

You can access various preferences from the command line using defaults. The following will return the current location of your Bunch files:

Getting a list of available bunches is as easy as doing an ls *.bunch on that folder.

You can also check the “Toggle Bunches” and “Single Bunch Mode” settings:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
tell application "Bunch" to get preference "Bunch Folder"
```

Example 2 (unknown):
```unknown
$ bunch --show-config-key dir
/Users/username/bunches

$ bunch --show-config-key toggle
true
```

Example 3 (unknown):
```unknown
defaults read com.brettterpstra.bunch configDir
```

Example 4 (unknown):
```unknown
defaults read com.brettterpstra.bunch toggleBunches
defaults read com.brettterpstra.bunch singleBunchMode
```

---

## Integration - Bunch.app

**URL:** https://bunchapp.co/docs/integration/

**Contents:**
- Integrating Bunch With Other Tools
- Section Contents

For advanced usage, there are many ways to extend the power of Bunch for your workflow. Between Bunch’s own tools like its URL Handler, AppleScript dictionary, and command line interface to its ability to integrate with some amazing Mac automation tools, there’s no limit to what you can do.

For window placement and sizing automation, check out integration with Moom.

To add Bunch actions to your Touch Bar, Stream Deck, gestures on your trackpad, or many other triggers, take a look at integrating with BetterTouchTool, Keyboard Maestro, and Hammerspoon.

All materials copyright © Brett Terpstra 2021

---

## LaunchBar, Alfred, and Raycast - Bunch.app

**URL:** https://bunchapp.co/docs/integration/launchbar-and-alfred/

**Contents:**
- LaunchBar, Alfred, and Raycast
- LaunchBar
- Alfred
- Raycast
    - See Also:

Despite Bunch having plenty of its own keyboard shortcuts, you may want to integrate with your favorite launcher. There are existing options for doing so with LaunchBar, Alfred, and Raycast.

You can also create integrations with Keyboard Maestro or BetterTouchTool to fit other workflows.

Download the Bunches Action for LaunchBar

I’ve added a LaunchBar action for Bunch. Download, unzip it, then double click the unzipped action to install.

Selecting the Bunch action in LaunchBar and pressing return will list your available Bunches. If you have “Toggle Bunches” enabled, selecting a Bunch from the list will toggle it (quitting apps if it’s already been opened), otherwise it will simply open the Bunch. Each Bunch in the menu will also have a submenu you can access by pressing the right arrow which contains the actions (open, close, toggle) that aren’t the default action.

Holding modifier keys when opening the action changes the default methods for that run:

The menu also contains the ability to switch your opening preference between “Open” and “Toggle.” This will affect your Bunch preferences directly.

If you bring up the Bunches action and press Space, you can type or paste raw Bunch commands to be executed.

See “Better Bunch for LaunchBar” for the latest changes to the Action.

Jay Miller has created an Alfred action for use with Bunch.

koinzhang has created a Raycast extension for Bunch.

All materials copyright © Brett Terpstra 2021

---

## Command Line Tool - Bunch.app

**URL:** https://bunchapp.co/docs/integration/cli

**Contents:**
- The Bunch CLI
    - See Also:

The latest version is Bunch CLI v1.1.14.

If using Bunch Beta, use the pre-release version of the CLI: gem install bunchcli --pre.

Install the Bunch CLI using gem install bunchcli.

Installing the gem provides the executable bunch, which should now be in your path.

Run bunch -h for usage instructions.

The command line tool can also be used to generate Bunch URLs for use in other applications. To output any command as a URL instead of executing it, add -u:

To generate a URL interactively, run:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
CLI for Bunch.app v1.1.14
    -l, --list                       List available Bunches
    -s, --show BUNCH                 Show contents of Bunch
    -o, --open                       Open Bunch ignoring "Toggle Bunches" preference
    -c, --close                      Close Bunch ignoring "Toggle Bunches" preference
    -t, --toggle                     Toggle Bunch ignoring "Toggle Bunches" preference
        --snippet                    Load as snippet
        --fragment=FRAGMENT          Run a specific section
        --vars=VARS                  Variables to pass to a snippet, comma-separated
        --pref                       Set a preference. Run without argument to list available preferences.
    -u, --url                        Output URL instead of opening
    -i, --interactive                Interactively generate a Bunch url
        --show-config                Display all configuration values
        --show-config-key KEY        Display a config value [dir, toggle, method]
    -f, --force-refresh              Force refresh cached preferences
    -h, --help                       Display this screen
    -v, --version                    Display Bunch version

Usage: bunch [options] BUNCH_NAME|PATH_TO_FILE

Bunch names are case insensitive and will execute shortest match
Use 'bunch -h' to display options
```

Example 2 (markdown):
```markdown
# Open or Toggle Coding.bunch
bunch Coding

# Force open Coding.bunch
bunch -o Coding
```

Example 3 (unknown):
```unknown
bunch -o Coding -u
```

---

## Integration - Bunch.app

**URL:** https://bunchapp.co/docs/integration//

**Contents:**
- Integrating Bunch With Other Tools
- Section Contents

For advanced usage, there are many ways to extend the power of Bunch for your workflow. Between Bunch’s own tools like its URL Handler, AppleScript dictionary, and command line interface to its ability to integrate with some amazing Mac automation tools, there’s no limit to what you can do.

For window placement and sizing automation, check out integration with Moom.

To add Bunch actions to your Touch Bar, Stream Deck, gestures on your trackpad, or many other triggers, take a look at integrating with BetterTouchTool, Keyboard Maestro, and Hammerspoon.

All materials copyright © Brett Terpstra 2021

---

## URL Handler - Bunch.app

**URL:** https://bunchapp.co/docs/integration/url-handler

**Contents:**
- The Bunch URL Handler
- Quick Reference
- x-callback-url
- Methods
  - open
  - close
  - toggle
  - edit
  - raw
  - refresh

Bunch has its own URL scheme (x-bunch:) that you can call from other apps and scripts.

Beta testers: Bunch Beta can be targeted with x-bunch-beta if you have both installed and need to make sure your URLs open in the right version.

Tip: You can use URLs with apps like BetterTouchTool and Keyboard Maestro to assign Bunch actions to hotkeys, buttons and other triggers. If you have a cool programmable keypad or a Stream Deck, just imagine the possibilities…

Just create an action that opens a URL and use something like:

x-bunch://toggle/BunchName

to create a hotkey or button that toggles a Bunch. You can create a whole launch control panel on a Stream Deck with these, for example.

Tip: The Bunch CLI can generate URLs that run various commands for use in other applications. Run bunch -i to interactively build a URL.

All methods can be called in x-callback-url format, for compatibility. Simply prefix x-callback-url in the path, and optionally provide an x-source query parameter. If an x-source is provided and no x-success value is present, the x-source (URL, app name, or bundle identifier) will be called upon completion. (It’s assumed that you want focus returned after executing a Bunch command, as making Bunch a foreground app is relatively pointless.)

See the x-success parameter to control what happens after a URL method is executed.

The full version of the open method is x-bunch://open?bunch=[BUNCH NAME]. The url can be shortened, though, to just the Bunch name: x-bunch://[BUNCH NAME].

Specify multiple Bunches to open by separating the names with commas, e.g. x-bunch://open?bunch=Bunch%201,Bunch%202. This works with any of the actions that act on Bunches (open, toggle, close). It also works when using “path” syntax, e.g. x-bunch://toggle/Bunch%201,Bunch%202.

The Bunch name in the URL handler is case insensitive, so “bunch name” works just as well as “Bunch Name.” Bunch does need to already be running in order to execute a bunch via the URL handler. You can always launch Bunch with open -a Bunch from a script, but you’ll need to give it enough time to initialize.

Tip: If you have a task in a task manager that requires a certain set of apps, create a Bunch and then add a link to the task’s notes: x-bunch://open/WorkBunch

You can also close a Bunch with x-bunch://close?bunch=[BUNCH NAME], or just x-bunch://close/[BUNCH NAME].

You can also toggle the Bunch — opening if it’s closed, closing if it’s open — using x-bunch://toggle?bunch=[BUNCH NAME]. Like the other methods, this also works as x-bunch://toggle/[BUNCH NAME]. This works even if “Toggle Bunches” isn’t enabled.

If using the “Toggle Bunches” option, Bunches opened/closed via the URL handler will automatically set the launched state of the Bunch in the Dock menu. The open and close commands will not toggle Bunches; those commands will execute regardless of current Bunch state.

The full version of the edit method is x-bunch://edit?bunch=[BUNCH NAME]. The url can be shortened to path format: x-bunch://edit/[BUNCH NAME].

The Bunch Editor must be set in Preferences for this command to execute. If it’s not, an alert will be displayed. {.warning}

You can pass Bunch commands and directives directly through the URL handler. With this you can specify a path to a Bunch file outside of your Bunch folder, or even pass a url-encoded string containing Bunch directives.

If you pass a Bunch file using this method, the Bunch isn’t technically “opened,” i.e. it won’t appear as toggled “on” in the menu when Toggle Bunches is enabled. This provides one way to open a Bunch without affecting its state.

Only one of file or txt should be specified

Force Bunch to reload Bunch files. This should happen automatically if you make changes to the Bunch folder while Bunch is running, but use this if you want to ensure an update.

Reveal the Bunch Folder in Finder.

You can set and toggle certain preferences with the setPref method. All boolean parameters accept 0 and 1, as well as “true” or “false”, or “yes” or “no”.

Tip: You can use this URL handler to easily switch between sets of Bunches using external tools. For example, you could add a button to your Touch Bar using BetterTouchTool to trigger a URL like x-bunch://setPref?configDir=~/Dropbox/Sync/WorkBunches, or create a Keyboard Maestro macro that toggled between two folders.

You can directly load a snippet and define variables with the snippet method. This allows you to load files containing variables and to use the snippet fragment feature to load just a portion of a snippet.

A Bunch can also be called as a snippet, and if it contains fragment identifiers, a smaller section of the Bunch can be loaded using the snippet method.

This URL method can be shortened to snippet/SNIPPET_FILE/FRAGMENT?variables=foobar.

Fragment ID can also be added to the filename with a hash (#FRAGMENT) but it should be percent-encoded in the URL as %23, e.g. snippet/SNIPPET_FILE%23FRAGMENT.

Cause Bunch to display the Preferences dialog.

All url methods accept an x-success parameter which can define a bundle ID or url to open after executing the method. By default this happens after a 1-second delay, but you can modify that with an x-delay parameter (number of seconds as integer).

With the open and toggle commands you can pass additional, arbitrary query parameters to set frontmatter keys. Simply append key/value pairs when calling:

This can be used to populate variables in the Bunch and its snippets at the time you call the url handler. For example, if you have a Bunch that contains an embedded snippet with a variable launch:

Then normally that Bunch would launch Safari when it opens, as that’s the default value set in the snippet when launch is undefined. If you call it with a value specified in the url handler, though, you can replace the default value:

Opening this URL will launch TextEdit instead of Safari. Variables defined in the query string override keys hard coded in the Bunch frontmatter. Variables defined on-the-fly by from script or from file frontmatter will still override query parameters.

All methods that accept a bunch parameter can instead receive a tag parameter to operate on all Bunches matching a tag or tag combination. Multiple tags can be combined using a comma (,) for OR, or a plus sign (+) for AND.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
x-bunch://x-callback-url/open?bunch=Comms&x-source=com.googlecode.iterm2
```

Example 2 (sass):
```sass
# Full URL
open 'x-bunch://open?bunch=Comms'

# Shortcut URL
open 'x-bunch://Comms'
```

Example 3 (sass):
```sass
# Full URL
open 'x-bunch://close?bunch=Comms'

# Shortcut URL
open 'x-bunch://close/Comms'
```

Example 4 (sass):
```sass
# Full URL
open 'x-bunch://toggle?bunch=Comms'

# Shortcut URL
open 'x-bunch://toggle/Comms'
```

---

## Hammerspoon - Bunch.app

**URL:** https://bunchapp.co/docs/integration/hammerspoon

**Contents:**
- Integrating with Hammerspoon
    - See Also:

Hammerspoon is a powerful automation utility that includes menu interaction and window management capabilities.

You can bind Hamerspoon actions to its URL handler:

This creates a url handler hammerspoon://someAlert. You can simply put that URL on a line in a Bunch to launch that action.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (r):
```r
hs.urlevent.bind("someAlert", function(eventName, params)
    hs.alert.show("Received someAlert")
end)
```

---

## Using Sudo - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/sudo/

**Contents:**
- Running Privileged Tasks (sudo)
- Adding a Password to Your Keychain
- Scripting Keychain
- Passwords and Frontmatter
  - Inline Variable Assignment
  - Better Password Masking
    - See Also:

You can securely store and access passwords, including root passwords, by using built-in macOS tools. Using these tools makes it possible to run privileged tasks within a Bunch without having to hard code your passwords in plain text.

You can make use of Bunch’s scripting features and the macOS Keychain to enable secure use of sudo in your scripts, as well as securely store and access passwords for other purposes.

The first step is to create a Keychain entry for the password you want to use. In this case, this will be your system password.

Open Keychain Access in /Applications/Utilities. Unlock your login keychain if needed, then click the “Create new” button in the toolbar. Give the item a unique name, any account name you want, and then enter the password and click “Add.”

Note that you can right click on the login toolchain in the left sidebar and use Change Settings… to tell it how long to remain unlocked after entering your password. If your machine is private and you want it to remain unlocked for as long as you’re logged in, disable “Lock after…” and enable “Lock when sleeping.”

Now this password entry can be accessed using the command line tool security, which we can use in a script. If the keychain is unlocked, the password will be retrieved without interaction. If it’s locked, you’ll be asked to enter your keychain password before access is granted.

The first and simplest option is just to put all of the sudo commands you need in one script and call the security tool at the top. You can then echo the retrieved password to sudo -S, which tells sudo to read the password from the command line.

We’ll call security and give it the name you assigned to the keychain item (-l), and the account name (-a). -w tells it to return only the password.

The first time security is used from a script, you’ll get a prompt to allow access. Be sure to click “Always Allow” to avoid getting the same prompt every time.

If you want to make the password available to multiple scripts with one call, or want to gather multiple passwords at once for different scripts, you can use frontmatter to store them.

Create a script to retrieve the password and return it formatted as a frontmatter key we can use in our Bunch.

(Repeat the above as many times as needed to get multiple passwords, storing them as unique variables.)

In the Bunch, we’ll set the script to load the result as frontmatter using from script:

Now, when the Bunch is opened, it will get the password(s) from the script, asking us to unlock the keychain if needed, then assign it to the variable password, which we can then use in a Script Item. We’re redirecting STDERR output just to keep the password prompt from showing up in our script output.

The following Bunch disables automatic Time Machine backup when it opens, and re-enables it when it closes. We’re also running tmutil stopbackup to gracefully terminate any currently-running backups, which doesn’t require privileged access.

Rather than using from script and outputting YAML-formatted keys, you can also just run a single command and immediately assign it to a variable. If you’re only getting one password, this would make sense.

Following the above procedure does have the downside of showing your password in the command title when it’s listed under Running Scripts (and in the Task Monitor). An alternative is to wrap the command in a second shell script.

As mentioned at the top, if there’s only one script being run, it’s probably easiest to just include the security call in the script itself. But if you want to use frontmatter, all frontmatter keys/values are passed to the environment of every script the Bunch runs. You can access the password variable using $password (in Bash, Zsh, etc.) or whatever method the script’s shell uses to access environment variables.

Now the “Running Scripts” title will just read timemachine.sh ... in the menu and the Task Monitor.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (bash):
```bash
#!/bin/bash

PASS=$(security find-generic-password -l "bunch password" -a bunch -w|tr -d '\n')

echo "$PASS" | sudo -S [your privileged command]
```

Example 2 (bash):
```bash
#!/bin/bash

 PASS=$(security find-generic-password -l "bunch password" -a bunch -w|tr -d '\n')

 echo "password: $PASS"
```

Example 3 (yaml):
```yaml
---
 title: My sudo Bunch
 from script: password.sh
 ---
```

Example 4 (yaml):
```yaml
---
title: My Time Machine Bunch
from script: password.sh
---
# pass our password to sudo on STDIN
$ echo "${password}" | sudo -S tmutil disable 2>/dev/null
# stopbackup doesn't require root privileges
$ tmutil stopbackup

# Reverse on close with !$
!$ echo "${password}" | sudo -S tmutil enable 2>/dev/null
```

---

## AppleScript Dictionary - Bunch.app

**URL:** https://bunchapp.co/docs/integration/applescript/

**Contents:**
- The Bunch AppleScript Dictionary
- List all Bunches
- Open, close, and toggle Bunches
- Acting on tagged Bunches
- Process raw Bunch text
- Snippets, fragments, and variables
- Preferences
- Refresh Browsers
- New Bunch with Open Apps
    - See Also:

Bunch provides an AppleScript dictionary that you can use to open, close, and toggle Bunches, process raw text, or access snippets.

The following commands return AppleScript lists:

You can test if a particular Bunch is open by searching for its name in list open bunches (e.g. if (list open bunches) contains). You can also get a list of closed bunches by getting the full list (list bunches) and removing items in list open bunches. It’s not the easiest approach, I know, but I haven’t had a need for these options yet, so I haven’t added methods for them.

You can also act on tagged Bunches

You can also process raw Bunch text:

Tip: Use \n in the string to add newlines, useful for adding dashed parameters/variables when calling scripts or snippets.

Tip: raw text processing is also useful in scripts where you want to read in the contents of a Bunch, modify them in some way, then execute the result. It won’t mark that Bunch as “open” when it executes, but it’s one way to add dynamic processing.

You can access snippets directly with options to target fragments and pass variables.

The with variables parameter accepts a string of text formatted like a URL query string, with key=value pairs separated by ampersands (&). If your value needs to include an actual ampersand, url encode it as %26 in the query string.

You can retrieve several of Bunch’s preferences using AppleScript, which avoids the need to use defaults in shell scripts.

All values are returned as text. Boolean values (which is everything other than “Bunch Folder” and “Debug Level”) will return text containing either “0” (false) or “1” (true). Debug Level returns text containing a number between 0 (errors only) and 4 (debug messages).

When returning a preference, Bunch just looks for keywords. As long as the text given to get preference includes one of the following words, it will return the associated preference:

If your Bunches make use of the display command to create single site browsers, you can reload their contents via AppleScript. This takes effect on all browsers opened by a Bunch, or you can affect all open browsers. You can’t currently target a specific browser window.

To refresh every open browser:

To refresh only browsers opened by a specific bunch:

The bunch name is case insensitive and the best match will be targeted.

The “New Bunch with Open Apps” command is available to AppleScript as [copy/save] new bunch with running apps. This takes an optional named parameter to define the title and filename of the new Bunch. If this is left off, the Bunch receives no title frontmatter and the file is named “New Bunch.bunch”. If a file with the given name exists, a number will be appended to it and incremented until the filename is unique.

You can also add an ignoring parameter, which accepts a list of application names to exclude from the Bunch. These names must match the app names exactly, including capitalization.

To save a new Bunch with all running apps as “Working.bunch”:

To copy all apps to the clipboard, ready to paste into a new Bunch:

To save a new Bunch named “Working,” excluding iTerm and Firefox:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
-- list all Bunches in current Bunch Folder
tell application "Bunch" to list bunches

-- list currently open Bunches
tell application "Bunch" to list open bunches
```

Example 2 (julia):
```julia
tell application "Bunch" to open bunch "Comms"

tell application "Bunch"
    close bunch "Default"
    toggle bunch "Comms"
end tell
```

Example 3 (sass):
```sass
-- list bunches containing tag string
tell application "Bunch" to list bunches tagged "tag1+tag2"

-- perform actions on all Bunches matching tag (or tag combo)
tell application "Bunch"
    open tag "Tag1"
    close tag "Tag2+Tag3"
    toggle tag "Tag2,Tag3"
end tell
```

Example 4 (julia):
```julia
tell application "Bunch"
    process text "(dnd on)"
end tell
```

---

## Stream Deck - Bunch.app

**URL:** https://bunchapp.co/docs/integration/stream-deck

**Contents:**
- Bunch and the Elgato Stream Deck
    - See Also:

You can add buttons to your Elgato Stream Deck for opening, closing, and toggling Bunches. I detailed this on my blog.

The easiest method is just to use an “Open Website” action for a button, then call Bunch’s URL handler as the URL. This can be as simple as x-bunch://toggle/Bunch%20Name.

You can also integrate further using Keyboard Maestro. Create Keyboard Maestro macros to execute one or more Bunch URLs or AppleScripts, and then assign them to buttons on the Stream Deck. There are two plugins available to make this easy.

First, the KM Link plugin for Stream Deck allows you to select from existing macros and assign them to the button. It’s probably the easiest to use.

Second, the official Keyboard Maestro plugin from Elgato is available in the plugins library. With this one, a virtual button code is assigned to each button based on its coordinates on the panel. You can then add a device button trigger to a macro in KM and hit that button to assign it. I recommend manually assigning a number for row and column so that if you move the button later, it doesn’t change which macro it triggers.

All materials copyright © Brett Terpstra 2021

---

## Advanced Scripting - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/index/

**Contents:**
- Advanced Scripting Examples
- Section Contents
    - See Also:

These are just some examples of things you can do with external scripting and Bunch. Most are a bit silly, and are intended to serve as demonstrations for your own exploration.

All materials copyright © Brett Terpstra 2021

---

## Forklift - Bunch.app

**URL:** https://bunchapp.co/docs/integration/forklift/

**Contents:**
- Bunch and Forklift
    - See Also:

I prefer Forklift to Finder for file management. It’s far more pleasant than trying to open the right folders in Finder tabs, it gives me a 2-pane view, and it has great integration with FTP, S3, and other network protocols.

It doesn’t have a great AppleScript dictionary, though, and automating the opening of tabs and panes isn’t possible. However, you can create Saved Workspaces (Favorites -> Save Workspace), with all of the tabs and panes set up just the way you like them, then assign the favorite a keyboard shortcut in Preferences->Shortcuts. Then you can have Bunch send a key combo to it after it launches to get things just the way you like them.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
%Forklift   // Focus Forklift, open if needed
- {^$~p}    // Send control-shift-option-P
```

---

## Hammerspoon - Bunch.app

**URL:** https://bunchapp.co/docs/integration/hammerspoon/

**Contents:**
- Integrating with Hammerspoon
    - See Also:

Hammerspoon is a powerful automation utility that includes menu interaction and window management capabilities.

You can bind Hamerspoon actions to its URL handler:

This creates a url handler hammerspoon://someAlert. You can simply put that URL on a line in a Bunch to launch that action.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (r):
```r
hs.urlevent.bind("someAlert", function(eventName, params)
    hs.alert.show("Received someAlert")
end)
```

---

## AppleScript Dictionary - Bunch.app

**URL:** https://bunchapp.co/docs/integration/applescript

**Contents:**
- The Bunch AppleScript Dictionary
- List all Bunches
- Open, close, and toggle Bunches
- Acting on tagged Bunches
- Process raw Bunch text
- Snippets, fragments, and variables
- Preferences
- Refresh Browsers
- New Bunch with Open Apps
    - See Also:

Bunch provides an AppleScript dictionary that you can use to open, close, and toggle Bunches, process raw text, or access snippets.

The following commands return AppleScript lists:

You can test if a particular Bunch is open by searching for its name in list open bunches (e.g. if (list open bunches) contains). You can also get a list of closed bunches by getting the full list (list bunches) and removing items in list open bunches. It’s not the easiest approach, I know, but I haven’t had a need for these options yet, so I haven’t added methods for them.

You can also act on tagged Bunches

You can also process raw Bunch text:

Tip: Use \n in the string to add newlines, useful for adding dashed parameters/variables when calling scripts or snippets.

Tip: raw text processing is also useful in scripts where you want to read in the contents of a Bunch, modify them in some way, then execute the result. It won’t mark that Bunch as “open” when it executes, but it’s one way to add dynamic processing.

You can access snippets directly with options to target fragments and pass variables.

The with variables parameter accepts a string of text formatted like a URL query string, with key=value pairs separated by ampersands (&). If your value needs to include an actual ampersand, url encode it as %26 in the query string.

You can retrieve several of Bunch’s preferences using AppleScript, which avoids the need to use defaults in shell scripts.

All values are returned as text. Boolean values (which is everything other than “Bunch Folder” and “Debug Level”) will return text containing either “0” (false) or “1” (true). Debug Level returns text containing a number between 0 (errors only) and 4 (debug messages).

When returning a preference, Bunch just looks for keywords. As long as the text given to get preference includes one of the following words, it will return the associated preference:

If your Bunches make use of the display command to create single site browsers, you can reload their contents via AppleScript. This takes effect on all browsers opened by a Bunch, or you can affect all open browsers. You can’t currently target a specific browser window.

To refresh every open browser:

To refresh only browsers opened by a specific bunch:

The bunch name is case insensitive and the best match will be targeted.

The “New Bunch with Open Apps” command is available to AppleScript as [copy/save] new bunch with running apps. This takes an optional named parameter to define the title and filename of the new Bunch. If this is left off, the Bunch receives no title frontmatter and the file is named “New Bunch.bunch”. If a file with the given name exists, a number will be appended to it and incremented until the filename is unique.

You can also add an ignoring parameter, which accepts a list of application names to exclude from the Bunch. These names must match the app names exactly, including capitalization.

To save a new Bunch with all running apps as “Working.bunch”:

To copy all apps to the clipboard, ready to paste into a new Bunch:

To save a new Bunch named “Working,” excluding iTerm and Firefox:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (unknown):
```unknown
-- list all Bunches in current Bunch Folder
tell application "Bunch" to list bunches

-- list currently open Bunches
tell application "Bunch" to list open bunches
```

Example 2 (julia):
```julia
tell application "Bunch" to open bunch "Comms"

tell application "Bunch"
    close bunch "Default"
    toggle bunch "Comms"
end tell
```

Example 3 (sass):
```sass
-- list bunches containing tag string
tell application "Bunch" to list bunches tagged "tag1+tag2"

-- perform actions on all Bunches matching tag (or tag combo)
tell application "Bunch"
    open tag "Tag1"
    close tag "Tag2+Tag3"
    toggle tag "Tag2,Tag3"
end tell
```

Example 4 (julia):
```julia
tell application "Bunch"
    process text "(dnd on)"
end tell
```

---

## Hazel - Bunch.app

**URL:** https://bunchapp.co/docs/integration/hazel/

**Contents:**
- Bunch and Hazel
    - See Also:

Hazel is an amazing tool that watches for file changes on your Mac and acts on them. That’s simplifying it, but it’s the gist.

You can integrate Bunch with Hazel using shell scripts and the Bunch URL handler. By integrating variables into a Bunch, you can have Hazel pass the path to a specific file when opening the Bunch.

Let’s say you’re watching a Dropbox folder for new audio files. When a new file arrives, you want to open it in your audio editor, along with your Audio Editing Bunch that sets up everything else you need. The Bunch would include a line pointing your audio editor to a variable:

The rule in Hazel would use a Run shell script action on files matching whatever criteria you need. In the shell script, you would set it to /bin/bash and include the following:

The first line is just to URL encode the file path to make it work in a URL. Then it calls Bunch’s URL handler with the open method (which will work even if the Bunch is already open). The Audio Editing Bunch will load, and when it launches Fission, it will open the new file immediately.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
Fission
- ${audiofile}
```

Example 2 (sass):
```sass
FILE=$(echo "$1" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg')

open "x-bunch://open/?bunch=Audio%20Editing&audiofile=$FILE"
```

---

## BetterTouchTool - Bunch.app

**URL:** https://bunchapp.co/docs/integration/bettertouchtool/

**Contents:**
- Integrating with BetterTouchTool
- Triggering BetterTouchTool from Bunch
- Triggering Bunch from BetterTouchTool
    - See Also:

BetterTouchTool is an amazing automation utility for building actions for your trackpad, keyboard, touch bar, and more. It’s available via Setapp and as a standalone purchase. It also happens to have a fully-fledged url scheme that can be used to trigger actions, save and set variables, and even things like updating text in your touch bar or displaying webviews and HUDs.

Possibilities include adding mouse movement and click actions to your Bunches, positioning and sizing windows, controlling music players, connecting/disconnecting Bluetooth devices, modifying system settings that Bunch doesn’t handle, and more, all without having to write scripts (although scripting is also an option).

See the BetterTouchTool URL handler documentation to see what’s possible. When you’re ready to trigger an action from your Bunch, it’s as easy as dropping a URL into your Bunch file.

You can click any action and choose “Copy Link to Activate Trigger” to get a URL ready to paste directly into your Bunch. It will look like:

To trigger a named trigger:

You can also control BetterTouchTool with its extensive AppleScript library, if you prefer. Just be sure to enable external scripting in Preferences->General.

You can also use BetterTouchTool to add system tools that trigger Bunches outside of the Bunch menu. Whether it’s assigning a Bunch trigger to a gesture, or adding Touch Bar icons for Bunches to your MacBook Pro, BetterTouchTool makes it easy.

Just add the type of trigger you want, then assign an Execute Shell Script action to it, using open '[BUNCH URL]', using the Bunch URL handler to act on the desired Bunch. (Using the Execute Shell Script action instead of Open URL prevents BetterTouchTool from first opening your default browser.)

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
btt://execute_assigned_actions_for_trigger/?uuid=4D05E320-E682-411A-81A5-BD9B82DD8B4D
```

Example 2 (sass):
```sass
btt://trigger_named/?trigger_name=TriggerName
```

---

## Stream Deck - Bunch.app

**URL:** https://bunchapp.co/docs/integration/stream-deck/

**Contents:**
- Bunch and the Elgato Stream Deck
    - See Also:

You can add buttons to your Elgato Stream Deck for opening, closing, and toggling Bunches. I detailed this on my blog.

The easiest method is just to use an “Open Website” action for a button, then call Bunch’s URL handler as the URL. This can be as simple as x-bunch://toggle/Bunch%20Name.

You can also integrate further using Keyboard Maestro. Create Keyboard Maestro macros to execute one or more Bunch URLs or AppleScripts, and then assign them to buttons on the Stream Deck. There are two plugins available to make this easy.

First, the KM Link plugin for Stream Deck allows you to select from existing macros and assign them to the button. It’s probably the easiest to use.

Second, the official Keyboard Maestro plugin from Elgato is available in the plugins library. With this one, a virtual button code is assigned to each button based on its coordinates on the panel. You can then add a device button trigger to a macro in KM and hit that button to assign it. I recommend manually assigning a number for row and column so that if you move the button later, it doesn’t change which macro it triggers.

All materials copyright © Brett Terpstra 2021

---

## Advanced Scripting - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting

**Contents:**
- Advanced Scripting Examples
- Section Contents
    - See Also:

These are just some examples of things you can do with external scripting and Bunch. Most are a bit silly, and are intended to serve as demonstrations for your own exploration.

All materials copyright © Brett Terpstra 2021

---

## More Tools - Bunch.app

**URL:** https://bunchapp.co/docs/integration/more-tools/

**Contents:**
  - HazeOver
    - See Also:

Similar to Bunch’s (screen) command, HazeOver is a handy little app that “hazes over” everything but the current foreground application. It’s great for reducing distractions, and can be a handy tool for some of your contexts. Integrating it into a Bunch is as simple as:

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (markdown):
```markdown
* tell app "HazeOver" to set enabled to true
* tell app "HazeOver" to set color to "111111"
* tell app "HazeOver" to set intensity to 90
```

---

## Keyboard Maestro - Bunch.app

**URL:** https://bunchapp.co/docs/integration/keyboard-maestro

**Contents:**
- Integrating with Keyboard Maestro
    - See Also:

Keyboard Maestro is a powerful Mac automation tool. You can integrate it with Bunch in two directions.

You can call any Bunch from Keyboard Maestro using AppleScript in a Run AppleScript action, or the Bunch URL handler in an Open URL action. This allows full control of Bunch, including the ability to run raw text as snippets after Keyboard Maestro has performed any alterations on it.

Keyboard Maestro macros and variables can also be controlled by AppleScript, Automator, or keyboardmaestro:// URLs. These can easily be integrated into a Bunch using Bunch’s ability to run AppleScripts, Automator Workflows, or open URLs.

All materials copyright © Brett Terpstra 2021

---

## Secure Input - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/secure-input/

**Contents:**
- Adding a Secure User Input Dialog
- Secure Input Using AppleScript
    - See Also:

Bunch allows you to get text input for a script, but it doesn’t have secure text entry. Here’s an example that allows you to use AppleScript’s display dialog with hidden answer to handle this.

Also see Using Sudo for another option.

You can use the from script frontmatter to implement a password dialog that can be passed on to your scripts. This could, for example, allow you to automate unlocking a keychain and getting a secure password for a scripted curl call. It also serves as an example of just getting interactive input for a script and could be applied to select dialogs, file select dialogs, and more.

Create a script that uses AppleScript to show a dialog. This can be done in an actual AppleScript, or in a shell script that calls osascript. Here’s a ruby example:

This displays a secure input dialog (secure in that the input is hidden) and returns the response formatted as YAML.

Save the script in your Bunch folder as mypasswordscript.rb. Make the script executable (chmod a+x mypasswordscript.rb) and you can call it from a Bunch’s frontmatter:

When the Bunch is opened, the result of the above script will be read in and appended to the Bunch’s frontmatter.

Now you can use the ${password} variable as either an argument or an environment variable in a snippet. Here’s a Bunch with an embedded snippet and appropriate frontmatter:

This calls an embedded snippet containing two variables. The variables will be populated by the frontmatter we generated in the Ruby script.

The snippet calls another shell script with a command line argument containing user:password.

When this Bunch is opened, the Ruby script runs and the password dialog is shown. The result gets added to the frontmatter, which then populates the variables in the snippet.

This is, of course, a fairly silly example, as you could simply add the password request into a script and have it execute something using the password in one line, as opposed to the roundabout method of passing data to the frontmatter through one script and then calling a second script in a snippet. Hopefully it illustrates some possibilities, though.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (scala):
```scala
#!/usr/bin/env ruby
 require 'yaml'
	
 password = %x{osascript <<'APPLESCRIPT'
   return text returned of (display dialog "Enter password" default answer "" buttons {"Cancel", "OK"} default button 2 with hidden answer)
 APPLESCRIPT}.strip
	
 puts YAML.dump({'password' => password})
```

Example 2 (sql):
```sql
---
 from script: mypasswordscript.rb
 ---
```

Example 3 (sass):
```sass
---
 from script: mypasswordscript.rb
 ---

 <<#Password Protected
 - user=ttscoff

 ___

 ---[Password Protected]
 $ mycoolscript.sh ${user}:${password}
```

---

## Task Managers - Bunch.app

**URL:** https://bunchapp.co/docs/integration/task-manager/

**Contents:**
- Using Bunch With Your Task Manager
    - See Also:

You can use Bunch’s URL scheme with any app that allows clickable links. Whether you use TaskPaper, Things, OmniFocus, or something else, this means you can add a link to any to-do item that launches relevant applications.

When you call a Bunch URL, you can pass frontmatter keys to it that populate variables in your Bunches. This means that two links to the same Bunch can do different things, just by changing the parameters. You can pass a filename, a project name, etc., and have the Bunch customized for that particular to-do item.

Here’s an example. You have an Audio Editing Bunch that you use when new audio files appear in your Dropbox. It loads your editor, but you need a different file every time. Your Bunch could be set up like this:

If you load this Bunch normally, it will open Fission, it just won’t open a specific file. But if the audiofile gets assigned, Fission can open the appropriate file immediately. When calling the Bunch from the URL handler, just add &audiofile=/path/to/your audio file.mp3 to the URL:

With a little Hazel scripting, you can have an inbox folder in Dropbox watch for new files, and when they appear, a to-do item gets added to your task manager with a link to open that specific file in your audio editor.

You could also skip the task manager and have Hazel open the Bunch immediately, passing the new filename as a parameter.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: Audio Editing
---
Fission
- ${audiofile}
```

Example 2 (sass):
```sass
x-bunch://open?bunch=Audio%20Editing&audiofile=~/Dropbox/Inbox/new%20audio.mp3
```

---

## URL Handler - Bunch.app

**URL:** https://bunchapp.co/docs/integration/url-handler/

**Contents:**
- The Bunch URL Handler
- Quick Reference
- x-callback-url
- Methods
  - open
  - close
  - toggle
  - edit
  - raw
  - refresh

Bunch has its own URL scheme (x-bunch:) that you can call from other apps and scripts.

Beta testers: Bunch Beta can be targeted with x-bunch-beta if you have both installed and need to make sure your URLs open in the right version.

Tip: You can use URLs with apps like BetterTouchTool and Keyboard Maestro to assign Bunch actions to hotkeys, buttons and other triggers. If you have a cool programmable keypad or a Stream Deck, just imagine the possibilities…

Just create an action that opens a URL and use something like:

x-bunch://toggle/BunchName

to create a hotkey or button that toggles a Bunch. You can create a whole launch control panel on a Stream Deck with these, for example.

Tip: The Bunch CLI can generate URLs that run various commands for use in other applications. Run bunch -i to interactively build a URL.

All methods can be called in x-callback-url format, for compatibility. Simply prefix x-callback-url in the path, and optionally provide an x-source query parameter. If an x-source is provided and no x-success value is present, the x-source (URL, app name, or bundle identifier) will be called upon completion. (It’s assumed that you want focus returned after executing a Bunch command, as making Bunch a foreground app is relatively pointless.)

See the x-success parameter to control what happens after a URL method is executed.

The full version of the open method is x-bunch://open?bunch=[BUNCH NAME]. The url can be shortened, though, to just the Bunch name: x-bunch://[BUNCH NAME].

Specify multiple Bunches to open by separating the names with commas, e.g. x-bunch://open?bunch=Bunch%201,Bunch%202. This works with any of the actions that act on Bunches (open, toggle, close). It also works when using “path” syntax, e.g. x-bunch://toggle/Bunch%201,Bunch%202.

The Bunch name in the URL handler is case insensitive, so “bunch name” works just as well as “Bunch Name.” Bunch does need to already be running in order to execute a bunch via the URL handler. You can always launch Bunch with open -a Bunch from a script, but you’ll need to give it enough time to initialize.

Tip: If you have a task in a task manager that requires a certain set of apps, create a Bunch and then add a link to the task’s notes: x-bunch://open/WorkBunch

You can also close a Bunch with x-bunch://close?bunch=[BUNCH NAME], or just x-bunch://close/[BUNCH NAME].

You can also toggle the Bunch — opening if it’s closed, closing if it’s open — using x-bunch://toggle?bunch=[BUNCH NAME]. Like the other methods, this also works as x-bunch://toggle/[BUNCH NAME]. This works even if “Toggle Bunches” isn’t enabled.

If using the “Toggle Bunches” option, Bunches opened/closed via the URL handler will automatically set the launched state of the Bunch in the Dock menu. The open and close commands will not toggle Bunches; those commands will execute regardless of current Bunch state.

The full version of the edit method is x-bunch://edit?bunch=[BUNCH NAME]. The url can be shortened to path format: x-bunch://edit/[BUNCH NAME].

The Bunch Editor must be set in Preferences for this command to execute. If it’s not, an alert will be displayed. {.warning}

You can pass Bunch commands and directives directly through the URL handler. With this you can specify a path to a Bunch file outside of your Bunch folder, or even pass a url-encoded string containing Bunch directives.

If you pass a Bunch file using this method, the Bunch isn’t technically “opened,” i.e. it won’t appear as toggled “on” in the menu when Toggle Bunches is enabled. This provides one way to open a Bunch without affecting its state.

Only one of file or txt should be specified

Force Bunch to reload Bunch files. This should happen automatically if you make changes to the Bunch folder while Bunch is running, but use this if you want to ensure an update.

Reveal the Bunch Folder in Finder.

You can set and toggle certain preferences with the setPref method. All boolean parameters accept 0 and 1, as well as “true” or “false”, or “yes” or “no”.

Tip: You can use this URL handler to easily switch between sets of Bunches using external tools. For example, you could add a button to your Touch Bar using BetterTouchTool to trigger a URL like x-bunch://setPref?configDir=~/Dropbox/Sync/WorkBunches, or create a Keyboard Maestro macro that toggled between two folders.

You can directly load a snippet and define variables with the snippet method. This allows you to load files containing variables and to use the snippet fragment feature to load just a portion of a snippet.

A Bunch can also be called as a snippet, and if it contains fragment identifiers, a smaller section of the Bunch can be loaded using the snippet method.

This URL method can be shortened to snippet/SNIPPET_FILE/FRAGMENT?variables=foobar.

Fragment ID can also be added to the filename with a hash (#FRAGMENT) but it should be percent-encoded in the URL as %23, e.g. snippet/SNIPPET_FILE%23FRAGMENT.

Cause Bunch to display the Preferences dialog.

All url methods accept an x-success parameter which can define a bundle ID or url to open after executing the method. By default this happens after a 1-second delay, but you can modify that with an x-delay parameter (number of seconds as integer).

With the open and toggle commands you can pass additional, arbitrary query parameters to set frontmatter keys. Simply append key/value pairs when calling:

This can be used to populate variables in the Bunch and its snippets at the time you call the url handler. For example, if you have a Bunch that contains an embedded snippet with a variable launch:

Then normally that Bunch would launch Safari when it opens, as that’s the default value set in the snippet when launch is undefined. If you call it with a value specified in the url handler, though, you can replace the default value:

Opening this URL will launch TextEdit instead of Safari. Variables defined in the query string override keys hard coded in the Bunch frontmatter. Variables defined on-the-fly by from script or from file frontmatter will still override query parameters.

All methods that accept a bunch parameter can instead receive a tag parameter to operate on all Bunches matching a tag or tag combination. Multiple tags can be combined using a comma (,) for OR, or a plus sign (+) for AND.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
x-bunch://x-callback-url/open?bunch=Comms&x-source=com.googlecode.iterm2
```

Example 2 (sass):
```sass
# Full URL
open 'x-bunch://open?bunch=Comms'

# Shortcut URL
open 'x-bunch://Comms'
```

Example 3 (sass):
```sass
# Full URL
open 'x-bunch://close?bunch=Comms'

# Shortcut URL
open 'x-bunch://close/Comms'
```

Example 4 (sass):
```sass
# Full URL
open 'x-bunch://toggle?bunch=Comms'

# Shortcut URL
open 'x-bunch://toggle/Comms'
```

---

## Keyboard Maestro - Bunch.app

**URL:** https://bunchapp.co/docs/integration/keyboard-maestro/

**Contents:**
- Integrating with Keyboard Maestro
    - See Also:

Keyboard Maestro is a powerful Mac automation tool. You can integrate it with Bunch in two directions.

You can call any Bunch from Keyboard Maestro using AppleScript in a Run AppleScript action, or the Bunch URL handler in an Open URL action. This allows full control of Bunch, including the ability to run raw text as snippets after Keyboard Maestro has performed any alterations on it.

Keyboard Maestro macros and variables can also be controlled by AppleScript, Automator, or keyboardmaestro:// URLs. These can easily be integrated into a Bunch using Bunch’s ability to run AppleScripts, Automator Workflows, or open URLs.

All materials copyright © Brett Terpstra 2021

---

## Focus Modes - Bunch.app

**URL:** https://bunchapp.co/docs/integration/focus-modes/

**Contents:**
- macOS Focus Modes
    - See Also:

One Bunch feature request I’ve received a few times is support for macOS Monterey’s Focus Modes. Bunch does a good job with enabling and disabling Do Not Disturb on previous operating systems, but the process is a hack that involves nested settings in PLIST data and toggling system daemons. I don’t love that I have to do that, but Apple provides no API for such settings. And I haven’t found a way (yet) to extend that hack to work with Focus Modes. So here’s the solution I’m using.

You can turn Focus Modes on and off using Shortcuts. Create two shortcuts for each focus mode you want to control from Bunch, one for turning on, and one for turning off. Then, in a Bunch, you can use the (shortcut) command to run (shortcut SHORTCUT_ON_NAME) (replacing SHORTCUT_ON_NAME with the name of the shortcut that turns the focus mode on), and !(shorcut SHORTCUT_OFF_NAME). The combination of these two will turn the focus mode on when the Bunch opens, and off when it closes. You can, of course, reverse these as needed.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (yaml):
```yaml
---
title: Work
---

(shortcut Work Mode On)
!(shortcut Work Mode Off)
```

---

## Debugging Scripts - Bunch.app

**URL:** https://bunchapp.co/docs/integration/advanced-scripting/debugging/

**Contents:**
- Debugging Scripts Run By Bunch
    - See Also:

STDOUT and STDERR from scripts run by Bunch are reported in the Bunch Log, if your Log Level is set to Debug (Help -> Set Log Level).

If your script is returning an exit code other than 0 and there’s content in STDERR, the script will produce an error in the log. All pertinent error messages will be shown.

You can use the log output to see variables and debugging statements by simply printing/echoing them to STDOUT/STDERR from your script. As long as your script returns a 0 exit code, printing to STDERR won’t interrupt Bunch’s execution of the script.

Several environment variables are sent to any script run by Bunch. You can see this in the log by having your script execute /usr/bin/env. The output will go to STDOUT and be visible in the log.

All materials copyright © Brett Terpstra 2021

**Examples:**

Example 1 (sass):
```sass
2021-02-04 07:30:28: ⚪[shell scripts] /usr/bin/env STDOUT:
SHELL=/usr/local/bin/fish
COMMAND_MODE=unix2003
HOME=/Users/ttscoff
TMPDIR=/var/folders/q7/sps8n5_534q22bx1ts4xjjl00000gn/T/
BUNCH_DIR=file:///Users/ttscoff/Dropbox/Sync/Bunches/Testing/
NSUnbufferedIO=YES
PATH=/Developer/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
BUNCH_DESKTOP_ICONS=0
USER=ttscoff
BUNCH=shell scripts
LOGNAME=ttscoff
BUNCH_DOCK=1
title=Shell Scripts
BUNCH_DND=0
```

---

## IDE Packages - Bunch.app

**URL:** https://bunchapp.co/docs/integration/ide-packages/

**Contents:**
- IDE Packages
- Sublime Text
- TextMate
- Visual Studio Code
- Atom
- Contributions Welcome
    - See Also:

A Sublime Text package for Bunch is available.

The package is hosted on GitHub, but is most easily installed using Package Control. Open the command palette, run Package Control: Install Package, and search for “Bunch.”

Kotfu created a TextMate bundle which includes:

Kotfu also created a Bunch extension for Visual Studio Code which is available in the Visual Studio Code Marketplace. When you open a bunch file in Visual Studio Code you will be prompted you to install the extension. To install the extension manually:

Visual Studio Code will keep the extension updated as new versions are released.

This extension includes:

The source code is available on GitHub.

This package includes:

The source code is available on GitHub.

If you’d like to add support for Bunch files to your favorite editor or IDE, your contribution would be greatly appreciated.

All materials copyright © Brett Terpstra 2021

---
