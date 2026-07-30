#!/bin/bash
# Install safari-profile into ~/.local/bin.
# To change the destination: INSTALL_DIR=/usr/local/bin ./install.sh
set -eu

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$INSTALL_DIR"
install -m 755 "$SCRIPT_DIR/safari-profile" "$INSTALL_DIR/safari-profile"

echo "✅ Installed: $INSTALL_DIR/safari-profile"

case ":$PATH:" in
  *":$INSTALL_DIR:"*)
    echo "Try it: safari-profile <profile name>"
    ;;
  *)
    echo ""
    echo "⚠️  $INSTALL_DIR is not in your PATH."
    echo "   Add the following line to your ~/.zshrc:"
    echo ""
    echo "   export PATH=\"$INSTALL_DIR:\$PATH\""
    ;;
esac
