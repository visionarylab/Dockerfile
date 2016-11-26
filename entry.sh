#!/bin/sh

if [[ "${DOCKER_DEBUG}" == "1" ]]; then
    set -x
fi

mkdir -p "${SOURCE_DIR}"
ln -s "${SOURCE_DIR}" /var/opengrok/src

/opt/tomcat/bin/catalina.sh start

function get_git_source() {
    for i in $(echo "${GIT_SOURCE}" | tr ";" "\n"); do
        git clone "$i" "${SOURCE_DIR}"
    done
}

function get_tar_source() {
    for i in $(echo "${TAR_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.tar $i
        tar -C "${SOURCE_DIR}" -xvf /tmp/source.tar
    done
    rm /tmp/source.tar
}

function get_tgz_source() {
    for i in $(echo "${TGZ_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.tar.gz $i
        tar -C "${SOURCE_DIR}" -xvf /tmp/source.tar.gz
    done
    rm /tmp/source.tar.gz
}

function get_zip_source() {
    for i in $(echo "${ZIP_SOURCE}" | tr ";" "\n"); do
        wget -O /tmp/source.zip $i
        unzip -d "${SOURCE_DIR}" /tmp/source.zip
    done
    rm /tmp/source.zip
}

get_git_source &
get_tar_source &
get_tgz_source &
get_zip_source &

while true; do
    echo "indexing"
    OpenGrok index "${SOURCE_DIR}"
    sleep "${INDEX_DELAY}"
done
