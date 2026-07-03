#!/bin/bash

# Exit on any error
set -e

FLAVOUR="jacobin"

# Get the script's directory
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source the functions file
source "$(dirname "$0")/functions.sh"

# Parse command line arguments
AUTO_YES=${AUTO_YES:-false}
for arg in "$@"; do
    case $arg in
        -y|--yes)
            echo "Existing files will be overridden without prompting"
            export AUTO_YES=true
            shift
            ;;
    esac
done


# Show mode
if [ "$AUTO_YES" = true ]; then
    echo "Running in automatic override mode (-y flag detected)"
fi

echo -e "\nInstalling flavour(s) this one depends on first..."
run_installers ember social community || exit 1

echo -e "\nCreating directories..."
create_dirs "lib/" "config/current_flavour/"

echo -e "\nCopying deps files..."
copy_glob_with_prompt "$SOURCE_DIR" "deps.*" "config/current_flavour/"

echo -e "\nCopying flavour config"
copy_with_prompt "$SOURCE_DIR/config/$FLAVOUR.exs" "config/"

echo -e "\nCopying DB migrations"
copy_dir_with_prompt "$SOURCE_DIR/priv/repo/" "priv/repo/"

echo -e "\nCopying custom templates..."
copy_dir_with_prompt "$SOURCE_DIR/priv/templates/lib/" "lib/"

echo -e "\nCopying static assets..."
copy_dir_with_prompt "$SOURCE_DIR/priv/static/" "priv/static/"

echo -e "\nInstalling flavour themes..."
# Find the custom_themes.css file
CUSTOM_THEMES=""
for path in "extensions/bonfire_ui_common/assets/css/custom_themes.css" "deps/bonfire_ui_common/assets/css/custom_themes.css"; do
    if [ -f "$path" ]; then
        CUSTOM_THEMES="$path"
        break
    fi
done

if [ -n "$CUSTOM_THEMES" ] && [ -f "$SOURCE_DIR/themes/theme.css" ]; then
    # Check if jacobin themes are already present
    if grep -q 'name: "jacobin"' "$CUSTOM_THEMES" 2>/dev/null; then
        echo "Jacobin themes already present in $CUSTOM_THEMES"
    else
        echo "Appending Jacobin themes to $CUSTOM_THEMES"
        echo "" >> "$CUSTOM_THEMES"
        cat "$SOURCE_DIR/themes/theme.css" >> "$CUSTOM_THEMES"
        echo "Jacobin themes installed"
    fi
else
    echo "Warning: Could not find custom_themes.css or themes/theme.css"
fi

echo -e "\n$FLAVOUR installation complete!"
