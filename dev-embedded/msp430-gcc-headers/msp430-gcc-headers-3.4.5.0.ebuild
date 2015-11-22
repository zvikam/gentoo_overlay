EAPI="5"

inherit eutils versionator

MY_PV="$(version_format_string '$1.`printf %02d $2`.`printf %02d $3`.`printf %02d $4`')"

TI_PN="msp430-gcc-support-files"
DESCRIPTION="MCU-specific data for MSP430 microcontrollers"
HOMEPAGE="http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
SRC_URI="http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/$(replace_all_version_separators '_' $MY_PV )/exports/${TI_PN}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMONDEP="cross-msp430-elf/binutils
	cross-msp430-elf/gcc"

DEPEND="${COMMONDEP}
	app-arch/unzip
	"

RDEPEND="${COMMONDEP}
        "

src_unpack() {
	echo "${S}" 
	echo "${WORKDIR}"
	mkdir "${S}" || die
	cd "${WORKDIR}" || die
	unpack ${A}

	mkdir "${S}/lib" || die
	mkdir "${S}/doc" || die
	mkdir "${S}/include" || die

	cd "${WORKDIR}/${TI_PN}/" || die
	mv *.ld "${S}/lib/" || die
	mv *.h "${S}/include/" || die
	mv * "${S}/doc/" || die
}

src_install() {
	insinto "/usr/msp430-elf" 
	doins -r "${S}/lib" "${S}/include"
	dodoc ${S}/doc/*
}
