# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 versionator

DESCRIPTION=""
HOMEPAGE="http://www.rabbitmq.com/java-client.html"
SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-java-client/v${PV}/rabbitmq-java-client-${PV}.tar.gz"

LICENSE="Apache-2.0 MPL-1.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RESTRICT='primaryuri'


COMMON_DEP=">=dev-java/junit-3.8
    >=dev-java/commons-cli-1.1
    >=dev-java/commons-io-2"

RDEPEND=">=virtual/jre-1.5
    ${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
    app-arch/tar
    <dev-lang/python-3
    ${COMMON_DEP}"

EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET="javadoc"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}"/build.properties.patch
    epatch "${FILESDIR}"/runjava.sh.patch
}

src_install() {
    java-pkg_dojar \
      build/dist/rabbitmq-client.jar \
      build/dist/rabbitmq-client-tests.jar

    use doc && java-pkg_dojavadoc build/doc
    use source && java-pkg_dosrc src

    exeinto /usr/share/${PN}
    doexe build/dist/*.sh
}
