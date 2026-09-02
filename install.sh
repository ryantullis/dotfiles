#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

confirm() {
    local prompt="$1"

    while true; do
        read -r -p "$prompt [y/N] " answer

        case "$answer" in
            [Yy]|[Yy][Ee][Ss])
                return 0
                ;;
            [Nn]|[Nn][Oo]|"")
                return 1
                ;;
            *)
                echo "Please answer yes or no."
                ;;
        esac
    done
}

step() {
    echo
    echo "==> $1"
}

# ---------------------------------------------------------------------------
# Pacman package-list hook
# ---------------------------------------------------------------------------

step "Install pacman package-list hook"

HOOK_SOURCE="$DOTFILES_DIR/etc/100-list-packages.hook"
HOOK_DEST="/etc/pacman.d/hooks/100-list-packages.hook"

if [[ ! -f "$HOOK_SOURCE" ]]; then
    echo "Hook not found: $HOOK_SOURCE"
elif [[ -e "$HOOK_DEST" ]]; then
    echo "Hook already installed."
else
    echo "This will install:"
    echo "  $HOOK_DEST"

    if confirm "Install pacman hook?"; then
        sudo install -Dm644 "$HOOK_SOURCE" "$HOOK_DEST"
        echo "Installed."
    else
        echo "Skipped."
    fi
fi

# ---------------------------------------------------------------------------
# Stow dotfiles
# ---------------------------------------------------------------------------

step "Stow dotfiles"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU Stow is not installed."
    echo "Install it with: sudo pacman -S stow"
else
    if confirm "Stow dotfiles into your home directory?"; then
        (
            cd "$DOTFILES_DIR"
            stow --target="$HOME" .
        )

        echo "Dotfiles stowed."
    else
        echo "Skipped."
    fi
fi

# ---------------------------------------------------------------------------
# Packages
# ---------------------------------------------------------------------------

step "Install packages"

PACKAGES_FILE="$DOTFILES_DIR/packages.txt"

if [[ ! -f "$PACKAGES_FILE" ]]; then
    echo "Package list not found: $PACKAGES_FILE"
else
    mapfile -t PACKAGES < <(
        grep -vE '^[[:space:]]*(#|$)' "$PACKAGES_FILE"
    )

    MISSING_PACKAGES=()

    for package in "${PACKAGES[@]}"; do
        if ! pacman -Q "$package" &>/dev/null; then
            MISSING_PACKAGES+=("$package")
        fi
    done

    if [[ ${#MISSING_PACKAGES[@]} -eq 0 ]]; then
        echo "All packages are already installed."
    else
        echo "The following packages are missing:"
        printf '  %s\n' "${MISSING_PACKAGES[@]}"
        echo

        if confirm "Install missing packages?"; then
            sudo pacman -S --needed "${MISSING_PACKAGES[@]}"
        else
            echo "Skipped."
        fi
    fi
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo
echo "Installation complete."
