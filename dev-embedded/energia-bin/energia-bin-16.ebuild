# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="electronics prototyping platform for Texas Instruments MSP430 LaunchPad"
HOMEPAGE="http://energia.nu/"
MY_PN=${PN/-bin}
MY_P=${MY_PN}-0101E00${PV}
SRC_URI="amd64? ( http://energia.nu/downloads/downloadv3.php?file=${MY_P}-linux64.tgz -> ${P}-amd64.tar.gz )
	x86? ( http://energia.nu/downloads/downloadv3.php?file=${MY_P}-linux.tgz -> ${P}-x86.tar.gz )"

LICENSE="GPL LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

RESTRICT="binchecks strip"

src_install() {
	dodoc revisions.txt
	rm -r __MACOSX || die

	newicon lib/${MY_PN}_48.png ${MY_PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN}

	insinto "/opt/${MY_PN}"
        doins -r *
	# restore executable permissions
	for ee in `find . -type f -executable -print`; do
		fperms +x "/opt/${MY_PN}/${ee}"
	done
        dosym "/opt/${MY_PN}/energia" "/usr/bin/${MY_PN}"
}
