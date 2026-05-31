#!/bin/sh
set -eu

ask_yes() {
  printf "%s [y/N] " "$1"
  read -r answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

source_path="$(chezmoi source-path)"

echo "chezmoi source: $source_path"
echo
echo "Current local target changes:"
if ! chezmoi status; then
  echo "Unable to read chezmoi status; skipping guarded update."
  exit 1
fi

echo
echo "Current local target diff:"
chezmoi diff || true

if command -v git >/dev/null 2>&1 && [ -d "$source_path/.git" ]; then
  echo
  echo "chezmoi source repository status:"
  git -C "$source_path" status --short
fi

echo
if ! ask_yes "Pull chezmoi source updates now?"; then
  echo "Skipping chezmoi update."
  exit 0
fi

chezmoi update --apply=false

echo
echo "Dry-run of applying pulled chezmoi changes:"
chezmoi apply --dry-run --verbose

echo
if ask_yes "Apply these chezmoi changes now?"; then
  chezmoi apply
else
  echo "Pulled source changes but skipped apply."
fi
