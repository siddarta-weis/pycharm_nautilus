#!/bin/bash

# Install python-nautilus
echo "Instalando python-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm python-nautilus
elif type "apt-get" > /dev/null 2>&1
then
    package_name="python-nautilus"
    if [ -z `apt-cache search --names-only $package_name` ]
    then
        package_name="python3-nautilus"
    fi
    installed=`apt list --installed $package_name -qq 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo apt-get install -y $package_name
    else
        echo "python-nautilus is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=`dnf list --installed nautilus-python 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python
    else
        echo "nautilus-python já esta instalado."
    fi
else
    echo "Falha ao procurar python-nautilus, por favor instale manualmente."
fi

# Remove previous version and setup folder
echo "Removendo versão anterior(se achar)..."
mkdir -p ~/.local/share/nautilus-python/extensions
rm -f ~/.local/share/nautilus-python/extensions/pycharm-nautilus.py

# Download and install the extension
echo "Baixando nova versão..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/pycharm-nautilus.py https://raw.githubusercontent.com/siddarta-weis/pycharm_nautilus/master/pycharm-nautilus.py

# Restart nautilus
echo "Reiniciando o nautilus..."
nautilus -q

echo "Instalação completa!"
