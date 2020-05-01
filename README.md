# deskmody
Deskmody is a bash script which modify your personal Desktop (Ubuntu/Debian/RedHat) like mine. I created this script in order to automate all boring configuration procedure and settings of a new system installation or after a disk format. Be careful this script will change your default /bin/bash shell to /usr/bin/zsh. 

Some features:

‣ Recognize packet manager of system (supports only Ubuntu/Debian/RedHat systems)

‣ Checks Internet connectivity before the package installation.

‣ Updates and full upgrades your system.

‣ Installs usefull packages like (curl, vim, nmap, irpas, tmux, zsh etc.).

‣ Enables vim registers in order to work with tmux sessions (Yanking & Pasting from/to system/tmux).

‣ Installs and sets up ohmyzsh terminal framework.

‣ Installs and activates auto-suggestion & highlight plugins of ohmyzsh.

‣ Edits some settings in .zshrc file.

‣ Creates some personal allias in .zshrc file.

‣ Edits some configuration settings in .tmux.conf.

‣ Installs all necessary packages in order to set up qemu/kvm hypervizors.


Usage: ./diskmody.sh
