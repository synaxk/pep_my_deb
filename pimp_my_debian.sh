#!/bin/bash
#
# The purpose of this script is to automate the installation of various tools
# and configuration files on debian12 stable.

green='\e[1;32m'
yellow='\e[1;93m'
red='\e[1;31m'
rst='\e[0m'

print_header(){
    # split base64 string into multiple lines for the script
    # cat pmd_ascii.txt| fold -w 80 | awk '{print "logo+=\""$0"\""}'
    logo+="CgobWzE7MzdtX19fX19fX18gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX18g"
    logo+="ICAgICAgX19fICAgICAgICAgICAKG1sxOzM3bWAjIyMjIyMjI2AgG1szMW0gLCMuICAgICAgICAgICAg"
    logo+="ICAgICAgICAgICAgICAgICAgICAbWzM3bWAjIy4gICAgIC4jIycgICAgICAgICAgIAobWzE7MzdtICMj"
    logo+="ICAgIGAjYCAbWzMxbTojIyM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIBtbMzdtICMjIy4g"
    logo+="ICAsIyMjICAgICAgICAgICAgChtbMTszN20gIyMgICAgICMjIBtbMzFtIGAjJxtbMzdtX19fICBfXyAg"
    logo+="ICBfXyAgIF9fIF9fX18gICAgICAgICAgIyMjLiAgICMnIyMgX19fXyAgICBfX18KG1sxOzM3bSAjIyAg"
    logo+="ICAgIyMgYCMjIGAjIyAjIyNiICAjIyNiICBgIyMjIyMjLiAgICAgICAgICMjIyMuICwjICMjIGAjIyAg"
    logo+="ICAgICMnChtbMTszN20gIyMgICAgLiMsICAjIyAgIyMjIyBgIyMjIyBgI2IgICMjJyAgYCMuICAgICAg"
    logo+="ICAjI2AjLiAjJyAjIyAgYCMuICAgICMnIAobWzE7MzdtICMjIyMjIyMsJyAgIyMgICMjJyAgICMjJyAg"
    logo+="ICMjICAjIyAgICAjIyAgICAgICAgIyMgYCMuIyAgIyMgICBgIy4gICwjICAKG1sxOzM3bSAjIyAgICAg"
    logo+="ICAgICMjICAjIyAgICAjIyAgICAjIyAgIyMgICAgIyMgICAgICAgICMjIGAjIycgICMjICAgICMjICAj"
    logo+="ICAgChtbMTszN20gIyMgICAgICAgICAjIyAgIyMgICAgIyMgICAgIyMgICMjICAgICMjICAgICAgICAj"
    logo+="IyAgIyMgICAjIyAgICBgIyMjJyAgIAobWzE7MzdtICMjICAgICAgICAgIyMgICMjICAgICMjICAgICMj"
    logo+="ICAjIy4gICwjLCAgICAgICAgIyMgIGAnICAgIyMgICAgIGAjtCAgICAKG1sxOzM3bV8jI18gICAgICAg"
    logo+="XyMjX18jI18gIF8jI18gIF8jI18gIyNZIyMjLCAgICAgICAgXyMjXyAgICAgXyMjXyAgICAgIyAgICAg"
    logo+="ChtbMTszMW0gICAgICAgIF8sbWV0JCQkJCRnZy4gICAgICAbWzM3bSAgICAgIyMgICAgICAgICAgICAg"
    logo+="ICAgICAgICAgICAgICAgICAjJyAgICAgICAgICAgICAgICAgICAgICAgIAobWzE7MzFtICAgICAsZyQk"
    logo+="JCQkJCQkJCQkJCQkJFAuICAgG1szN20gICAgICMjICAgICAgICAgICAgICAgICAgICAgICAgICAjIy4s"
    logo+="IyAgICAgICAgICAgICAgICAgICAgICAgICAKG1sxOzMxbSAgICxnJCRQIiIgICAgICAgIiIiWSQkLiIu"
    logo+="IBtbMzdtICAgIF8jI18gICAgICAgICAgICAgICAgICAgICAgICAgICMjIyAgICAgICAgICAgICAgICAg"
    logo+="ICAgICAgICAgChtbMTszMW0gICwkJFAnICAgICAgICAgICAgICBgJCQkLiAbWzM3bSAgICAgICAgICAg"
    logo+="ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgChtbMTszMW0nLCQkUCAgICAg"
    logo+="ICAsZ2dzLiAgICAgYCQkYjobWzM3bSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg"
    logo+="ICAgICAgICAgICAgICAgChtbMTszMW1gZCQkJyAgICAgLCRQIicgICAuICAgICQkJCAbWzM3bSAgICAg"
    logo+="ICAgICAgICAgICAgICAgICAgICAgICAgG1szMW0gLCMuICAgICAgICAgICAgICAgICAgICAKG1sxOzMx"
    logo+="bSAkJFAgICAgICBkJCcgICAgICwgICAgJCRQIBtbMzdtICAgICAjIzogICAgICAgICAgOiMjICAgICAg"
    logo+="ICAbWzMxbTojIyM6ICAgICAgICAgICAgICAgICAgIAobWzE7MzFtICQkOiAgICAgICQkLiAgIC0gICAg"
    logo+="LGQkJCcgG1szN20gICAgICMjJyAgICAgICAgICBgIyMgICAgICAgIBtbMzFtIGAjJyAgICAgICAgICAg"
    logo+="ICAgICAgICAgChtbMTszMW0gJCQ7ICAgICAgWSRiLl8gICBfLGQkUCcgG1szN20gICBfXyAgIyMgICAg"
    logo+="IF9fICAgICAjIyAgX18gICAgICBfICAgICBfXyAgICAgICAgICBfICAgChtbMTszMW0gWSQkLiAgICBg"
    logo+="LmAiWSQkJCRQIicgICAgG1szN20gLCMjIyM6IyMgICwjIyMjIyMuICAjIy4jIyMjIy4gOiMjIyAsIyMj"
    logo+="IyMjLiAjIyMuIyMjIzogChtbMTszMW0gYCQkYiAgICAgICItLl9fICAgICAgICAgG1szN20sIyMnIGAj"
    logo+="IyMgICMjOiAgOiMjICAjIyMnIGAjIyMgICMjJyAjOiAgIGAjIyBgIyMjJyBgIyM6ChtbMTszMW0gIGBZ"
    logo+="JCRiICAgICAgICAgICAgICAgICAgG1szN20jIyAgICBgIyMgICMjICAgICMjICAjIycgICBgIyMgICMj"
    logo+="ICAgIF9fXywjIyAgIyM6ICAgYCMjChtbMTszMW0gICBgWSQkLiAgICAgICAgICAgICAgICAgG1szN20j"
    logo+="IyAgICAgIyMgICMjIyMjIyM6ICAjIyAgICAgIyMgICMjICAuIyMjIyMjIyAgIyMnICAgICMjChtbMTsz"
    logo+="MW0gICAgIGAkJGIuICAgICAgICAgICAgICAgG1szN20jIyAgICAgIyMgICMjJyAgICAgICAjIyAgICAg"
    logo+="IyMgICMjICAjIycgIGAjIyAgIyMgICAgICMjChtbMTszMW0gICAgICAgYFkkJGIuICAgICAgICAgICAg"
    logo+="G1szN20jIy4gICAsIyMgICMjICAgICAgICAjIyAgICAsIyMgICMjICAjIyAgICAjIyAgIyMgICAgICMj"
    logo+="ChtbMTszMW0gICAgICAgICBgIlkkYi5fICAgICAgICAgG1szN206IzouXywjIyMgICMjOl9fLCMjICAj"
    logo+="IzpfXywjIycgLCMjLiAjIy5fXzojIy4gIyMgICAgICMjChtbMTszMW0gICAgICAgICAgICAgYCIiIiIg"
    logo+="ICAgICAgG1szN21gOiMjIyMgIyMjICAjIyMjIyMnICBgIyMjIyMjJyAgIyMjIyBgIyMjIyMiIyMgIyMg"
    logo+="ICAgICMjCg=="
    echo $logo | base64 -d
    echo -e "$rst"

}

print_help(){
    echo "Pimp my debian is a script to automate the installation and customization"
    echo "of various tools on my debian 12.6 stable installation."

    echo -e "Usage:\n\tsudo ./pimp_my_debian.sh [options]\n"
    echo -e "Options:\n\t-h, --help\tDisplay this help page."
    echo -e "\t-s, --standard\tInstall standard tools like Firefox, vim,.."
    echo -e "\t-i, --i3wm\tInstall the i3 window manager and other tools for customization."
    echo -e "\t-p, --pentest\tInstall the tools for pentesting and forensic analysis.\n"
}

log(){
    # check for arguments
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo -e "${red}Error${rst}: function 'log' requires two arguments" \
            | tee -a $WORKDIR/pimp_my_debian.log
        return 1
    fi

    case "$1" in
        "info")
            message="\n$green[+]$rst"
            ;;
        "warning")
            message="\n$yellow[*]$rst"
            ;;
        "error")
            message="\n$red[!]$rst"
            ;;
        *)
            echo -e "\n${red}Error$rst in function 'log': invalid severity.\n" \
            | tee -a $WORKDIR/pimp_my_debian.log
            return 1
            ;;
    esac

    echo -e "${message} ${2}\n" | tee -a $WORKDIR/pimp_my_debian.log
}


log_err(){
    log "error" "Command execution failed! Abort.." && exit 1
}

# install packages
install_packages(){
    log "info" "Install core packages"
    apt -y install git python3-pip pipx zsh openvpn curl ntpdate gdb zip unzip \
        p7zip-full tor proxychains4 hexer
}

# install firefox
install_firefox() {
    log "info" "Install firefox..."
    log "info" "Remove firefox esr"
    sudo apt -y remove firefox-esr && sudo apt -y autoremove || log_err
    log "info" "Import the Mozilla APT repository signing key:"
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null || log_err
    log "info" "check the key fingerprint..."
    fingerprint=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print $0}')
    expected_fingerprint="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"

    [ "$fingerprint" = "$expected_fingerprint" ] && log "info" "Fingerprint matched!" \
        || (log "error" "Fingerprint does not match! Abort.." && exit 1)

    log "info" "Add the Moilla APT repository to the APT sources list.."
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null || log_err

    log "info" "Configure APT to prioritize packages from the mozilla repository"
    echo '
    Package: *
    Pin: origin packages.mozilla.org
    Pin-Priority: 1000
    ' | sudo tee /etc/apt/preferences.d/mozilla || log_err

    log "info" "Update package list and install Firefox .deb package..."
    apt-get update && apt-get -y install firefox || log_err
    log "info" "Finished firefox setup."
}

# install vim
install_vim(){
    log "info" "Clone vim repository..."
    [ -d /opt/vim ] && [ "$(ls -A /opt/vim)" ] && log "warning" "Vim directory already exits." \
        && return 1
    git clone https://github.com/vim/vim /opt/vim || log_err

    log "info" "Prepare the system..."
    # dont check for error (Error when apt can't locate vim)
    sudo apt remove --purge vi vim vim-runtime vim-gnome vim-tiny vim-gui-common

    sudo apt -y install build-essential cmake python3-dev libncurses-dev || log_err

    cd /opt/vim
    log "info" "Compile and Install..."
    make distclean && make clean || log_err

    ./configure --enable-multibyte --enable-pythoninterp=yes --enable-python3interp=yes \
        --enable-cscope --enable-largefile || log_err

    make && make install || log_err
    log "info" "Finished vim setup."
}

install_standard_tools(){
    log "info" "Install standard tools.."
    install_packages
    install_firefox
    install_vim

}

install_i3wm(){
    log "info" "Installing i3wm and tools for customization.."
    apt -y install i3 alacritty flameshot picom nitrogen polybar rofi pulseaudio imagemagick \
        || log_err

    log "info" "Add symlink for imagemagick"
    [ -f /usr/bin/magick ] || ln -s /usr/bin/convert /usr/bin/magick || log_err

    log "info" "Install dependencies for i3lock-color"
    apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev \
        libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev \
        libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev\
        libxkbcommon-x11-dev libjpeg-dev || log_err

    log "info" "Install i3lock-color"
    [ -d /opt/i3lock-color ] && [ "$(ls -A /opt/i3lock-color)" ] && log "info" "i3lock-color \
        directory already exists" || (git clone https://github.com/Raymo111/i3lock-color.git \
        /opt/i3lock-color || log_err)

    cd /opt/i3lock-color
    ./install-i3lock-color.sh || log_err

    log "info" "Install betterlockscreen"
    wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh\
        -O - -q | bash -s system latest true || log_err

    log "info" "Install config files"
    #TODO: setup git ssh_key or include dotfiles in pimp py debian repo
    [ -d $WORKDIR/dotfiles ] && [ "$(ls -A $WORKDIR/dotfiles)" ] && log "info" "Dotfiles \
        directory already exists" || git clone git@github.com:synaxk/dotfiles.git \
        $WORKDIR/dotfiles || log_err
    cp -r $WORKDIR/dotfiles/.* $WORKDIR/

    log "info" "Configure wallpaper and lockscreen"
    # nitrogen command produces an error -> maybe replace nitrogen with betterlockscreen
    #nitrogen --set-zoom-fill $WORKDIR/.config/wallpaper/debian_grey_swirl.png

    betterlockscreen -u .config/wallpaper/debian_grey_swirl.png || log_errs
}

install_john(){
    log "info" "Install JohnTheRipper.."
    log "info" "Install prerequisites.."
    apt -y install libssl-dev || logerr

    log "info" "Clone the repository and compile.."
    [ -d /opt/john ] && [ $(ls -A /opt/john) ] && log "info" "John directory already exists." \
        && return 1
    sudo git clone https://github.com/openwall/john.git /opt/john || log_err
    cd /opt/john/src && ./configure && make || log_err

    log "info" "Activate autocompletion for bash and zsh.."
    make bash-completion && make zsh-completion || log_err
}

install_pentesting_toolkit(){
    lgo "info" "Install pentesting toolkit"
    log "info" "Install apt packages"
    apt -y install wireshark tshark nmap python3-ldapdomaindump gobuster ffuf dnsrecon \
        hashcat wapiti sqlmap ruby ruby-dev freerdp2-x11 smbclient python3-pycryptodome

    log "info" "Install Impacket scripts"
    sudo -u $SUDO_USER python3 -m pipx install impacket

    install_john

#TODO: enum4linux
    #
    # searchsploit/exploitdb
    #
    # responder https://github.com/lgandx/Responder.git
    #
    # evil-winrm
    # gem
    #
    #certipy https://github.com/ly4k/Certipy/releases/tag/4.8.2

    sudo -u $SUDO_USER pipx install certipy
    #
    #zaproxy
    #
    #metasploit-framework
    [ -d /opt/metasploit ] && [ "$(ls -A /opt/metasploit)" ] || mkdir /opt/metasploit
    apt update && apt -y install gpgv2 autoconf bison build-essential postgresql libaprutil1\
        libgmp3-dev libpcap-dev openssl libpq-dev libreadline6-dev libsqlite3-dev libssl-dev\
        locate libsvn1 libtool libxml2 libxml2-dev libxslt-dev wget libyaml-dev ncurses-dev \
        postgresql-contrib xsel zlib1g zlib1g-dev curl

    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /opt/metasploit/msfinstall || log_err
    chmod +x /opt/metasploit/msfinstall && /opt/metasploit/msfinstsall && rm -rf /opt/metasploit

    # mitm6
    sudo -u $SUDO_USER pipx install mitm6

    # netexec
    sudo -u $SUDO_USER pipx ensurepath
    sudo -u $SUDO_USER pipx install git+https://github.com/Pennyw0rth/NetExec

    # burpsuite
    # nessus
    # seclists
    log "info" "Install Seclists repository"
    [ -d /opt/seclists ] && [ "$(ls -A /opt/seclists)" ] || (git clone \
        https://github.com/danielmiessler/SecLists.git /opt/seclists || log_err)

    #kerbrute
    [ -d /opt/kerbrute ] && [ "$(ls -A /opt/kerbrute)" ] || sudo mkdir /opt/kerbrute || \
    sudo wget -O /opt/kerbrute/kerbrute_linux_amd64 https://github.com/ropnop/kerbrute\
    /releases/download/v1.0.3/kerbrute_linux_amd64 || sudo chmod +x \
    /opt/kerbrute/kerbrute_linux_amd64 && echo "already installed"k

}

parse_opts() {
    VALID_ARGS=$(getopt -o hspi --long help,standard,pentest,i3wm -- "$@")
    [[ $?  -ne 0 ]] && exit 1

    [[ $# -eq 0 ]] && log "error" "No arguments supplied." && print_help && exit 1

    eval set -- "$VALID_ARGS"
    while [ : ]; do
        case "$1" in
            -s | --standard)
                install_standard_tools
                shift
                ;;
            -p | --pentest)
                install_pentesting_toolkit
                shift
                ;;
            -i | --i3wm)
                install_i3wm
                shift
                ;;
            -h | --help)
                print_help
                shift
                ;;
            --) shift;
                break
                ;;
        esac
    done
}


# check for sudo
if [ "$EUID" -ne 0 ] || [ -z "$SUDO_USER" ]; then
    echo -e "\n$red[!]$rst \bScript needs to be run with sudo." && exit 1
fi
WORKDIR=/home/$SUDO_USER || log_err
echo $WORKDIR
print_header
parse_opts "$@"


#install_packages

#install_firefox

#install_vim

#install_i3wm

#install_john
