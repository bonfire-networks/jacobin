#!/bin/sh

# Add any extensions/deps with a package.json in their /assets directory here
# NOTE: any LV Hooks should also be added to ./deps.hooks.js

DEPS='iconify_ex bonfire_ui_common bonfire_editor_milkdown bonfire_geolocate'

chmod +x ./js-deps-get.sh
./js-deps-get.sh "$DEPS" "$@"
