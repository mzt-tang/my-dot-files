# Claude Code Config

Personal Claude Code configuration. Copy to `~/.claude/` on a new machine.

## Quick Setup

```bash
# Copy files
cp CLAUDE.md ~/.claude/CLAUDE.md
cp settings.json ~/.claude/settings.json
mkdir -p ~/.claude/hooks && cp hooks/protect_files.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/protect_files.sh
```

## What's Included

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Global preferences: communication style, ADHD-friendly writing, approach, CodeGraph |
| `settings.json` | Permissions, hooks, plugins, model preference |
| `hooks/protect_files.sh` | Blocks edits to .env, lock files, credentials, db/structure.sql |

## Platform Notes

### macOS (work)

Add notification hooks to `settings.json` - these use `osascript` which is macOS-only:

```json
"Notification": [
  {
    "matcher": "",
    "hooks": [
      {
        "type": "command",
        "command": "osascript -e 'display notification \"Claude is waiting for your input\" with title \"Claude Code\" sound name \"Glass\"'"
      }
    ]
  }
],
"Stop": [
  {
    "matcher": "",
    "hooks": [
      {
        "type": "command",
        "command": "osascript -e 'display notification \"Claude has finished\" with title \"Claude Code\" sound name \"Hero\"'"
      }
    ]
  }
]
```

If you use `ruby-lsp`, add to `enabledPlugins`:
```json
"ruby-lsp@claude-plugins-official": true
```

### Windows (home)

For notifications on Windows, use PowerShell toast notifications instead:

```json
"Notification": [
  {
    "matcher": "",
    "hooks": [
      {
        "type": "command",
        "command": "powershell -Command \"[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent(0); $xml.GetElementsByTagName('text')[0].AppendChild($xml.CreateTextNode('Claude is waiting for your input')) | Out-Null; [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Claude Code').Show([Windows.UI.Notifications.ToastNotification]::new($xml))\""
      }
    ]
  }
]
```

Or simpler, if you have [BurntToast](https://github.com/Windos/BurntToast) installed:

```json
"command": "powershell -Command \"New-BurntToastNotification -Text 'Claude Code', 'Claude is waiting for your input'\""
```

The `protect_files.sh` hook requires `bash` and `python3` in PATH. On Windows this works via Git Bash or WSL.

## Per-Machine Customization

Things to add per machine in `settings.json`:

- **Read/Glob/Grep permissions** scoped to your home dir:
  ```json
  "Read(/Users/you/**)",
  "Glob(/Users/you/**)",
  "Grep(/Users/you/**)"
  ```
- **Edit/Write permissions** scoped to specific project dirs
- **Corporate proxy env vars** if behind a proxy (e.g. `NODE_EXTRA_CA_CERTS`)
- **Project-specific test commands** (e.g. region-specific test aliases)

## CodeGraph

The settings include codegraph hooks and permissions. Install codegraph separately:
- https://github.com/nicobailey-codegraph/codegraph

If you don't use codegraph, remove the `codegraph_*` permissions and the `PostToolUse`/`Stop` hooks that reference it.
