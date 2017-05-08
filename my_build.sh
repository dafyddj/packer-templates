#!/bin/bash

DEBUG_OPTS=
if [ "${DEBUG:-false}" = "true" ]; then
  set -x # Run the entire script in debug mode
  DEBUG_OPTS="-on-error=ask"
fi

serial="serial.box"
if [ ! -e "$serial" ] ; then
  old=1
  echo $old >$serial
else
  old=$(<$serial)
  new=$((old+1))
  sed -i '' -e "s/$old\$/$new/" $serial
fi

VERSION="$(date +%Y.%-m).$old"

ISO=/Volumes/256Gb/Downloads/iso/Win10_1703_EnglishInternational_x64.iso
ISO_SUM=a73f174bcfd1d260285264b2e437a124
OUTPUT_DIR=/Volumes/256Gb/output-

START=$(date)
packer build $DEBUG_OPTS -force -var "output_directory=$OUTPUT_DIR" -var "iso_url=$ISO" -var "iso_checksum=$ISO_SUM" -var "headless=false" -var "version=$VERSION" vbox-win10.json
echo $START
date
