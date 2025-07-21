#!/bin/bash

# Vai nella cartella Exercises (se non sei già lì)
cd "$(dirname "$0")"

OUTPUT="Summary_of_exercises.md"
echo "" > "$OUTPUT" # svuota il file se già esiste

for dir in */ ; do
    # Rimuove la barra finale dal nome della cartella
    subdir="${dir%/}"
    echo "<details>" >> "$OUTPUT"
    echo "<summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## $subdir" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "<details>" >> "$OUTPUT"
    echo "<summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "### Problem" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '```R' >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    if [[ -f "$subdir/Problem.R" ]]; then
        # tabula ogni riga con 4 spazi
        sed 's/^/    /' "$subdir/Problem.R" >> "$OUTPUT"
    fi
    echo "" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</details>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "<details>" >> "$OUTPUT"
    echo "<summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "### Solution" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</summary>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '```R' >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    if [[ -f "$subdir/Solution.R" ]]; then
        sed 's/^/    /' "$subdir/Solution.R" >> "$OUTPUT"
    fi
    echo "" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</details>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "</details>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
done
