# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Kiriki - a gtali clone for KDE4"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
