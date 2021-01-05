#!/bin/sh
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Release Service."
	echo
	echo "Based on the kde-release-service-live set, this script performs a full version bump"
	echo "of a new unreleased KDE Release Service."
	echo
	echo "In addition to the new ebuild being created, the following operations are performed:"
	echo
	echo "* Creation of versioned set"
	echo "* Creation of package.mask entry"
	echo "* Eclass modification to mark as unreleased"
	echo "* Generation of package.* files in Documentation"
	echo
	echo "Usage: release-service-bump.sh <version>"
	echo "Example: release-service-bump.sh 20.12.2"
	exit 0
}

if [[ $1 == "--help" ]] ; then
	help
fi

VERSION="${1}"

if [[ -z "${VERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

major_version=$(echo ${VERSION} | cut -d "." -f 1-2)
kfv="kde-release-service-${VERSION}"
kfmv="kde-release-service-${major_version}"

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -e sets/kde-release-service-${major_version} ]]; then
	bump_set_from_live kde-release-service ${major_version}
	create_keywords_files ${kfmv}
	sed -i -e "/SERVICE_RELEASES/s/\"$/ ${major_version}\"/" Documentation/maintainers/regenerate-files
	Documentation/maintainers/regenerate-files
fi
mask_from_set kde-release-service-${major_version} ${VERSION} ${kfv}
mark_unreleased kde-apps-${VERSION}

bump_packages_from_set kde-release-service-${major_version} ${major_version}.49.9999 ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
