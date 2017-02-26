# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_AUTODEPS="false"
KDE_HANDBOOK="forceoptional"
PYTHON_COMPAT=( python3_5 )
inherit python-single-r1 kde5

DESCRIPTION="The classical Mah Jongg for four players"
HOMEPAGE="https://www.kde.org/applications/games/kajongg/"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	$(add_frameworks_dep extra-cmake-modules)
	$(add_frameworks_dep kconfig)
	$(add_kdeapps_dep libkdegames)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	dev-db/sqlite:3
	dev-python/PyQt5[gui,svg,widgets,${PYTHON_USEDEP}]
	>=dev-python/twisted-16.6.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep libkmahjongg)
	!kde-apps/kajongg:4
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_prepare() {
	python_fix_shebang src
	kde5_src_prepare
	sed -i -e "/PYTHON_MIN_VERSION/s/\"[0-9.]*\"/\"3.4.0\"/" CMakeLists.txt || die
	sed -i -e "/KDE_ADD_PYTHON_EXECUTABLE/s/^/#DONT/" CMakeLists.txt || die
}

src_install() {
	kde5_src_install
	dosym /usr/share/kajongg/kajongg.py /usr/bin/kajongg
	dosym /usr/share/kajongg/kajonggserver.py /usr/bin/kajonggserver
	fperms a+x /usr/share/kajongg/kajongg{,server}.py
}
