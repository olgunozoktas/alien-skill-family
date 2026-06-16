#!/usr/bin/env bash
# setup.sh — symlink the alien skill family into ~/.claude/skills so it's
# globally available in every project. Idempotent: safe to re-run.
#
#   ./setup.sh           # install (symlink) all alien-* skills
#   ./setup.sh --check   # report what's linked without changing anything
#   ./setup.sh --remove  # remove the alien-* symlinks (leaves this repo intact)
#
# Mirrors the backlog-skill-family convention: source of truth lives here in
# ~/Herd/alien-skill-family/skills/<name>/, and ~/.claude/skills/<name> is a
# symlink to it. Edit the files here; changes are live immediately.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO_DIR/skills"
SKILLS_DST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mode="install"
case "${1:-}" in
  --check)  mode="check" ;;
  --remove) mode="remove" ;;
  "" )      mode="install" ;;
  *) echo "usage: $0 [--check|--remove]" >&2; exit 2 ;;
esac

mkdir -p "$SKILLS_DST"
linked=0; skipped=0; backed=0; removed=0

for src in "$SKILLS_SRC"/*/; do
  name="$(basename "$src")"
  dst="$SKILLS_DST/$name"

  if [[ "$mode" == "check" ]]; then
    if [[ -L "$dst" && "$(readlink "$dst")" == "${src%/}" ]]; then
      echo "  ✓ $name -> linked"
    elif [[ -e "$dst" ]]; then
      echo "  ! $name -> exists but NOT linked to this repo"
    else
      echo "  • $name -> not installed"
    fi
    continue
  fi

  if [[ "$mode" == "remove" ]]; then
    if [[ -L "$dst" ]]; then rm "$dst"; echo "  removed $name"; removed=$((removed+1)); fi
    continue
  fi

  # install
  if [[ -L "$dst" && "$(readlink "$dst")" == "${src%/}" ]]; then
    skipped=$((skipped+1)); continue
  fi
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    bak="$dst.bak-$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$bak"; echo "  backed up existing $name -> $(basename "$bak")"; backed=$((backed+1))
  elif [[ -L "$dst" ]]; then
    rm "$dst"
  fi
  ln -s "${src%/}" "$dst"
  echo "  linked $name"; linked=$((linked+1))
done

[[ "$mode" == "install" ]] && echo "done: $linked linked, $skipped already current, $backed backed up"
[[ "$mode" == "remove"  ]] && echo "done: $removed removed"
exit 0
