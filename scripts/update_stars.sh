#!/usr/bin/env bash
# Rewrites <!--stars:REPO-->N<!--/stars--> markers in README.md with live counts.
set -euo pipefail
owner="franklee16"
readme="README.md"

for repo in $(grep -oE '<!--stars:[A-Za-z0-9_.-]+-->' "$readme" | sed -E 's/<!--stars:([A-Za-z0-9_.-]+)-->/\1/' | sort -u); do
  count=$(gh api "repos/$owner/$repo" -q .stargazers_count)
  sed -i -E "s#(<!--stars:$repo-->)[0-9]+(<!--/stars-->)#\1$count\2#g" "$readme"
  echo "$repo -> $count"
done
