#!/bin/bash
# Check if career-toolkit profile exists and nudge setup if not.

PROFILE="$HOME/.claude/career-toolkit.local.md"

if [ ! -f "$PROFILE" ]; then
  echo "No career-toolkit profile found. This user hasn't run setup yet."
  echo "Suggest they type /career-toolkit:setup to get started."
  echo "Keep the suggestion friendly and brief — one or two sentences."
fi
