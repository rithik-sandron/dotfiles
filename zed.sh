#!/bin/zsh
#
# SETTINGS_PATH="$HOME/.config/zed/settings.json"
# Write custom theme JSON config to settings.json
cat >"$SETTINGS_PATH" <<EOF
{
  "icon_theme": "Material Icon Theme",
  "theme": "Ayu Mirage",
  "ui_font_size": 15.6,
  "buffer_font_size": 13.8,
  "tab_size": 2,
  "hard_tabs": false,
  "preferred_line_length": 100,
  "format_on_save": "on",
  "remove_trailing_whitespace_on_save": true,
  "ensure_final_newline_on_save": true,
  "soft_wrap": "editor_width",
  "auto_install_extensions": {
    "html": true,
    "helm": true,
    "terraform": true,
    "github-actions": true,
    "material-icon-theme": true,
    "opentofu": true,
  },

  "languages": {
    "YAML": {
      "tab_size": 2,
      "formatter": "language_server",
    },
    "Terraform": {
      "tab_size": 2,
    },
    "Go": {
      "tab_size": 2,
    },
    "HTML": {
      "tab_size": 2,
    },
    "CSS": {
      "tab_size": 2,
    },
    "JavaScript": {
      "tab_size": 2,
    },
    "TypeScript": {
      "tab_size": 2,
    },
  },

  "file_types": {
    "Helm": [
      "**/charts/**/templates/**/*.yaml",
      "**/charts/**/templates/**/*.yml",
      "**/templates/**/*.yaml",
      "**/templates/**/*.yml",
      "**/templates/**/*.tpl",
      "**/Chart.yaml",
      "**/values.yaml",
      "**/values.yml",
      "**/values*.yaml",
      "**/values*.yml",
      "**/helmfile*.yaml",
      "**/helmfile*.yml",
    ],
    "YAML": [
      "**/k8s/**/*.yaml",
      "**/k8s/**/*.yml",
      "**/manifests/**/*.yaml",
      "**/manifests/**/*.yml",
      "**/*.docker-compose.yml",
      "**/*.docker-compose.yaml",
      "**/compose.yml",
      "**/compose.yaml",
      "**/docker-compose.yml",
      "**/docker-compose.yaml",
    ],
  },

  "lsp": {
    "yaml-language-server": {
      "settings": {
        "yaml": {
          "keyOrdering": false,
          "format": {
            "enable": true,
            "singleQuote": false,
          },
          "schemaStore": {
            "enable": true,
          },
        },
      },
    },
    "terraform-ls": {
      "initialization_options": {
        "experimentalFeatures": {
          "prefillRequiredFields": true,
        },
      },
    },
  },
}
EOF

# install extensions
source $HOME/.zshrc
echo "Zed settings.json updated."
