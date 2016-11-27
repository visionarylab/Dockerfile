#!/bin/sh

if [[ "${DOCKER_DEBUG}" == "1" ]]; then
    set -x
fi

rm -rf /var/opengrok/src
mkdir -p "${SOURCE_DIR}"
ln -s "${SOURCE_DIR}" /var/opengrok/src

indexing_source() {
    echo "indexing"
    /var/opengrok/bin/OpenGrok index "${SOURCE_DIR}"
}

indexing_git_source() {
    for i in $(echo "${GIT_SOURCE}" | tr ";" "\n"); do
        git clone --depth=1 "$i" "${SOURCE_DIR}"
        indexing_source
    done
}

indexing_tar_source() {
    for i in $(echo "${TAR_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.tar $i
        tar -C "${SOURCE_DIR}" -xvf /tmp/source.tar
        indexing_source
    done
    [ -e /tmp/source.tar ] && rm /tmp/source.tar
}

indexing_tgz_source() {
    for i in $(echo "${TGZ_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.tar.gz $i
        tar -C "${SOURCE_DIR}" -xvf /tmp/source.tar.gz
        indexing_source
    done
    [ -e /tmp/source.tar.gz ] && rm /tmp/source.tar.gz
}

indexing_zip_source() {
    for i in $(echo "${ZIP_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.zip $i
        unzip -d "${SOURCE_DIR}" /tmp/source.zip
        indexing_source
    done
    [ -e /tmp/source.zip ] && rm /tmp/source.zip
}

init_source() {
    indexing_source
    indexing_git_source
    indexing_tar_source
    indexing_tgz_source
    indexing_zip_source
}


if [ "${ASYNC_MODE}" = "0" ]; then
    init_source
else
    init_source &
fi

/opt/tomcat/bin/catalina.sh run
