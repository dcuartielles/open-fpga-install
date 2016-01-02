#!/bin/bash
#
# This is a complex installer that allows internationalization
# The goal behind it is allowing as many people getting access to this
# knowledge as possible by giving them the chance to read what is being
# done in their computers in their own language
#
# Please contribute translating the *.po files to as many languages as possible
# I accept pull-requests in exchange for credit
#
# (Copyleft) D. Cuartielles, 2016, GPLv3

##
# POC around i18n/Localization in a bash script
# create the localization files for all available languages
cd locale
source ./generate_translations.sh
cd ..

# initialiaze the global variables needed for your default language
export TEXTDOMAINDIR=locale
export TEXTDOMAIN=install.sh
I18NLIB=libs/i18n-lib.sh

# source in I18N library - shown above
# this is the only message that cannot be translated
if [[ -f $I18NLIB ]]
then
        . $I18NLIB
else
        printf "ERROR - $I18NLIB NOT FOUND"
        exit 1
fi

## Start of script
# clear the screen
clear

# are we root yet? You need to be sudo if you're gonna install things
if [ $(whoami) != 'root' ]; then
        i18n_display "Need to be root"
        # printf "$0"
        exit 1;
fi

## ALLOW USER TO SET LANG PREFERENCE
## assume lang and country code follows
##XXX this part isn't working yet, I comment it away
#if [[ "$1" = "-lang" ]]
#then
#        export LC_ALL="$2_$3.UTF-8"
#fi

# Display initial greeting
printf "\n#######################################################################\n\n"
i18n_display "Greeting"

# Install all dependencies
printf "\n#######################################################################\n\n"
i18n_display "Install dependencies"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  sudo apt-get install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev git
else
  i18n_display "Skipped action"
fi

# create a temporary installation folder
mkdir install.tmp

# Install Icestorm
printf "\n#######################################################################\n\n"
i18n_display "Install icestorm"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  cd install.tmp
  git clone https://github.com/cliffordwolf/icestorm.git icestorm
  cd icestorm
  make -j$(nproc)
  sudo make install
  cd ..
  cd ..
else
  i18n_display "Skipped action"
fi

# Install Arachne-pnr
printf "\n#######################################################################\n\n"
i18n_display "Install arachnepnr"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  cd install.tmp
  git clone https://github.com/cseed/arachne-pnr.git arachne-pnr
  cd arachne-pnr
  make -j$(nproc)
  sudo make install
  cd ..
  cd ..
else
  i18n_display "Skipped action"
fi

# Install Yosys
printf "\n#######################################################################\n\n"
i18n_display "Install yosys"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  cd install.tmp
  git clone https://github.com/cliffordwolf/yosys.git yosys
  cd yosys
  make -j$(nproc)
  sudo make install
  cd ..
  cd ..
else
  i18n_display "Skipped action"
fi

# Install Icarus Verilog
printf "\n#######################################################################\n\n"
i18n_display "Install icarus"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  sudo add-apt-repository ppa:team-electronics/ppa
  sudo apt-get update
  sudo apt-get install iverilog
else
  i18n_display "Skipped action"
fi

# Install GTKWave
printf "\n#######################################################################\n\n"
i18n_display "Install gtkwave"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  sudo apt-get install gtkwave
else
  i18n_display "Skipped action"
fi

# Delete temp files
printf "\n#######################################################################\n\n"
i18n_display "Delete temp files"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm deletion")
if [[ $install == C* ]]; then
  i18n_display "Confirmed action"
  rm -fR install.tmp
else
  i18n_display "Skipped action"
fi

# Download courseware
printf "\n#######################################################################\n\n"
i18n_display "Download courseware"
printf "\n#######################################################################\n\n"
install=$(i18n_prompt "Confirm installation")
if [[ $install == I* ]]; then
  i18n_display "Confirmed action"
  git clone https://github.com/Obijuan/open-fpga-verilog-tutorial.git open-fpga-verilog-tutorial
else
  i18n_display "Skipped action"
fi

# Display final remarks
printf "\n#######################################################################\n\n"
i18n_display "Credits"
printf "\n#######################################################################\n\n"
i18n_display "Copyright"
printf "\n#######################################################################\n\n"

# Install ends here
exit 0
