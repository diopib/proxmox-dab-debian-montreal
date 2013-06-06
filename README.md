proxmox-dab-debian-montreal
===========================

Proxmox MakeFile to generate an OpenVZ template using the Montreal Local TimeZone

How to use
==========
####First install the dab package from proxmox:

    # On a proxmox server
    apt-get install dab
 
    # Not on a proxmox server
    wget http://download.proxmox.com/debian/dists/wheezy/pvetest/binary-amd64/dab_1.2-5_all.deb
    dpkg -i dab_1.2-5_all.deb
 
####Then clone this repository

    git clone git@github.com:drivard/proxmox-dab-debian-montreal.git
    cd proxmox-dab-debian-montreal
    
####Build the template
    
    make

####Last step
Once completed you should find a traball that is your new template just move it to your template/cache folder on your proxmox server.

