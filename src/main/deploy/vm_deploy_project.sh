#!/usr/bin/env bash
function crms_echo
{
    echo "`date \"+%Y-%m-%d %H:%M:%S\"` : $*" 2>&1
}

crms_echo --------------------------
crms_echo Deploiement du module
crms_echo --------------------------

PWD2=${PWD}
crms_echo "PWD = ${PWD2}"

PROJECT_HOME=${PWD2}/../../..
PROJECT_HOME=$(readlink -f ${PROJECT_HOME})
crms_echo "PROJECT_HOME = ${PROJECT_HOME}"

POM_FILE=${PROJECT_HOME}/pom.xml
ARTIFACTID=$(cat ${POM_FILE} | grep -oPm1 "(?<=<artifactId>)[^<]+")
VERSION=$(cat ${POM_FILE} | grep -oPm1 "(?<=<version>)[^<]+")

crms_echo "ARTIFACTID = ${ARTIFACTID}"
crms_echo "VERSION = ${VERSION}"

JARTEMPLATE="${ARTIFACTID}-${VERSION}.jar"
JARFOUND=`find ${PROJECT_HOME}/target -name ${JARTEMPLATE} -print -quit`

crms_echo "Jar existant: ${JARFOUND}"

USER_PATH=${PWD2}/../../../../..
USER_PATH=$(readlink -f ${USER_PATH})

cd ${USER_PATH}/Documents/Virtual\ Machines
crms_echo "Position: ${PWD}"
crms_echo "Repertoire des VM: ${USER_PATH}/Documents/Virtual\ Machines"
ls ${USER_PATH}/Documents/Virtual\ Machines

SYNC_FOLDER="shared_folder"
crms_echo "Repertoire partage: ${SYNC_FOLDER}"

if [[ ! -d "$SYNC_FOLDER" ]]
then
  crms_echo "Le repertoire: ${SYNC_FOLDER} n'existe pas."
  crms_echo --------------------------
  crms_echo Deploiement JAR : ERROR
  crms_echo --------------------------
  exit 3
fi

crms_echo "Copie du fichier JAR: ${JARFOUND} vers ${SYNC_FOLDER}"
cp ${JARFOUND} ${SYNC_FOLDER}
CR=${?}
crms_echo Code retour copie: ${CR}
crms_echo --------------------------
crms_echo Deploiement JAR : TERMINE
crms_echo --------------------------
