
BASEDIR:=$(shell dab basedir)

all: info/init_ok
	dab bootstrap
	dab install vim-nox ntpdate strace tcpdump sudo debian-goodies nmon git git-core dnsutils dos2unix bash-completion nethogs snmpd build-essential curl apt-file lsb-release vnstat htop dnstop python-dev python-setuptools
	dab exec update-alternatives --set editor /usr/bin/vim.nox
	dab exec echo "export PS1='\[\033[36m\]\h\[\033[32m\] \w\[\033[00m\]:'" >> ~/.bashrc
	dab exec echo "alias ls=\"ls -lh --color\"" >> ~/.bashrc
	dab exec echo "alias up=\"apt-get update && apt-get upgrade --yes && apt-get dist-upgrade --yes && apt-get autoclean --yes && apt-get autoremove --yes && apt-get --purge clean\"" >> ~/.bashrc
	#dab exec echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then' >> ~/.bashrc
	#dab exec echo '    . /etc/bash_completion' >> ~/.bashrc
	#dab exec echo 'fi' >> ~/.bashrc
	dab exec vnstat -i venet0 -u
	dab exec rm -rf /etc/localtime
	dab exec ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime
	dab exec echo "America/Montreal" > /etc/timezone
	dab exec echo '30 12 * * * rm -rf /var/cache/apt/archives/*.deb' >> /var/spool/cron/crontabs/root
	dab exec echo "# Disable IPv6" >> /etc/sysctl.conf
	dab exec echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
	dab exec mkdir -p ~/.ssh/
	dab exec echo 'HISTFILE=~/.bash_history' >> ~/.bashrc
	dab exec echo 'cd' >> ~/.bashrc
	dab exec apt-get remove -y postfix rpcbind
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
