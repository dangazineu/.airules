#!/bin/bash
#
# Test runner for install.sh
# This script verifies that the installer only configures tools
# for which a config directory already exists.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Dynamic Path Setup ---
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
INSTALL_SCRIPT="$PROJECT_ROOT/install.sh"

# --- Assertion Helpers ---
assert_exists() {
    if [ ! -e "$1" ]; then
        echo "❌ TEST FAILED: Expected '$1' to exist, but it does not."
        exit 1
    fi
    echo "✅ PASSED: '$1' exists as expected."
}

assert_not_exists() {
    if [ -e "$1" ]; then
        echo "❌ TEST FAILED: Expected '$1' to NOT exist, but it does."
        exit 1
    fi
    echo "✅ PASSED: '$1' does not exist as expected."
}

assert_contains() {
    if ! grep -qE "$1" "$2"; then
        echo "❌ TEST FAILED: Expected to find pattern '$1' in '$2'."
        exit 1
    fi
    echo "✅ PASSED: Found expected content in '$2'."
}

# --- Composite Assertion Functions ---
assert_claude_configured() {
    echo "Asserting Claude is configured..."
    assert_exists "$HOME/.claude/CLAUDE.md"
    assert_contains "^@.*/rules$" "$HOME/.claude/CLAUDE.md"
}

assert_gemini_configured() {
    echo "Asserting Gemini is configured..."
    assert_exists "$HOME/.gemini/GEMINI.md"
    assert_contains "@airules/rules/branching-strategy.md" "$HOME/.gemini/GEMINI.md"
    assert_exists "$HOME/.gemini/airules"
}


# --- Test Scenarios ---

echo ""
echo "--- Running Test Scenario: No config directories exist ---"
export HOME=$(mktemp -d)
bash "$INSTALL_SCRIPT"
assert_not_exists "$HOME/.claude"
assert_not_exists "$HOME/.gemini"
rm -rf "$HOME"
echo "--- Scenario Complete: No config directories exist ---"


echo ""
echo "--- Running Test Scenario: Only .claude directory exists ---"
export HOME=$(mktemp -d)
mkdir -p "$HOME/.claude"
bash "$INSTALL_SCRIPT"
assert_claude_configured
assert_not_exists "$HOME/.gemini"
rm -rf "$HOME"
echo "--- Scenario Complete: Only .claude directory exists ---"


echo ""
echo "--- Running Test Scenario: Only .gemini directory exists ---"
export HOME=$(mktemp -d)
mkdir -p "$HOME/.gemini"
bash "$INSTALL_SCRIPT"
assert_gemini_configured
assert_not_exists "$HOME/.claude"
rm -rf "$HOME"
echo "--- Scenario Complete: Only .gemini directory exists ---"


echo ""
echo "--- Running Test Scenario: Both directories exist ---"
export HOME=$(mktemp -d)
mkdir -p "$HOME/.claude" && mkdir -p "$HOME/.gemini"
bash "$INSTALL_SCRIPT"
assert_claude_configured
assert_gemini_configured
rm -rf "$HOME"
echo "--- Scenario Complete: Both directories exist ---"


echo ""
echo "--- Running Test Scenario: Idempotency Check ---"
export HOME=$(mktemp -d)
mkdir -p "$HOME/.claude" && mkdir -p "$HOME/.gemini"
bash "$INSTALL_SCRIPT"
bash "$INSTALL_SCRIPT" # Run a second time
CLAUDE_IMPORT_COUNT=$(grep -cE "^@.*/rules$" "$HOME/.claude/CLAUDE.md")
if [ "$CLAUDE_IMPORT_COUNT" -ne 1 ]; then
    echo "❌ TEST FAILED: Claude import was duplicated."
    exit 1
fi
echo "✅ PASSED: Claude import was not duplicated."
GEMINI_IMPORT_COUNT=$(grep -cF "@airules/rules/branching-strategy.md" "$HOME/.gemini/GEMINI.md")
if [ "$GEMINI_IMPORT_COUNT" -ne 1 ]; then
    echo "❌ TEST FAILED: Gemini import was duplicated."
    exit 1
fi
echo "✅ PASSED: Gemini import was not duplicated."
rm -rf "$HOME"
echo "--- Scenario Complete: Idempotency Check ---"


echo ""
echo "🎉 All tests passed! 🎉"
