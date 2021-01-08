# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_CATEGORY=utilities
KFMIN=5.74.0
QTMIN=5.15.1
inherit ecm kde.org

DESCRIPTION="Desktop interface to control 3D printers powered by AtCore"
HOMEPAGE="https://atelier.kde.org/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2+"
SLOT="5"
IUSE=""

DEPEND="
	dev-libs/atcore
	>=dev-qt/qt3d-${QTMIN}:5
	>=dev-qt/qtcharts-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5[widgets]
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtserialport-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/ktexteditor-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
# 	>=kde-frameworks/kcoreaddons-${KFMIN}:5
# 	>=kde-frameworks/kguiaddons-${KFMIN}:5
# 	>=kde-frameworks/kcompletion-${KFMIN}:5
# 	>=kde-frameworks/kconfig-${KFMIN}:5
# 	>=kde-frameworks/kio-${KFMIN}:5
# 	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
# 	media-gfx/imagemagick[cxx]
RDEPEND="${DEPEND}"
