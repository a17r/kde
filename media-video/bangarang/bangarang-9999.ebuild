# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="Media player based on KF5"
HOMEPAGE="http://bangarangkde.wordpress.com"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/phonon[qt5(+)]
	media-libs/taglib
	!media-video/bangarang:4
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
