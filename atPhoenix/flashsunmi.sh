#!/bin/bash
fastboot flash system_a system.img
fastboot flash system_b system.img
fastboot flash boot_a boot.img
fastboot flash boot_b boot.img
fastboot flash vendor_a vendor.img
fastboot flash vendor_b vendor.img
fastboot flash xbl_a xbl.elf
fastboot flash xbl_b xbl.elf
fastboot flash abl_a abl.elf
fastboot flash abl_b abl.elf
fastboot erase userdata
