# Copyright 2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"
inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Logic Analyzer Client from sump.org"
HOMEPAGE="http://sump.org/projects/analyzer/"
SRC_URI="http://sump.org/projects/analyzer/downloads/la-src-${PV}-test-s3e.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/rxtx:2"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND="app-arch/unzip
	>=virtual/jdk-1.5
	${COMMON_DEP}"

S="${WORKDIR}/LogicAnalyzer-release/client"

JAVA_SRC_DIR="org/sump"
JAVA_ENCODING="ISO-8859-1"
JAVA_GENTOO_CLASSPATH="rxtx-2"

src_compile() {
	mkdir -p target/classes/META-INF || die "Could not create target directory"
	mkdir -p target/classes/org/sump/analyzer/icons || die "Could not create target directory"
	cp Manifest.txt target/classes/META-INF/MANIFEST.MF
	cp org/sump/analyzer/icons/*.png target/classes/org/sump/analyzer/icons/
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher
}
