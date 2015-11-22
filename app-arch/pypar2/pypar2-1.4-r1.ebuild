# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="PyPar2"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="PyPar2 is a graphical frontend for the Linux par2 command line, written in Python."
HOMEPAGE="http://pypar2.silent-blade.org"
SRC_URI="http://pypar2.silent-blade.org/uploads/Main/pypar2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-arch/par2cmdline
        dev-lang/python
        dev-python/pycairo
        dev-python/pyxml
        x11-libs/vte"

src_install() {
    cd "${S}"
    make DESTDIR="${D}" prefix="/usr" install || die "install failed"
}
