
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
	dab exec echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjSZEIry8SVyx0yBAXPBNiidK/e0hbb/KGpf+EJNjCXsfeQqrkWcILASj3sEuMHIodHDF2M1AeBCCS2hItTPPRlYLqyM4YwRvn8iO3KI+g0RBAHFNEyr8TIoMC2XE/0uXLu/06Wc6ZGpYECL3K5g34FN0XQh9MyiW2UoctGTtaLc5HP4JqSfLoMF7BTp+dsogBXwYNkTQesqcHp9Pknaducgcr2cxMU18lGUr26jS4c3BEO3kqfjifp+JpPCxfHDX7Ls856L+KS8qPzRpayzDuW8wZSHxu4603VBIFsX2CkAED1yAirUux+A10Usk07YCLruXtAti/JM2HsM56XNaV dominick@drivard" >> ~/.ssh/authorized_keys 
	dab exec echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAh9B543WBq1NNIi4QfOcB6iCYoqddxhOG32+ZZIV966r0bg8vkpP1d8VCxmEN8LyKYlQ09oDjUkDqWGwIHUU2NxsXAd93h0SwxuVQPLwXlCb3ikx26HYASnxGaAe6QYmY2YMgmYycmMl5XFy6PQ1YLBPJ5dYmeoFhRMlO/O39rFM= rsa-key-win-drivard" >> ~/.ssh/authorized_keys
	dab exec echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJ6BO8hPDq8pfO3Q6NwT06czbg7aha/xm8LfRMSk7qlZC1qiwvl9OJxFG8lHOZNHPa6qgjQZiyfoHLk7beqI20qZzUTh1baDSxDZzE7fIt6lrSg3BXPYZn3n2i7Hc0n/H+VVnJ93ded3ZgHddoeVG0/uxP9YNKSbQKnNZpGiAc3TIB0zHvYiv/73s1w1SYwNA6FZBT5pg69Vgvv3gPvgBSh7tMu4OTORxEJgbyFc818+cuhwsyD9gbVzGDsQ1+N/+a4nnRVJidgC8/1eTClvhmYZDBRmphU6cry+wYD5kVRvUEvWtRyTGxRuMYzdA0BDFfD0vDSQMBq2LE+Gr/eS1j drivard@MTL-RD-RDominick" >> ~/.ssh/authorized_keys
	dab exec echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNaQIjKgIwz7TQSea6SN1ggfjpibH+0sSyJwCpZ6+SrRCcvOmW0nEovVf9tC4arkPpW57mpCAtc/9y0D8qC3idwYQtVrV57Jq2qppyN1Njs6hsrkPM6L6avyHC/en6qLGxniz++PxvNEJmT4XIkY2gJ0F3KzF+KYOltKOi+aJznDSPfZjMpE92zqhtMEwCYMQwi3BRbDTprY0eCvlNZaLC/elIgxLzP9VamQ3NMVbuXYWGQn6lXkSI9Mr03Das1s4aBuzv6xjYXfTRUqgkdJ8/M2wYTlyfGBLPsC5gB+mamOXFSn75nHAcciaAYPDi9/vYa5HB/9ga8JxN1J9HCo8B root@proxmox-1" >> ~/.ssh/authorized_keys
	dab exec echo 'HISTFILE=~/.bash_history' >> ~/.bashrc
	dab exec echo 'cd' >> ~/.bashrc
	dab exec git config --global user.name "Dominick Rivard"
	dab exec git config --global user.email dominick.rivard@gmail.com
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
