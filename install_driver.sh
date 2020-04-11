#!/bin/bash

DEPENDENCIES=('libcupsimage2:i386' 'libstdc++6:i386')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DRIVER_TEMP="${DIR}""/.temp-driver"
DRIVER_ZIP="${DIR}""/xerox-phaser-6000.zip"
DRIVER_URL="https://www.support.xerox.com/support/phaser-6000/file-redirect/engb.html?operatingSystem=linux&fileLanguage=en_GB&contentId=116065"

function finish {
    rm $DRIVER_ZIP 2>/dev/null
    rm -rf $DRIVER_TEMP 2>/dev/null
}
trap finish EXIT

echo "Downloading driver"
wget -O "${DRIVER_ZIP}" "${DRIVER_URL}" || { echo "Download of Xerox driver failed."; exit 1; }
mkdir -p "${DRIVER_TEMP}" || { echo "Could not create a temporary directory for installation at ${DRIVER_TEMP}"; exit 1; }
unzip -q "${DRIVER_ZIP}" -d "${DRIVER_TEMP}" || { echo "Error unzipping ${DRIVER_ZIP}"; exit 1; }

DRIVER=$(find "$DRIVER_TEMP" -type f -name "*.deb")
if [ -z "$DRIVER" ]; then
    echo "${DRIVER} could not be found".
    exit 1
fi

echo "Installing driver dependencies"
for dep in $DEPENDENCIES; do
  apt-get install -y "$dep" || { echo "apt-get install $dep failed"; echo "Did you run with sudo?"; echo "If not run 'sudo !!'"; exit 1; }
done

echo "Installing driver"
dpkg -i "$DRIVER" || { echo "dpkg -i $DRIVER failed"; echo "Did you run with sudo?"; echo "If not run 'sudo !!'"; exit 1; }

echo "Driver Install Successful!"

exit 0

