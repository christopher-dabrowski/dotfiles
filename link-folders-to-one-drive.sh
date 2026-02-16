#!/usr/bin/env bash
set -euo pipefail

# Replace selected $HOME folders with symlinks to their OneDrive counterparts.
#
# The operation is intentionally idempotent:
# - If the source is already a symlink: skip.
# - If the OneDrive target directory doesn't exist: skip.
# - Otherwise: remove the existing source (dir/file) and create a symlink.
#
# WARNING: This deletes the local source folder when it is not a symlink.

home_dir="${HOME:?HOME is not set}"

onedrive_personal="${home_dir}/Library/CloudStorage/OneDrive-Personal"
if [[ ! -d "${onedrive_personal}" ]]; then

	echo "OneDrive folder not found: ${onedrive_personal}" >&2
	echo "Nothing to do." >&2
	exit 0
fi

# Format: "<source>|<target>"
# Adjust the device-specific path segment (e.g. Computers/SmallMacPro) if needed.
pairs=(
	"${home_dir}/Desktop|${onedrive_personal}/Computers/SmallMacPro/Desktop"
	"${home_dir}/Documents|${onedrive_personal}/Documents"
	"${home_dir}/Music|${onedrive_personal}/Music",
	"${home_dir}/Pictures|${onedrive_personal}/Pictures",
)

ensure_safe_source_path() {
	local src="$1"

	if [[ -z "${src}" || "${src}" == "/" || "${src}" == "${home_dir}" || "${src}" == "${home_dir}/" ]]; then
		echo "Refusing to operate on unsafe source path: ${src}" >&2
		exit 1
	fi

	if [[ "${src}" != "${home_dir}/"* ]]; then
		echo "Refusing to operate on path outside HOME: ${src}" >&2
		exit 1
	fi
}

for pair in "${pairs[@]}"; do
	src="${pair%%|*}"
	dst="${pair#*|}"

	if [[ -L "${src}" ]]; then
		echo "SKIP (already symlink): ${src}"
		continue
	fi

	if [[ ! -d "${dst}" ]]; then
		echo "SKIP (OneDrive target missing): ${dst}"
		continue
	fi

	ensure_safe_source_path "${src}"

	if [[ -e "${src}" ]]; then
		echo "REMOVE: ${src}"
		rm -rf "${src}"
	else
		echo "SOURCE MISSING (will create link): ${src}"
	fi

	echo "LINK: ${src} -> ${dst}"
	ln -s "${dst}" "${src}"
done

echo "Done."
