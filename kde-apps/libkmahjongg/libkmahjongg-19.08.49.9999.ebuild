# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Mahjongg library based on Qt/KDE Frameworks"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"
