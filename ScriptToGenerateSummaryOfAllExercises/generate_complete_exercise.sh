#!/bin/bash

OUTPUT_FILE="complete_exercise.md"
echo "" > "$OUTPUT_FILE"

for dir in */ ; do
  # Rimuovo la barra finale dal nome della cartella
  DIRNAME="${dir%/}"
  echo "<details>" >> "$OUTPUT_FILE"
  echo "<summary>" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "## $DIRNAME" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "</summary>" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  
  # Problem
  echo "### Problem" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo '```R' >> "$OUTPUT_FILE"
  if [ -f "${DIRNAME}/Problem.R" ]; then
    cat "${DIRNAME}/Problem.R" >> "$OUTPUT_FILE"
  fi
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  
  # Solution
  echo "### Solution" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo '```R' >> "$OUTPUT_FILE"
  if [ -f "${DIRNAME}/Solution.R" ]; then
    cat "${DIRNAME}/Solution.R" >> "$OUTPUT_FILE"
  fi
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  
  echo "</details>" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done