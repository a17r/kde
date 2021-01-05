#!/bin/sh
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Gear."
	echo
	echo "Based on the corresponding KDE Gear major release set, this script"
	echo "performs a full version bump of a new unreleased KDE Gear."
	echo
	echo "In addition to the new ebuild being created, the following operations"
	echo "are performed:"
	echo
	echo "* Creation of package.mask entry"
	echo "* Eclass modification to mark as unreleased"
	echo
	echo "Usage: gear-bump.sh <version>"
	echo "Example: gear-bump.sh 21.04.0"
	exit 0
}

if [[ $1 == "--help" ]] ; then
	help
fi

version="${1}"

if [[ -z "${version}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

major_version=$(echo ${version} | cut -d "." -f 1-2)

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -e sets/kde-gear-${major_version} ]]; then
	echo "ERROR: kde-gear-${major_version} not found!"
	echo "Must first create matching KDE Gear set using productset-bump.sh"
	echo
	exit 0
fi

if [[ ${version} == *49.9999 ]]; then
	source_version=9999
else
	source_version=${major_version}.49.9999
	sed -i -e "/GEAR_RELEASES/s/\"$/ ${major_version}\"/" Documentation/maintainers/regenerate-files
	mask_from_set kde-gear-${major_version} ${version} kde-gear-${version}
	mark_unreleased kde-apps-${version}
fi

bump_packages_from_set kde-gear-${major_version} ${source_version} ${version}
commit_packages kde-gear-${major_version} "${version} version bump"

popd > /dev/null
