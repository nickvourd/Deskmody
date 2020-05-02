#!/bin/bash

#Author: @nickvourd
#Website: nickvourd.eu
#Team: Bit Warriors


#Ascii art print
cat << EOF

██████  ███████ ███████ ██   ██ ████████  ██████  ██████      ███    ███  ██████  ██████  ██    ██ ███████ ██ ███████ ██████ 
██   ██ ██      ██      ██  ██     ██    ██    ██ ██   ██     ████  ████ ██    ██ ██   ██  ██  ██  ██      ██ ██      ██   ██ 
██   ██ █████   ███████ █████      ██    ██    ██ ██████      ██ ████ ██ ██    ██ ██   ██   ████   █████   ██ █████   ██████  
██   ██ ██           ██ ██  ██     ██    ██    ██ ██          ██  ██  ██ ██    ██ ██   ██    ██    ██      ██ ██      ██   ██ 
██████  ███████ ███████ ██   ██    ██     ██████  ██          ██      ██  ██████  ██████     ██    ██      ██ ███████ ██   ██

						 By @nickvourd

				 	 -Bit Warriors | Red Force Team-

EOF

#Function updater
updater(){
	echo -e "\e[1;34m[+] Your system database is updating!\e[0m\n"
	updatedb 2>dev/null
	echo -e "\e[1;32m[!] Your system database has been updated!\e[0m\n"
}

#function packmang
packmang(){

	#Search for yum packet manager if exists
	which yum >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		#found yum
		echo -e "\e[1;31m[!] Packet Manager found:\e[0m\n";
		echo -e "RED HAT LINUX (yum)\n"

		#indentify Linux Distro
		echo -e "\e[1;32m[!] Linux Distribuntion:\e[0m\n";		
		cat /etc/*-release | grep -i "name" | cut -d '"' -f 2 | head -n 3 | tail -n 1

		#set gloabal variable for packet manager
		export packvar=yum
		#debug
		#echo $packvar

	fi

	#Search for apt packet manager if exists
	which apt >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		#found apt
		 echo -e "\e[1;31m[!] Packet Manager found:\e[0m\n";
		 echo -e "Debian/Ubuntu (apt)\n"

		 #indentify Linux Distro
		 echo -e "\e[1;32m[!] Linux DIstribution:\e[0m\n";
		 cat /etc/*-release | grep -i "name" | cut -d '"' -f 2 | head -n 3 | tail -n 1

		 #set gloabal variable for packet manager
		 export packvar=apt
		 #debug
		 #echo $packvar

	fi

}

#Start process
echo -e "\e[32m[!] Process starting at\e[0m\n";
date
echo -e "\n"

#Set author Global variable 
export author=nickvourd
echo -e "\e[1;31m[+] Author: \e[0m\n";
echo -e "$author\n"

#Desktop Details
echo -e "\e[1;34m[+] User:\e[0m\n";
whoami 
id 
echo -e "\n"

#Packet Manager
echo -e "\e[1;34m[+] Try to indentify packet manager:\e[0m\n";
#call function packmag
packmang
#exit 1

echo -e "\e[1;34m[+] Hostname:\e[0m\n"; 
hostname
echo -e "\n"

echo -e "\e[1;34m[+] Kernel Version:\e[0m\n";
uname -mrs
echo -e "\n"

#Checks root's privileges
echo -e "\e[1;34m[+] Do you have root's privileges?\e[0m\n"
if [[ $EUID -ne 0 ]]; then
	echo -e "\e[1;31m[!] You don't have root's privileges!\e[0m"
	echo -e "\e[1;31m[!] Plz use first sudo su command and then run this script!\e[0m\n"
	exit 1;
else
	echo -e "\e[1;32m[!] root's privileges OK!\e[0m\n"
	cd /root
fi

#Check internet connection
echo -e "\e[1;34m[+] Check Internet Connectivity:\e[0m\n"
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>/dev/null; then
	echo -e "\e[1;32m[!] Internet Connection OK!\e[0m\n"
	
	#Update and Full upgrade system
	echo -e "\e[1;34m[+] Do you want to update and full upgrade your system (RECOMMENDED)? [Y/N]\e[0m\n"
	read ans

	#Loop to check the correct answer
	while [ $ans != "Y" ] && [ $ans != "y" ] && [ $ans != "N" ] && [ $ans != "n" ]
	do
		echo -e "\e[1;33m[!] Sorry What?\e[0m\n"
		read ans
	done

	if [ $ans == "Y" ] || [ $ans == "y" ]; then
		$packvar update -y && $packvar upgrade -y && $packvar dist-upgrade -y
		echo -e "\n"
		echo -e "\e[1;32m[!] Your system is full updated and upgraded!\e[0m\n"
	else	
		echo -e "\e[1;31m[!] Your system has not been updated and full upgraded!\e[0m\n"
	fi

	#General system Configuration
	echo -e "\e[1;31m[+] Start Desktop Configuration Like nickvourd's!\e[0m\n"

	#Create list of packages
	cat<<EOF>>/tmp/packages
net-tools
git
curl
vim
vim-gtk3
tmux
locate
nmap
irpas
tree

EOF

	#Install packages
	for x in $(cat /tmp/packages); do
	echo -e "\e[1;34m[+] Installing $x package!\e[0m\n"
	$packvar install $x -y
	echo -e "\e[1;32m[!] Package $x has been installed!\e[0m\n"
	done

	#delete list named packages
	rm /tmp/packages

	#enable vim registers
	echo -e "\e[1;34m[+] Enabling vim registers!\e[0m\n"
	timeout 5 gvim
	echo -e "\e[1;32m[!] vim registers has been enabled!\e[0m\n"

	#terminal Configuration
	echo -e "\e[1;31m[+] Terminal Configuration:\e[0m\n"

	#Install zsh shell
	echo -e "\e[1;34m[+] Installing zsh shell!\e[0m\n"
	$packvar install zsh -y
	echo -e "\e[1;32m[!] Package zsh has been installed!\e[0m\n"

	#Install ohmyzsh
	echo -e "\e[1;34m[+] Installing ohmyzsh\e[0m\n"
	curl -Lo /root/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	echo -e "\e[1;32m[!] ohmyzsh has been installed!\e[0m\n"

	#Set up ohmyzsh
	echo -e "\e[1;34m[+] Setting up ohmyzsh!\e[0m\n"
	echo -e "\e[1;31m[!] Remember to set up ohmyzsh as default shell!\e[0m\n"
	echo -e '\e[1;31m[!] Remember to exit from session after set up (Press "exit")\e[0m\n'
	sh /root/install.sh
	echo -e "\e[1;32m[!] ohmyzsh has been setted up!\e[0m\n"

	#Install auto-suggestion plugin
	echo -e "\e[1;34m[+] Installing autosuggestion plugin!\e[0m\n"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	echo -e "\e[1;32m[!] autosuggestions plugin has been installed!\e[0m\n"

	#Install zsh-syntax highlighting plugin
	echo -e "\e[1;34m[+] Installing zsh syntax highlighting plugin!\e[0m\n"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	echo -e "\e[1;32m[!] zsh syntax highlighting plugin has been installed!\e[0m\n"
		
 	#Activate plugins
	echo -e "\e[1;34m[+] Activate plugins!\e[0m\n"
	sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
	echo -e "\e[1;32m[!] Plugins have been activated!\e[0m\n"

	#Configure .zshrc
	echo -e "\e[1;34m[+] Configure .zshrc with some alias!\e[0m\n"
	cat<<EOF>>~/.zshrc
alias ts='tmux new -t'
alias ta='tmux a -t'
alias tl='tmux ls'
alias tk='tmux kill-session -t'
EOF

        echo -e "\e[1;32m[!] .zshrc have been updated!\e[0m\n"

	#Configure .tmux.conf
	echo -e "\e[1;34m[+] Configure .tmux.conf file!\e[0m\n"
cat<<EOF>/root/.tmux.conf
#source /usr/share/powerline/bindings/tmux/powerline.conf

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
EOF

	echo -e "\e[1;32m[!] .tmux.conf has been configured!\e[0m\n"

	#Install qemu/kvm
	echo -e "\e[1;34m[+] Do you want to install qemu/kvm?\e[0m\n"
	read ans2
	
	#Loop to check the correct answer
	while [ $ans2 != "Y" ] && [ $ans2 != "y" ] && [ $ans2 != "N" ] && [ $ans2 != "n" ]
	do
		echo -e "\e[1;33m[!] Sorry What?\e[0m\n"
		read ans2
	done

	if [ $ans2 == "Y" ] || [ $ans2 == "y" ]; then
		echo -e "\e[1;34m[+] Installing cpu-checker package!\e[0m\n"
		$packvar install cpu-checker -y
		echo -e "\e[1;32m[!] Package cpu-checker has been installed!\e[0m\n"
		
		cpuchecker=`kvm-ok`

		if [ $? -eq 0 ]; then
			echo -e "\e[1;32m[!] Your system supports qemu/kvm!\e[0m\n"
			echo -e "\e[1;34m[+] Installing qemu qemu-kvm libvirt-daemon-system bridge-utils virt-manager packages!\e[0m\n"
		 	
			#create list of packages
			cat<<EOF>>/tmp/packages
qemu 
qemu-kvm 
libvirt-clients 
libvirt-daemon-system 
bridge-utils 
virt-manager			

EOF

			#Install packages for qemu/kvm
			for i in $(cat /tmp/packages); do
				echo -e "\e[1;34m[+] Installing $i package!\e[0m\n"
				$packvar install $i -y
				echo -e "\e[1;32m[!] Package $i has been installed!\e[0m\n"
			done

			#Delete list named packages
			rm /tmp/packages
		
		else	
			#Failed to support qemu
			echo -e "\e[1;31m[!] Your system doesn't support qemu/kvm!\e[0m\n"	
			
			#call updater function
			updater

			#Goodbye Message
			echo -e "\e[1;32m[!] Your system successfull configured!\e[0m"
			echo -e "\e[1;32m[!] Special thanks by $author\e[0m\n"
			echo -e "\e[1;31m[!] Plz exit from shell and use sudo su again to reload all new features!\e[0m"


		fi
	else
		echo -e "\e[1;31m[!] qemu/kvm has note been installed!\e[0m\n"
	fi


#call updater function
updater

#Goodbye message
echo -e "\e[1;32m[!] Your system successfull configured!\e[0m"
echo -e "\e[1;32m[!] Special thanks by $author\e[0m\n"
echo -e "\e[1;31m[!] Plz exit from shell and use sudo su again to reload all new features!\e[0m"


else
	#Connection error message
	echo -e "\e[1;31m[!] Weak internet connection!\e[0m"
	echo -e "\e[1;31m[!] Please fix your internet connection asap in order to resume the process!\e[0m"
	echo -e "\e[1;31m[!] The process can't continue!\e[0m\n"
	
fi

