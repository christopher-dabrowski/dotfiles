#!/usr/bin/env bash

set -eufo pipefail

# Role: 'all' (everything), 'viewer' (read only), 'editor' (edit), shell (application can execute the item), none
declare -a MAPPINGS=(
    "com.brave.Browser pdf viewer" # Sets Brave as the default browser for PDF files
    "com.brave.Browser public.url all" # Sets Brave as the default browser for links (http/https)

    # --- VLC ---
    "org.videolan.vlc mp4 all"
    "org.videolan.vlc mkv all"
    "org.videolan.vlc avi all"
    "org.videolan.vlc mov all"
    "org.videolan.vlc mp3 all"
    "org.videolan.vlc wav all"
    "org.videolan.vlc flac all"

    # --- VS Code ---
    "com.microsoft.VSCode cs all"
    "com.microsoft.VSCode csproj all"
    "com.microsoft.VSCode js all"
    "com.microsoft.VSCode ts all"
    "com.microsoft.VSCode jsx all"
    "com.microsoft.VSCode tsx all"
    "com.microsoft.VSCode json all"
    "com.microsoft.VSCode yaml all"
    "com.microsoft.VSCode yml all"
    "com.microsoft.VSCode xml all"
    "com.microsoft.VSCode md all"
    "com.microsoft.VSCode txt all"
    "com.microsoft.VSCode log all"
    "com.microsoft.VSCode sh all"
    "com.microsoft.VSCode env all"
    "com.microsoft.VSCode csv all"
    "com.microsoft.VSCode gitignore all"
)

echo "Configuring default applications..."

for mapping in "${MAPPINGS[@]}"; do
    read -r bundle_id ext role <<< "$mapping"

    if duti -s "$bundle_id" "$ext" "$role"; then
        echo " -> Set: .$ext opened by $bundle_id"
    else
        echo " -> Error: Failed to set .$ext for $bundle_id"
    fi
done

echo "Default applications have been configured."
