#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
#  Fetches the two backgrounds this repo does not redistribute.
#
#  3-mist-spheres.jpg and 4-tower-blocks.jpg are paintings by Simon Stålenhag
#  (https://simonstalenhag.se/). They are not bundled here because they are his
#  work, not this theme's. This script downloads them from the wallpaper
#  collection they were originally taken from, so the theme is complete on your
#  machine without this repo hosting his art.
#
#  If you like them, buy his books.
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

BASE="https://raw.githubusercontent.com/dharmx/walls/main/stalenhag"
DEST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/backgrounds"

declare -A FILES=(
  ["3-mist-spheres.jpg"]="a_group_of_people_walking_in_a_field_with_a_round_object_in_the_foreground.jpg"
  ["4-tower-blocks.jpg"]="a_group_of_tall_buildings_with_cartoon_characters_on_them.jpg"
)

mkdir -p "$DEST"
for local_name in "${!FILES[@]}"; do
    if [[ -f "$DEST/$local_name" ]]; then
        echo "  ok       $local_name (already present)"
        continue
    fi
    echo "  fetching $local_name"
    if curl -fsSL "$BASE/${FILES[$local_name]}" -o "$DEST/$local_name"; then
        echo "  done     $local_name"
    else
        echo "  FAILED   $local_name — the upstream file may have moved" >&2
    fi
done

echo
echo "Re-apply the theme to pick them up:  omarchy theme set dionysus"
