#!/bin/sh
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Simple tool to bump a KDE product set (currently 'gear' or 'plasma')"
	echo
	echo "Given a product name, copies the live set (and any subsets) to the"
	echo "new set version and updates the package versions appropriately."
	echo
	echo "In addition to the new set being created, package.* files will be"
	echo "generated in Documentation directory."
	echo
	echo "Usage: productset-bump.sh <productname> <version>"
	echo "Example: productset-bump.sh gear 21.04"
	exit 0
}

products() {
	echo "Supported input for KDE products:"
	echo "- gear"
	echo "- plasma"
}

if [[ ${1} == "--help" ]] ; then
	help
fi

productname="${1}"
version="${2}"

if [[ -z "${productname}" || -z "${version}" ]] ; then
	echo "ERROR: Not enough arguments"
	echo
	help
fi

case "${productname}" in
	gear|plasma)
		productname_uc="${productname^^}"
		productname="kde-${productname}"
		;;
	*)
		echo "ERROR: ${productname} unknown"
		echo
		products
		exit 0
		;;
esac

pushd "${TARGET_REPO}" > /dev/null

echo "Creating ${productname}-${version}..."
bump_set_from_live ${productname} ${version}
echo
echo "Regenerating documentation..."
create_keywords_files ${productname}-${version}
sed -i -e "/${productname_uc}_RELEASES/s/\"$/ ${version}\"/" Documentation/maintainers/regenerate-files
Documentation/maintainers/regenerate-files

popd > /dev/null
