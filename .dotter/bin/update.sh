#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

if [ ! -f "$DIR/.dotter-version" ]; then
	echo "dotter version file (.dotter-version) missing" >&2
	exit 1
fi

VERSION="${1:-"${DOTTER_VERSION:-"$(cat "$DIR/.dotter-version")"}"}"

if [ "dotter $VERSION" = "$($DIR/dotter --version)" ]; then
	echo "dotter version $VERSION already in sync"
	exit
fi

URL_BASE="https://github.com/SuperCuber/dotter/releases/download/v$VERSION"

echo "Downloading Linux x86-64 binary"
curl --silent --show-error --location --output "$DIR/dotter-$VERSION-linux-x86_64" "$URL_BASE/dotter-linux-x64-musl"
chmod +x "$DIR/dotter-$VERSION-linux-x86_64"

echo "Downloading macOS aarch64 binary"
curl --silent --show-error --location --output "$DIR/dotter-$VERSION-darwin-aarch64" "$URL_BASE/dotter-macos-arm64.arm"
chmod +x "$DIR/dotter-$VERSION-darwin-aarch64"

echo "Downloading Windows x86-64 MSVC binary"
curl --silent --show-error --location --output "$DIR/dotter-$VERSION-windows-x86_64.exe" "$URL_BASE/dotter-windows-x64-msvc.exe"

echo -n "$VERSION" > "$DIR/.dotter-version"
