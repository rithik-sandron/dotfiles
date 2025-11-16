#!/bin/zsh

SETTINGS_PATH="$HOME/Library/Application Support/Code/User/settings.json"

# Write custom theme JSON config to settings.json
cat >"$SETTINGS_PATH" <<EOF
{
  "workbench.colorTheme": "Ryuu Blaze",
  "editor.fontSize": 13,
  "terminal.integrated.fontSize": 12,
  "editor.formatOnSave": true,
  "editor.formatOnSaveMode": "file",
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 2000,
  "workbench.colorCustomizations": {
    "editor.background": "#171717",
    "editor.foreground": "#ebdbb2",
    "editor.lineHighlightBackground": "#32302f",
    "editor.selectionBackground": "#504945",
    "editorCursor.foreground": "#fabd2f",
    "editor.inactiveSelectionBackground": "#1d2021",
    "editorIndentGuide.background": "#504945",
    "editorIndentGuide.activeBackground": "#fabd2f",
    "sideBar.background": "#171717",
    "sideBar.foreground": "#ebdbb2",
    "statusBar.background": "#121212",
    "statusBar.foreground": "#ebdbb2",
    "activityBar.background": "#171717",
    "activityBar.foreground": "#ebdbb2",
    "titleBar.activeBackground": "#1a1a1a",
    "titleBar.activeForeground": "#ebdbb2",
    "tab.activeBackground": "#171717",
    "tab.inactiveBackground": "#1d2021",
    "tab.activeForeground": "#ebdbb2",
    "tab.inactiveForeground": "#7c6f64"
  },
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": ["comment", "punctuation.definition.comment", "string.comment"],
        "settings": { "foreground": "#928374", "fontStyle": "italic" }
      },
      {
        "scope": ["keyword", "storage.type", "storage.modifier"],
        "settings": { "foreground": "#df4934", "fontStyle": "bold" }
      },
      {
        "scope": ["constant", "variable.language", "entity.name.constant"],
        "settings": { "foreground": "#fb4934" }
      },
      {
        "scope": ["string", "entity.name.tag", "markup.changed"],
        "settings": { "foreground": "#b8bb26" }
      },
      {
        "scope": ["support.function", "keyword.operator"],
        "settings": { "foreground": "#fe8019" }
      },
      {
        "scope": ["variable", "parameter", "entity.name.variable"],
        "settings": { "foreground": "#ebdbb2" }
      },
      {
        "scope": ["invalid", "invalid.illegal"],
        "settings": { "foreground": "#fb4934", "fontStyle": "underline" }
      }
    ]
  }
  "[shellscript]": {
        "editor.defaultFormatter": "mkhl.shfmt",
        "editor.formatOnSave": true,
        "editor.tabSize": 4
  },
}
EOF

# install extensions
source $HOME/.zshrc
code --install-extension mkhl.shfmt
code --install-extension esbenp.prettier-vscode
echo "VS Code settings.json updated."
