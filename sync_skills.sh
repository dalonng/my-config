#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
local_skill_dir="${LOCAL_SKILL_DIR:-"$script_dir/skill_codex/skills"}"
xcode_skill_dir="${XCODE_SKILL_DIR:-"$script_dir/skill_codex/xcode-skills"}"
github_cache_dir="${GITHUB_SKILL_CACHE_DIR:-"${XDG_CACHE_HOME:-"$HOME/.cache"}/my-config/codex-skills"}"
dest_dir="${CODEX_SKILLS_DIR:-"${CODEX_HOME:-"$HOME/.codex"}/skills"}"

if [[ ! -d "$local_skill_dir" ]]; then
  echo "Missing local skill directory: $local_skill_dir" >&2
  exit 1
fi

if [[ ! -d "$xcode_skill_dir" ]]; then
  echo "Missing Xcode skill directory: $xcode_skill_dir" >&2
  exit 1
fi

mkdir -p "$dest_dir"

synced=0
sync_skill_dir() {
  local skill_dir="$1"
  local skill_name

  skill_name="$(basename "$skill_dir")"

  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "Skipping $skill_name: missing SKILL.md"
    return 0
  fi

  rsync -a --delete \
    --exclude ".DS_Store" \
    "$skill_dir/" \
    "$dest_dir/$skill_name/"

  echo "Synced $skill_name"
  synced=$((synced + 1))
}

sync_local_skills() {
  local source_dir="$1"

  while IFS= read -r skill_dir; do
    sync_skill_dir "$skill_dir"
  done < <(find "$source_dir" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort)
}

sync_github_skill() {
  local repo="$1"
  local ref="$2"
  local path="$3"
  local repo_name
  local checkout_dir
  local skill_dir

  repo_name="$(basename "$repo" .git)"
  checkout_dir="$github_cache_dir/$repo_name"

  mkdir -p "$github_cache_dir"

  if [[ -d "$checkout_dir/.git" ]]; then
    git -C "$checkout_dir" fetch --depth 1 origin "$ref"
    git -C "$checkout_dir" checkout --quiet FETCH_HEAD
  else
    git clone --depth 1 --branch "$ref" "$repo" "$checkout_dir"
  fi

  skill_dir="$checkout_dir/$path"
  if [[ ! -d "$skill_dir" ]]; then
    echo "Missing GitHub skill path: $repo#$ref:$path" >&2
    exit 1
  fi

  sync_skill_dir "$skill_dir"
}

sync_local_skills "$local_skill_dir"
sync_local_skills "$xcode_skill_dir"

sync_github_skill "https://github.com/dadederk/iOS-Accessibility-Agent-Skill.git" "main" "ios-accessibility"
sync_github_skill "git@github.com:twostraws/SwiftUI-Agent-Skill.git" "main" "swiftui-pro"
sync_github_skill "https://github.com/vermont42/ios-build-verify" "main" "ios-build-verify"

echo "Synced $synced skills to $dest_dir"
