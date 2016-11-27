#!/bin/sh

if [[ "${DOCKER_DEBUG}" == "1" ]]; then
    set -x
fi

rm -rf /var/opengrok/src
mkdir -p "${SOURCE_DIR}"
ln -s "${SOURCE_DIR}" /var/opengrok/src

rm -rf /var/opengrok/data
mkdir -p "${DATA_DIR}"
ln -s "${DATA_DIR}" /var/opengrok/data

/opt/tomcat/bin/catalina.sh start

indexing_source() {
    echo "indexing"
    /var/opengrok/bin/OpenGrok update
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

interval_indexing() {
    while true; do
        sleep "${INDEXING_DELAY}"
        indexing_source
    done
}

/var/opengrok/bin/OpenGrok index "${SOURCE_DIR}"
indexing_git_source
indexing_tar_source
indexing_tgz_source
indexing_zip_source
interval_indexing &

tail -f /var/opengrok/log/opengrok0.0.log

