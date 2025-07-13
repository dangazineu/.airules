#!/bin/bash
#
# This script installs the .airules for Claude and Gemini AI assistants.
# It only configures tools for which a configuration directory already exists.
#

set -e

# --- Helper Functions for Colored Output ---
info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

warn() {
    echo -e "\033[1;33m[WARN]\033[0m $1"
}

# --- Path Definitions ---
AIRULES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_DIR="$AIRULES_DIR/rules"

CLAUDE_CONFIG_DIR="$HOME/.claude"
CLAUDE_CONFIG_FILE="$CLAUDE_CONFIG_DIR/CLAUDE.md"

GEMINI_CONFIG_DIR="$HOME/.gemini"
GEMINI_CONFIG_FILE="$GEMINI_CONFIG_DIR/GEMINI.md"

HEADER_TEXT="# Rules imported from .airules project"

# --- Claude Setup ---
if [ -d "$CLAUDE_CONFIG_DIR" ]; then
    info "--- Setting up Claude (found $CLAUDE_CONFIG_DIR) ---"
    touch "$CLAUDE_CONFIG_FILE"

    if ! grep -qF "$HEADER_TEXT" "$CLAUDE_CONFIG_FILE"; then
        [ -s "$CLAUDE_CONFIG_FILE" ] && echo "" >> "$CLAUDE_CONFIG_FILE"
        echo "$HEADER_TEXT" >> "$CLAUDE_CONFIG_FILE"
    fi

    CLAUDE_IMPORT_LINE="@$RULES_DIR"
    if grep -qF "$CLAUDE_IMPORT_LINE" "$CLAUDE_CONFIG_FILE"; then
        info "Claude rule directory is already imported."
    else
        echo "$CLAUDE_IMPORT_LINE" >> "$CLAUDE_CONFIG_FILE"
        info "Added rule directory import to $CLAUDE_CONFIG_FILE"
    fi
    success "Claude setup complete."
else
    warn "Claude config directory not found, skipping setup. (looked for $CLAUDE_CONFIG_DIR)"
fi
echo ""

# --- Gemini Setup ---
if [ -d "$GEMINI_CONFIG_DIR" ]; then
    info "--- Setting up Gemini (found $GEMINI_CONFIG_DIR) ---"
    touch "$GEMINI_CONFIG_FILE"

    GEMINI_SYMLINK_TARGET="$GEMINI_CONFIG_DIR/airules"
    ln -sf "$AIRULES_DIR" "$GEMINI_SYMLINK_TARGET"
    info "Ensured symlink exists at $GEMINI_SYMLINK_TARGET"

    if ! grep -qF "$HEADER_TEXT" "$GEMINI_CONFIG_FILE"; then
        [ -s "$GEMINI_CONFIG_FILE" ] && echo "" >> "$GEMINI_CONFIG_FILE"
        echo "$HEADER_TEXT" >> "$GEMINI_CONFIG_FILE"
    fi

    IMPORT_PREFIX="airules/rules"
    for rule_file in "$RULES_DIR"/*.md; do
        rule_name=$(basename "$rule_file")
        GEMINI_IMPORT_LINE="@$IMPORT_PREFIX/$rule_name"
        if ! grep -qF "$GEMINI_IMPORT_LINE" "$GEMINI_CONFIG_FILE"; then
            echo "$GEMINI_IMPORT_LINE" >> "$GEMINI_CONFIG_FILE"
            info "Added import for '$rule_name'."
        fi
    done
    # This is just to let the user know if all rules were already there.
    info "Gemini rules are up to date."
    success "Gemini setup complete."
else
    warn "Gemini config directory not found, skipping setup. (looked for $GEMINI_CONFIG_DIR)"
fi
echo ""

success "Installation check finished."
