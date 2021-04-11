# Unison for CentOS 8.2
Unison, a linux/windows program written-lead designed by Professor <a href="https://www.seas.upenn.edu/~bcpierce/">Benjamin C. Pierce</a> made available on https://www.cis.upenn.edu/~bcpierce/unison/ to address source and destination machines two-way files synchronisation on specified folders in effect.

This shell script was written to facilitate unison scripted installation (after realising there are gaps to address virtual machine readiness for unison installation e.g. libraries and machine tuning) under a pair of newly deployed Azure Virtual Machines <a href="https://docs.microsoft.com/en-us/azure/virtual-machines/linux/endorsed-distros#supported-distributions-and-versions">CentOS 8.2 distribution</a> at the time of writing this readme.

# How To Use 

## 1. System Configuration Applied and Tested
1.1 Two CentOS 8.2 Virtual Machines (source and destination for files synchronisation with same userid e.g. azureuser using key authentication) deployed on Azure Cloud in Southeast Asia 

1.2 Configure timezone to Singapore

1.3 Make 16GB Swap Space and automount after system reboot

1.4 Perform system up-to-date update via yum

1.5 Perform php, git, unison libraries and make installation

1.6 Download Unison version 2.51.2

1.7 Uncompress Unison version 2.51.2

1.8 Make (e.g. compile) Unison executable

1.9 Generate key pair (public and private keys) for source and destination machines secure communication

1.10 Copy source public key to destination machine

1.11 Prepare Unison default configuration file (for synchronisation)

1.12 Copy Unison default configuration file to root user profile

1.13 Add new cronjob task for root user

1.14 Remove temporary files

1.15 Check synchronisation status by tailing Unison log file

## 2. Prerequisite and Execution
2.1 Two CentOS servers or virtual machines (source machine has destination machine private key for secure connection by authenticate with destination machine public key in authorized_keys)

2.2 Login to source machine and execute following command:
   
   source <(curl -s https://raw.githubusercontent.com/donchai/unison/main/unisoncentos.sh) userid destinationmachineaddress destinationmachineprivatekey sourcepublickey synchfolder
   
   example:
    
    source <(curl -s https://raw.githubusercontent.com/donchai/unison/main/unisoncentos.sh) azureuser azureuservm.southeastasia.cloudapp.azure.com ~/.ssh/destinationkey.pem ~/.ssh/sourcekey.pub var/www/html
   
   explanation:
   
   execute unisoncentos shell script by providing five input parameters to be used during scripted execution
   2.2.1 userid (e.g. azureuser) use at source and target machine for file synchronisation
   2.2.2 destinationmachineaddress (e.g. azureuservm.southeastasia.cloudapp.azure.com) use to communicate for file synchronisation
   2.2.3. destinationmachineprivatekey (e.g. ~/.ssh/destinationkey.pem) use to establish secure communication handsake with target machine public key
   2.2.4 sourcepublickey (e.g. ~/.ssh/sourcekey.pub) public key file location at source machine to be copied to destination machine
   2.2.5 synchfolder (e.g. var/www/html) absolute path at source machine without prefix forward slash i.e. /var/www/html = var/www/html

## 3. Synchronisation In Action
Changes made on source and/or destination machines for files and/or folders in specified synchronisation folder e.g. /var/www/html will be synchronised every 1 minute at both ways. Latest changes will be syncrhonised between two machines based on the configuration parameters. You may further fine-tune the <a href="https://geekdudes.wordpress.com/2020/05/05/installing-unison-on-centos-8/">configuration parameters in default.prf file</a> to handle synchronisation conflict resolution and et cetera.

![image](https://user-images.githubusercontent.com/6828772/114296417-e4ae2500-9add-11eb-8723-3c08b3a1f32c.png)

Last cronjob ran Apr 11, 15:57 (unisoncron.log - cronjob runs every minute to pick up changes)

Last unison synchronisation completed Apr 11, 11:54 and 12:05 (unison.log - new credit.html file created at 11:54 on destination machine synchronised/copied to source machine and later deleted at 12:05 on source machine - both changes sychronised successfully)

# Reference 

### In Use

https://github.com/bcpierce00/unison

https://www.seas.upenn.edu/~bcpierce/unison/download/releases/

https://geekdudes.wordpress.com/2020/05/05/installing-unison-on-centos-8/

https://www.netweaver.uk/create-swap-file-centos-7/

https://unix.stackexchange.com/questions/21297/how-do-i-add-an-entry-to-my-crontab (answer from Kusalananda)

### Not In Use (experimental)

https://www.programmersought.com/article/18972227299/

### Additional Cross Reference

https://unix.stackexchange.com/questions/77277/how-to-append-multiple-lines-to-a-file

https://stackoverflow.com/questions/2936627/two-way-sync-with-rsync

https://www.liquidweb.com/kb/install-rsync-and-lsync-on-centos-fedora-or-red-hat/
