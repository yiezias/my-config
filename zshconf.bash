
GZC=grml-zsh-config
AHG=zsh-autosuggestions
SHL=zsh-syntax-highlighting

ZSH_PLUG_DIR=/usr/share/zsh/plugins

MY_ZSHRC=~/.zshrc

wrzshrc() {
	if [[ -f $ZSH_PLUG_DIR/$AHG/$AHG.plugin.zsh && \
		-f $ZSH_PLUG_DIR/$SHL/$SHL.plugin.zsh ]]
		then
			echo "source $ZSH_PLUG_DIR/$AHG/$AHG.plugin.zsh" >> $MY_ZSHRC
			echo "source $ZSH_PLUG_DIR/$SHL/$SHL.plugin.zsh" >> $MY_ZSHRC
		else
			echo "sth wrong"
	fi
}

exe_spin() {
	ret=1
	while [[ $ret -ne 0 ]];
	do
		$1
		ret=$?
	done
}

if [[ $(grep -c "Arch Linux" /etc/issue) -eq 1 ]]
then
	set -e
	yes|sudo pacman -S $GZC $AHG $SHL
	wrzshrc
else
	sudo mkdir $ZSH_PLUG_DIR/$GZC -p
	sudo wget -O $ZSH_PLUG_DIR/$GZC/$GZC.plugin.zsh \
		https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

	echo "source $ZSH_PLUG_DIR/$GZC/$GZC.plugin.zsh" >> $MY_ZSHRC
	exe_spin "sudo git clone https://github.com/zsh-users/$AHG.git $ZSH_PLUG_DIR/$AHG"
	exe_spin "sudo git clone https://github.com/zsh-users/$SHL.git $ZSH_PLUG_DIR/$SHL"
	wrzshrc
fi
