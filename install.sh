#!/usr/bin/env bash
# Enlaza lazyiptv y el atajo ltv en ~/.local/bin (que debe estar en el PATH).
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin="$HOME/.local/bin"

mkdir -p "$bin"
chmod +x "$repo/lazyiptv"
ln -sfn "$repo/lazyiptv" "$bin/lazyiptv"
ln -sfn lazyiptv "$bin/ltv"

command -v mpv >/dev/null || echo "Aviso: no encuentro mpv. Instálalo con: sudo apt install mpv"
case ":$PATH:" in
  *":$bin:"*) ;;
  *) echo "Aviso: $bin no está en el PATH." ;;
esac
echo "Listo. Ejecuta: ltv"
