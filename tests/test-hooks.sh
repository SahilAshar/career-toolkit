#!/bin/bash
# Test suite for career-toolkit plugin hooks.
# Run from the plugin root: bash tests/test-hooks.sh

PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROFILE="$HOME/.claude/career-toolkit.local.md"
PASS=0
FAIL=0

echo "=== career-toolkit hook tests ==="
echo ""

# Test 1: No profile — hook should output nudge
echo "--- hook-no-profile ---"
rm -f "$PROFILE" 2>/dev/null
output=$(bash "$PLUGIN_ROOT/hooks/scripts/check-profile.sh" 2>&1)
if echo "$output" | grep -q "career-toolkit:setup"; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — expected setup nudge, got: $output"
  FAIL=$((FAIL + 1))
fi

# Test 2: Profile exists — hook should be silent
echo "--- hook-has-profile ---"
mkdir -p "$HOME/.claude"
cat > "$PROFILE" << 'EOF'
---
name: Test User
field: testing
setup_complete: true
---
EOF
output=$(bash "$PLUGIN_ROOT/hooks/scripts/check-profile.sh" 2>&1)
if [ -z "$output" ]; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — expected silence, got: $output"
  FAIL=$((FAIL + 1))
fi

# Cleanup
rm -f "$PROFILE"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
