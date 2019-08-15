# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for managing bookmarks stored in XBEL format"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
RDEPEND="
	>=kde-frameworks/kcodecs-${PVCUT}:5
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=kde-frameworks/kxmlgui-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
"
DEPEND="${RDEPEND}
	>=kde-frameworks/kconfigwidgets-${PVCUT}:5
"
