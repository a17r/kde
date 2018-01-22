# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
KDE_ORG_CATEGORY="utilities"
inherit ecm kde.org

DESCRIPTION="Framework for application secrets management"
HOMEPAGE="https://invent.kde.org/utilities/ksecrets
https://community.kde.org/KDE_Utils/ksecretsservice"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=app-crypt/qca-2.3.0:2
	dev-libs/libgcrypt:=
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kservice:5
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	ecm_src_configure
}
