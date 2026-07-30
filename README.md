# safari-profile

English | [日本語](README.ja.md)

A CLI tool to switch between Safari profile windows with a single command.

- If a window for the given profile is **already open, it is brought to the front** (restored if minimized)
- If not, **a new profile window is created** (by clicking "File > New Window > New ◯◯ Window" automatically)

Safari's AppleScript support has no profile API yet, so this tool relies on the window title format (`Profile Name — Page Title`) and menu automation. Menu items are matched by profile name rather than by localized title, so it works in any UI language.

## Requirements

- macOS Sonoma or later / Safari 17 or later (profile support)
- At least one profile created in Safari (Safari > Settings > Profiles)

## Installation

```bash
# Clone this repository.
cd safari-profile
./install.sh
```

The script is installed to `~/.local/bin/safari-profile`. If that directory is not in your PATH, `install.sh` prints instructions. To install elsewhere, run `INSTALL_DIR=/usr/local/bin ./install.sh`.

## Usage

```bash
safari-profile Work      # switch to the Work profile (create if none exists)
safari-profile Personal  # default profile (個人用 on Japanese systems)
```

The profile name argument must match the name shown in Safari's "File > New Window" submenu (the ◯◯ part of "New **◯◯** Window").

### Required permissions

On first run you will be asked for the following (once per calling app):

- **Automation**: control of "Safari" and "System Events" → allow
- **Accessibility**: required for clicking menu items → enable the calling app (Terminal, Alfred, etc.) in System Settings > Privacy & Security > Accessibility

## Registering in Shortcuts.app with a keyboard shortcut

This lets you switch profiles with a single keystroke from any app.

1. Create a new shortcut in Shortcuts.app
2. Add the "**Run Shell Script**" action
   - If the action is missing: Shortcuts Settings > Advanced > enable "**Allow Running Scripts**"
3. Enter the script with a full path:

   ```bash
   $HOME/.local/bin/safari-profile Work
   ```

4. In the ⓘ (details) panel, assign a "**Keyboard Shortcut**"
5. Duplicate the shortcut for each profile (e.g. "Safari Work", "Safari Personal")

### Accessibility permission (important)

When run via Shortcuts.app, the executing process is `osascript`, so the first run fails with
`osascript is not allowed assistive access. (-1719)`. Fix it as follows:

1. Open System Settings > Privacy & Security > **Accessibility**
2. Click "+", press **⌘⇧G** in the file dialog, type `/usr/bin/osascript`, and add it
3. Turn on the toggle for **osascript**

### Choosing a keyboard shortcut

Menu shortcuts of the frontmost app take precedence over global shortcuts. Safari in particular **uses almost every W-key combination** (⌘W / ⇧⌘W / ⌥⌘W / ⇧⌥⌘W / ⌃⌘W are all taken; ⌃⌘W is "Delete Tab Group").

**⌃⌥⌘ + letter** (e.g. Work → `⌃⌥⌘W`, Personal → `⌃⌥⌘P`) rarely conflicts with standard app menus and is recommended.

Note that the Shortcuts app does not need to be running for keyboard shortcuts to fire (a system background process handles them). You can also run shortcuts by name from Spotlight.

## Limitations

- Relies on window titles starting with `Profile Name — ` (verified on Safari 17–26); a future Safari change could break this
- Private Browsing windows are not supported
- Creating a new window clicks Safari's File menu via UI scripting, so Accessibility permission is required

## License

MIT
