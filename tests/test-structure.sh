#!/bin/bash
# Validate plugin structure and file integrity.
# Run from the plugin root: bash tests/test-structure.sh

PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0

echo "=== career-toolkit structure tests ==="
echo ""

# Test: plugin.json exists and is valid JSON
echo "--- plugin.json valid ---"
if python3 -c "import json; json.load(open('$PLUGIN_ROOT/.claude-plugin/plugin.json'))" 2>/dev/null; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — plugin.json is missing or invalid JSON"
  FAIL=$((FAIL + 1))
fi

# Test: plugin.json has required 'name' field
echo "--- plugin.json has name ---"
if python3 -c "import json; d=json.load(open('$PLUGIN_ROOT/.claude-plugin/plugin.json')); assert 'name' in d" 2>/dev/null; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — plugin.json missing 'name' field"
  FAIL=$((FAIL + 1))
fi

# Test: All SKILL.md files exist
for skill in setup linkedin resume-review resume-research; do
  echo "--- skills/$skill/SKILL.md exists ---"
  if [ -f "$PLUGIN_ROOT/skills/$skill/SKILL.md" ]; then
    echo "PASS"
    PASS=$((PASS + 1))
  else
    echo "FAIL — skills/$skill/SKILL.md not found"
    FAIL=$((FAIL + 1))
  fi
done

# Test: All SKILL.md files have frontmatter with name and description
for skill in setup linkedin resume-review resume-research; do
  echo "--- skills/$skill/SKILL.md has frontmatter ---"
  file="$PLUGIN_ROOT/skills/$skill/SKILL.md"
  if head -1 "$file" | grep -q "^---" && grep -q "^name:" "$file" && grep -q "^description:" "$file"; then
    echo "PASS"
    PASS=$((PASS + 1))
  else
    echo "FAIL — missing or malformed frontmatter in $skill"
    FAIL=$((FAIL + 1))
  fi
done

# Test: All SKILL.md descriptions use third person
for skill in setup linkedin resume-review resume-research; do
  echo "--- skills/$skill description is third-person ---"
  file="$PLUGIN_ROOT/skills/$skill/SKILL.md"
  if grep -A5 "^description:" "$file" | grep -q "This skill should be used"; then
    echo "PASS"
    PASS=$((PASS + 1))
  else
    echo "FAIL — description doesn't use third-person format in $skill"
    FAIL=$((FAIL + 1))
  fi
done

# Test: hooks.json exists and is valid JSON
echo "--- hooks.json valid ---"
if python3 -c "import json; json.load(open('$PLUGIN_ROOT/hooks/hooks.json'))" 2>/dev/null; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — hooks.json is missing or invalid JSON"
  FAIL=$((FAIL + 1))
fi

# Test: Hook script is executable
echo "--- check-profile.sh is executable ---"
if [ -x "$PLUGIN_ROOT/hooks/scripts/check-profile.sh" ]; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — check-profile.sh is not executable"
  FAIL=$((FAIL + 1))
fi

# Test: References exist
echo "--- career-principles.md exists ---"
if [ -f "$PLUGIN_ROOT/references/career-principles.md" ]; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — references/career-principles.md not found"
  FAIL=$((FAIL + 1))
fi

echo "--- review-agents.md exists ---"
if [ -f "$PLUGIN_ROOT/skills/resume-review/references/review-agents.md" ]; then
  echo "PASS"
  PASS=$((PASS + 1))
else
  echo "FAIL — skills/resume-review/references/review-agents.md not found"
  FAIL=$((FAIL + 1))
fi

# Test: No hardcoded user paths
echo "--- no hardcoded user paths ---"
if grep -r "/Users/" "$PLUGIN_ROOT" --include="*.md" --include="*.json" --include="*.sh" -l 2>/dev/null | grep -v ".git" | grep -v "tests/" | head -1 | grep -q .; then
  echo "FAIL — found hardcoded /Users/ paths:"
  grep -r "/Users/" "$PLUGIN_ROOT" --include="*.md" --include="*.json" --include="*.sh" -l 2>/dev/null | grep -v ".git" | grep -v "tests/"
  FAIL=$((FAIL + 1))
else
  echo "PASS"
  PASS=$((PASS + 1))
fi

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
