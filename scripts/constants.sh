#!/usr/bin/env bash

# Ensure script is sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && exit 1

# List of supported devices
declare -ra SUPPORTED_DEVICES=("bullhead" "flounder" "angler" "sailfish" "marlin")

# URLs to download factory images from
readonly NID_URL="https://google.com"
readonly GURL="https://developers.google.com/android/nexus/images"
readonly TOSURL="https://developers.google.com/profile/acknowledgeNotification"

# oatdump dependencies URLs as compiled from AOSP matching API levels
readonly L_OATDUMP_URL_API23='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21490&authkey=ACA4f4Zvs3Tb_SY'
readonly D_OATDUMP_URL_API23='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21493&authkey=AJ0rWu5Ci8tQNLY'
readonly L_OATDUMP_URL_API24='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21492&authkey=AE4uqwH-THvvkSQ'
readonly D_OATDUMP_URL_API24='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21491&authkey=AHvCaYwFBPYD4Fs'
readonly L_OATDUMP_URL_API25='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21503&authkey=AKDpBAzhzum6d7w'
readonly D_OATDUMP_URL_API25='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21504&authkey=AC5YFNSAZ31-W3o'
readonly L_OATDUMP_URL_API26='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21557&authkey=AG47qhXu164sYwc'
readonly D_OATDUMP_URL_API26='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21561&authkey=ABu-oqJbQDwQ-ZQ'

# sub-directories that contain bytecode archives
declare -ra SUBDIRS_WITH_BC=("app" "framework" "priv-app" "overlay/Pixel")

# Files to skip from vendor partition when parsing factory images (for all configs)
declare -ra VENDOR_SKIP_FILES=(
  "build.prop"
  "compatibility_matrix.xml"
  "default.prop"
  "etc/NOTICE.xml.gz"
  "etc/wifi/wpa_supplicant.conf"
  "manifest.xml"
)

# Files to skip from vendor partition when parsing factory images (for naked config only)
declare -ra VENDOR_SKIP_FILES_NAKED=(
  "etc/selinux/nonplat_file_contexts"
  "etc/selinux/nonplat_hwservice_contexts"
  "etc/selinux/nonplat_mac_permissions.xml"
  "etc/selinux/nonplat_property_contexts"
  "etc/selinux/nonplat_seapp_contexts"
  "etc/selinux/nonplat_sepolicy.cil"
  "etc/selinux/nonplat_service_contexts"
  "etc/selinux/plat_sepolicy_vers.txt"
  "etc/selinux/precompiled_sepolicy"
  "etc/selinux/precompiled_sepolicy.plat_and_mapping.sha256"
  "etc/selinux/vndservice_contexts"
)

declare -ra PIXEL_AB_PARTITIONS=(
  "aboot"
  "apdp"
  "bootlocker"
  "cmnlib32"
  "cmnlib64"
  "devcfg"
  "hosd"
  "hyp"
  "keymaster"
  "modem"
  "pmic"
  "rpm"
  "tz"
  "xbl"
)
