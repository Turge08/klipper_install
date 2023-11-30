#!/usr/bin/env bash
set -e

KIAUH_SRCDIR="$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/kiauh"
for script in "${KIAUH_SRCDIR}/scripts/"*.sh; do . "${script}"; done
for script in "${KIAUH_SRCDIR}/scripts/ui/"*.sh; do . "${script}"; done

#cd ./kiauh
check_euid
init_logfile
set_globals
start_klipper_setup
moonraker_setup_dialog
install_fluidd
install_klipperscreen
CROWSNEST_UNATTENDED="1"
install_crowsnest
setup_gcode_shell_command

~/klippy-env/bin/pip install -v numpy


## Katapult
cd ~
git clone https://github.com/Arksine/katapult

## Klipper LED Effect
cd ~
git clone https://github.com/julianschill/klipper-led_effect
cd ~/klipper-led_effect
./install-led_effect.sh

## Klipper Print Settings
cd ~
git clone https://github.com/Turge08/klipper_print_setting
cd ~/klipper_print_setting
./install.sh

## Klipper Macros
cd ~
git clone https://github.com/Turge08/klipper_macros

## Klipper TMC Autotune
cd ~
git clone https://github.com/andrewmcgr/klipper_tmc_autotune
./install.sh

## Can Bus
sudo cp $KIAUH_SRCDIR/resources/can0 /etc/network/interfaces.d/can0

## Nunpy
sudo apt install python3-numpy python3-matplotlib libatlas-base-dev

sudo ip link set up can0 type can bitrate 1000000
pip3 install pyserial
sudo systemctl restart klipper


