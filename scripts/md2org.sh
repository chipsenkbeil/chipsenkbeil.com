#!/bin/bash

# To run this for all markdown files, do this from the root directory:
# ```
# for file in content/**/*.md; do ./scripts/md2org.sh "$file"; done
# ```

# Path to current script's directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_NAME="${BASH_SOURCE[0]##*/}"
SCRIPT_NAME="${SCRIPT_NAME%.*}"

# Lua filter to clean up org headlines
LUA_FILTER="$SCRIPT_DIR/$SCRIPT_NAME/org-header-beautification.lua"

# Configurable tools
AWK="${AWK:-awk}"
PANDOC="${PANDOC:-pandoc}"

# Input Markdown file
INPUT="$1"
OUTPUT="${INPUT%.md}.org"

# Extract and convert frontmatter to Org-mode
"$AWK" '
function trim(s) {
    gsub(/^[ \t\r\n]+|[ \t\r\n]+$/, "", s)
    return s
}
BEGIN { in_block=0 }
/^\+\+\+/ {
    if (in_block == 0) { in_block = 1; next }
    else { in_block = 0; exit }
}
in_block {
    if ($0 ~ /^[a-zA-Z_]+ *= *.+$/) {
        split($0, kv, "=")
        key = trim(kv[1])
        val = trim(kv[2])

        # Remove quotes from strings
        if (val ~ /^".*"$/) {
            val = substr(val, 2, length(val) - 2)
            val = trim(val)
            printf "#+%s: %s\n", toupper(key), val
        }
        # Handle array values
        else if (val ~ /^\[.*\]$/) {
            val = substr(val, 2, length(val) - 2)     # remove [ and ]
            gsub(/"/, "", val)                        # remove quotes
            gsub(/,/, " ", val)                       # replace commas with space
            val = trim(val)
            printf "#+%s[]: %s\n", toupper(key), val
        }
    }
}
' "$INPUT" > "$OUTPUT"

# Add a blank line after frontmatter
echo "" >> "$OUTPUT"

# Convert Markdown body to Org and append
"$AWK" '
BEGIN { in_block=0 }
/^\+\+\+/ {
    if (in_block == 0) { in_block = 1; next }
    else { in_block = 0; next }
}
!in_block { print }
' "$INPUT" | "$PANDOC" --from=markdown --to=org --wrap=auto --columns=80 --lua-filter="$LUA_FILTER" >> "$OUTPUT"
