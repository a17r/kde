# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Interface to work with Graph Theory"
HOMEPAGE="https://kde.org/applications/education/rocs
https://edu.kde.org/applications/mathematics/rocs"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktexteditor-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtscript-${QT_MINIMAL}:5[scripttools]
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwebkit-5.212.0_pre20180120:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	>=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5
	dev-libs/grantlee:5
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.49
"

RESTRICT+=" test"	# 1/10 tests currently fails
