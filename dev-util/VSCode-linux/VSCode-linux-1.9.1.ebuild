# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="amd64? ( http://go.microsoft.com/fwlink/?LinkID=620884 -> ${PN}-${PV}-x64.tar.gz )
	 x86? ( http://go.microsoft.com/fwlink/?LinkID=620885 -> ${PN}-${PV}-ia32.tar.gz )
        "

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	"
RDEPEND="${DEPEND}"

pkg_setup() {
    if use amd64 ; then
	export S="${WORKDIR}/${PN}-x64"
    elif use x86 ; then
        export S="${WORKDIR}/${PN}-ia32"
    else
	eerror "unknown architecture"
    fi
}

src_install(){
        make_desktop_entry ${PN}
        newicon resources/app/resources/linux/code.png ${PN}.png

	insinto "/opt/${PN}"
	doins -r *
        # restore executable permissions
        for ee in `find . -type f -executable -print`; do
                fperms +x "/opt/${PN}/${ee}"
        done
	dosym "/opt/${PN}/bin/code" "/usr/bin/${PN}"
	#fperms +x "/opt/${PN}/Code"
	#fperms +x "/opt/${PN}/libchromiumcontent.so"
	#fperms +x "/opt/${PN}/libffmpegsumo.so"
	#fperms +x "/opt/${PN}/libgcrypt.so.11"
	#fperms +x "/opt/${PN}/libnotify.so.4"
	#fperms +x "/opt/${PN}/resources/app/tools/bin/linux/x64/node"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
