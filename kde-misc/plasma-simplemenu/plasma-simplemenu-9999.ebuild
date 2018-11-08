# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_CATEGORY="plasma"
ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
inherit ecm kde.org

DESCRIPTION="Simplified menu for KDE Plasma"
HOMEPAGE="https://store.kde.org/p/1169537/
https://blogs.kde.org/2017/01/30/simple-menu-launcher-kde-store"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	kde-frameworks/plasma:5
"
RDEPEND="${DEPEND}
	kde-plasma/plasma-desktop:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
"
