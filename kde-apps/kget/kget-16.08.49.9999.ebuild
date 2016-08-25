# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="An advanced download manager by KDE"
HOMEPAGE="https://www.kde.org/applications/internet/kget/"
KEYWORDS=""
IUSE="debug bittorrent gpg mms sqlite webkit"

COMMON_DEPEND="
	$(add_kdeapps_dep libkonq)
	$(add_kdebase_dep libkworkspace '' 4.11)
	app-crypt/qca:2[qt4]
	bittorrent? ( >=net-libs/libktorrent-1.0.3:4 )
	gpg? ( || ( $(add_kdeapps_dep gpgmepp) $(add_kdeapps_dep kdepimlibs) ) )
	mms? ( media-libs/libmms )
	sqlite? ( dev-db/sqlite:3 )
	webkit? ( >=kde-misc/kwebkitpart-0.9.6:4 )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdeapps_dep kcmshell '' 16.04.3)
	$(add_kdeapps_dep solid-runtime)
"

src_configure() {
	local mycmakeargs=(
		-DWITH_NepomukCore=OFF
		-DWITH_NepomukWidgets=OFF
		-DWITH_KTorrent=$(usex bittorrent)
		-DWITH_QGpgme=$(usex gpg)
		-DWITH_LibMms=$(usex mms)
		-DWITH_Sqlite=$(usex sqlite)
		-DWITH_KWebKitPart=$(usex webkit)
	)

	kde4-base_src_configure
}
