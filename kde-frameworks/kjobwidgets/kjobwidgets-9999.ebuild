# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing assorted widgets for showing the progress of jobs"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="nls X"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
RDEPEND="
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	X? ( >=dev-qt/qtx11extras-${QT_MINIMAL}:5 )
"
DEPEND="${RDEPEND}
	X? (
		x11-base/xorg-proto
		x11-libs/libX11
	)
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
