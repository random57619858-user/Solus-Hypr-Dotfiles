#!/usr/bin/env bash
set -euo pipefail

ESC=$(printf '\033')
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
GREEN="${ESC}[32m"
CYAN="${ESC}[36m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
RED="${ESC}[31m"

banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "┌──────────────────────────────────────────────────┐"
    echo "│         SOLUS HYPRLAND DOTFILES RESTORE          │"
    echo "└──────────────────────────────────────────────────┘"
    echo -e "${RESET}"
}

info()  { echo -e "\n${BLUE}${BOLD}==> ${1}${RESET}"; }
ok()    { echo -e "${GREEN}✔ ${1}${RESET}"; }
warn()  { echo -e "${YELLOW}⚠ ${1}${RESET}"; }
fail()  { echo -e "${RED}✖ ${1}${RESET}" >&2; }

confirm() {
    local msg="$1"
    local reply=""
    read -p "$msg (y/N): " reply < /dev/tty || true
    [[ "${reply:-}" =~ ^[yYsS]$ ]]
}

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$DOTFILES_DIR/backup"
CONFIG_DIR="$HOME/.config"
PRE_RESTORE="$BACKUP_ROOT/pre-restore-$(date +%Y%m%d-%H%M%S)"

banner

if [ ! -d "$BACKUP_ROOT" ]; then
    fail "No backup directory found at $BACKUP_ROOT. Nothing to restore."
    exit 0
fi

TOOLS=()
for d in "$BACKUP_ROOT"/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    [[ "$name" == pre-restore-* ]] && continue
    TOOLS+=("$name")
done

if [ ${#TOOLS[@]} -eq 0 ]; then
    warn "No backups available in $BACKUP_ROOT."
    exit 0
fi

info "Available backups"
for t in "${TOOLS[@]}"; do
    echo "  - $t"
done

if ! confirm "Restore all listed backups?"; then
    warn "Operation cancelled by user."
    exit 0
fi

info "Saving current state to $PRE_RESTORE"
mkdir -p "$PRE_RESTORE"
for t in "${TOOLS[@]}"; do
    if [ -e "$CONFIG_DIR/$t" ]; then
        cp -rf "$CONFIG_DIR/$t" "$PRE_RESTORE/$t"
        ok "Backed up: $t"
    fi
done

info "Restoring configurations..."
for t in "${TOOLS[@]}"; do
    src="$BACKUP_ROOT/$t"
    dest="$CONFIG_DIR/$t"

    if [ ! -e "$src" ]; then
        warn "Backup not found for $t, skipping."
        continue
    fi

    if [ -z "$(ls -A "$src")" ]; then
        warn "Backup for $t is empty, skipping."
        continue
    fi

    if [ -e "$dest" ]; then
        rm -rf "$dest"
    fi
    mkdir -p "$(dirname "$dest")"
    cp -rf "$src" "$dest"
    ok "Restored: $t"
done

echo -e "\n${GREEN}${BOLD}┌──────────────────────────────────────────────────┐"
echo "│              Restore completed :)                  │"
echo "└──────────────────────────────────────────────────┘${RESET}"
echo -e "Previous state saved at:"
echo -e "  ${CYAN}$PRE_RESTORE${RESET}\n"
echo -e "Restart Hyprland (or log out) to apply the changes.\n"
