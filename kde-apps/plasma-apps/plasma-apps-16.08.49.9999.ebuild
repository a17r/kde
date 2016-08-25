# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KMNAME="kde-baseapps"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep solid-runtime)
"
