#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}"

for app_dir in "$DOTFILES_DIR"/*/; do
    [ -d "$app_dir" ] || continue
    app_name="$(basename "$app_dir")"

    read -r -p "install dotfiles for '${app_name}'? [Y/n] " response
    case "${response,,}" in
        n|N)
            echo "skipping ${app_name}"
            echo ""
            continue
            ;;
        *)
            echo "installing ${app_name}..."
            ;;
    esac

    find "$app_dir" -type f ! -path '*/.git/*' | while read -r src_file; do
        rel_path="${src_file#"$app_dir"}"
        dest_file="${TARGET_DIR}/${rel_path}"
        dest_dir="$(dirname "$dest_file")"

        mkdir -p "$dest_dir"

        if [ -e "$dest_file" ] && [ ! -L "$dest_file" ]; then
            echo "  [backup] $dest_file -> ${dest_file}.bak"
            mv "$dest_file" "${dest_file}.bak"
        fi

        ln -sfn "$src_file" "$dest_file"
        echo "  [linked] ~/$rel_path -> $src_file"
    done

    echo ""
done

echo ".dotfiles installed"
echo ""

read -r -p "install Seanime? [Y/n] " response
case "${response,,}" in
  n|N)
      echo ""
      break
      ;;
  *)
      echo "installing Seanime..."
      SEANIME_VERSION=$(curl -sL "https://github.com/5rahim/seanime/releases/latest/download/latest-linux.yml" | awk -F': ' 'NR == 1 {print $2}')
      curl -sL "https://github.com/5rahim/seanime/releases/download/v${SEANIME_VERSION}/seanime-${SEANIME_VERSION}_Linux_x86_64.tar.gz" -o "/tmp/seanime.tar.gz"
      mkdir -p "${HOME}/.local/bin/seanime-app"
      tar -xf "/tmp/seanime.tar.gz" -C "${HOME}/.local/bin/seanime-app"
      rm -f "/tmp/seanime.tar.gz"
      mkdir -p "${HOME}/.local/share/icons/hicolor/256x256/apps"
      curl -sL "https://seanime.app/seanime-logo.png" -o "${HOME}/.local/share/icons/hicolor/256x256/apps/seanime.png"
      update-desktop-database "${HOME}/.local/share/applications"
      echo "Seanime installed"
      ;;
esac
