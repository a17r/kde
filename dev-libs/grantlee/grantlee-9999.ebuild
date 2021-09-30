# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=5.82.0
QTMIN=5.15.2
VIRTUALX_REQUIRED="test"
inherit ecm git-r3 virtualx

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="https://github.com/steveire/grantlee
https://gitlab.com/kossebau/grantlee"
EGIT_REPO_URI=( "https://gitlab.com/kossebau/${PN}" )

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="doc"

RDEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? ( app-doc/doxygen[dot] )
	test? ( >=dev-qt/linguist-tools-${QTMIN}:5 )
"

src_compile() {
	ecm_src_compile
	use doc && cmake_build docs
}

src_install() {
	use doc && local HTML_DOCS=( "${BUILD_DIR}/apidox/" )
	ecm_src_install
}
