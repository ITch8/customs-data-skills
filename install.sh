#!/usr/bin/env bash
# Install customs-data-skills into Cursor / Codex / OpenClaw / Agents skill roots.
# Usage:
#   ./install.sh
#   ./install.sh cursor codex
#   GLOBAL=1 ./install.sh openclaw
#   REPO_ROOT=/path/to/project ./install.sh all

set -euo pipefail

PACKAGE_ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$PACKAGE_ROOT/skills"
TARGETS=("${@:-all}")
GLOBAL="${GLOBAL:-0}"
REPO_ROOT="${REPO_ROOT:-}"

if [[ ! -f "$SKILLS_SRC/customs-lead-sop/SKILL.md" ]]; then
  echo "Cannot find skills under $SKILLS_SRC" >&2
  exit 1
fi

if [[ "${TARGETS[*]}" == *"all"* ]] || [[ ${#TARGETS[@]} -eq 0 ]]; then
  TARGETS=(cursor codex openclaw agents)
fi

install_tree() {
  local dest_root="$1"
  mkdir -p "$dest_root"
  for name in customs-lead-sop customs-pitfalls; do
    rm -rf "$dest_root/$name"
    cp -R "$SKILLS_SRC/$name" "$dest_root/$name"
    echo "  + $dest_root/$name"
  done
}

dests_for() {
  local target="$1"
  case "$target" in
    cursor)
      if [[ -n "$REPO_ROOT" ]]; then
        echo "$REPO_ROOT/.cursor/skills"
      else
        parent="$(dirname "$PACKAGE_ROOT")"
        if [[ -d "$parent/.cursor" ]]; then
          echo "$parent/.cursor/skills"
        else
          echo "$(pwd)/.cursor/skills"
        fi
      fi
      ;;
    codex)
      if [[ "$GLOBAL" == "1" || -z "$REPO_ROOT" ]]; then
        echo "$HOME/.codex/skills"
      fi
      if [[ -n "$REPO_ROOT" ]]; then
        echo "$REPO_ROOT/.codex/skills"
      elif [[ -d "$(pwd)/.git" ]]; then
        echo "$(pwd)/.codex/skills"
      fi
      ;;
    openclaw)
      if [[ "$GLOBAL" == "1" || -z "$REPO_ROOT" ]]; then
        echo "$HOME/.openclaw/skills"
      fi
      if [[ -n "$REPO_ROOT" ]]; then
        echo "$REPO_ROOT/skills"
        echo "$REPO_ROOT/.agents/skills"
      else
        echo "$(pwd)/skills"
      fi
      ;;
    agents)
      if [[ "$GLOBAL" == "1" || -z "$REPO_ROOT" ]]; then
        echo "$HOME/.agents/skills"
      fi
      if [[ -n "$REPO_ROOT" ]]; then
        echo "$REPO_ROOT/.agents/skills"
      fi
      ;;
  esac
}

echo "Installing customs-data-skills from: $PACKAGE_ROOT"
for t in "${TARGETS[@]}"; do
  echo
  echo "[$t]"
  while IFS= read -r dest; do
    [[ -z "$dest" ]] && continue
    install_tree "$dest"
  done < <(dests_for "$t" | awk 'NF && !seen[$0]++')
done

if [[ "${WRITE_AGENTS_HINT:-0}" == "1" && -n "$REPO_ROOT" && -f "$PACKAGE_ROOT/AGENTS.md" ]]; then
  cp -f "$PACKAGE_ROOT/AGENTS.md" "$REPO_ROOT/AGENTS.customs-data.md"
  echo
  echo "Wrote agent manual hint: $REPO_ROOT/AGENTS.customs-data.md"
fi

echo
echo "Done. Invoke: /customs-lead-sop  or  \$customs-lead-sop  (+ customs-pitfalls)"
