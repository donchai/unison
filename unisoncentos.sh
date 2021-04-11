sudo timedatectl set-timezone Asia/Singapore
free -m
sudo dd if=/dev/zero of=/swap count=16384 bs=1MiB status=progress
sudo chmod 600 /swap
sudo mkswap /swap
sudo swapon /swap
sudo chmod 777 /etc/fstab
sudo echo "/swap swap swap sw 0 0" >> /etc/fstab
sudo chmod 644 /etc/fstab
free -m
sudo yum update -y
sudo sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
sudo yum install php git ocaml ocaml-camlp4-devel ctags ctags-etags make -y
php -v
git --version
wget "https://www.seas.upenn.edu/~bcpierce/unison/download/releases/unison-2.51.2/unison-2.51.2.tar.gz"
tar -xvzf unison-2.51.2.tar.gz
cd src
make
sudo cp unison /usr/bin/
unison -version
ssh-keygen -q -t rsa -N '' -f ~/.ssh/sourcekey <<<y 2>&1 >/dev/null
cat $4 | ssh -i $3 $1@$2 'cat >> ~/.ssh/authorized_keys && echo "Key copied"'
tee /tmp/default.prf > /dev/null <<EOT

# Unison preferences file
#Roots of the synchronisation
root = /
root = ssh://$2//

#Paths to synchronise
path = $5

auto=true
batch=true
confirmbigdel=false
fastcheck=true
group=true
owner=true
prefer=newer
silent=true
times=true
log = true
logfile = /var/log/unison.log
EOT

sudo cat /tmp/default.prf > /root/.unison/default.prf
sudo crontab -l > /tmp/crontab
sudo echo "*/1 * * * * /usr/bin/unison &>/var/log/unisoncron.log" >> /tmp/crontab
sudo crontab /tmp/crontab
sudo systemctl status crond
sudo systemctl enable crond
sudo systemctl restart crond
sudo rm /tmp/default.prf /tmp/crontab
sudo tail -f /var/log/unison.log
