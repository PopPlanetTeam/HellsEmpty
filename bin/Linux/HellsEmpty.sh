#!/bin/sh
echo -ne '\033c\033]0;HellsEmpty\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/HellsEmpty.x86_64" "$@"
