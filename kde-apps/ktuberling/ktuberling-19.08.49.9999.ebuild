# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_SELINUX_MODULE="games"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Potato game for kids by KDE"
HOMEPAGE="
	https://kde.org/applications/games/ktuberling/
	https://games.kde.org/game.php?game=ktuberling
"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/libkdegames-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtmultimedia-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	media-libs/phonon[qt5(+)]
"
RDEPEND="${DEPEND}"
