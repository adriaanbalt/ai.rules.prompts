#!/bin/bash
# setup-cursor-rules.sh
#
# Installs or updates shared Cursor rules from the rules repo.
# Run from the root of any project:
#
#   bash /path/to/cursor.rules.prompts/setup-cursor-rules.sh
#
# Or copy this script into your project and run:
#
#   bash setup-cursor-rules.sh
#
# What it does:
#   1. Clones shared rules into .cursor/rules/shared/
#   2. Adds .cursor/rules/shared/ to .gitignore (avoids double-tracking)
#   3. Preserves any project-specific rules already in .cursor/rules/

RULES_REPO="git@github.com:adriaanbalt/ai.rules.prompts.git"
TARGET=".cursor/rules/shared"

# Ensure we're in a project root (has package.json, .git, or similar)
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "Cargo.toml" ] && [ ! -f "pyproject.toml" ]; then
  echo "⚠️  Warning: No .git, package.json, or other project marker found."
  echo "   Are you in the project root? (Proceeding anyway...)"
fi

# Clone or update
if [ -d "$TARGET/.git" ]; then
  echo "📦 Updating shared rules in $TARGET..."
  git -C "$TARGET" pull origin main
else
  echo "📦 Installing shared rules into $TARGET..."
  mkdir -p .cursor/rules
  git clone "$RULES_REPO" "$TARGET"
fi

# Add to .gitignore if not already present
if [ -f ".gitignore" ]; then
  if ! grep -qF ".cursor/rules/shared/" .gitignore; then
    echo "" >> .gitignore
    echo "# Shared Cursor rules (managed by setup-cursor-rules.sh)" >> .gitignore
    echo ".cursor/rules/shared/" >> .gitignore
    echo "✅ Added .cursor/rules/shared/ to .gitignore"
  fi
else
  echo "# Shared Cursor rules (managed by setup-cursor-rules.sh)" > .gitignore
  echo ".cursor/rules/shared/" >> .gitignore
  echo "✅ Created .gitignore with .cursor/rules/shared/"
fi

echo ""
echo "✅ Done. Shared rules installed at $TARGET"
echo ""
echo "   Your project-specific rules go in: .cursor/rules/*.mdc"
echo "   Shared rules live in:              .cursor/rules/shared/*.mdc"
echo ""
echo "   To update later, run this script again."
