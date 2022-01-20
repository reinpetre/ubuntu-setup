#!/bin/sh
: '
    USAGE: sudo ./setup.sh
'

# 1 Update and install basic packages
# 1.1 Update and upgrade
apt-get update -y && apt-get upgrade -y
# 1.2 Intall wget
apt install -y wget
# 1.3 Install gdebi
apt-get install gdebi-core 
# 1.4 Install gnome extensions
apt install -y gnome-shell-extensions
apt install -y chrome-gnome-shell




# 2 Install Docker
# 2.1 Setup the repository
# 2.1.1 Update the apt package index and install packages to allow apt to use a repository over HTTPS:
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
# 2.1.2 Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 2.1.3 Setup the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# 2.1 Install Docker Engine
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# 2.3 Post-installation: Manage Docker as a non-root user
# 2.3.1 Create the docker group if it does not already exists
getent group docker || groupadd docker
# 2.3.2 Add you user to the docker group
usermod -aG docker ${USER}
# 2.3.3 Restart the docker deamon
systemctl restart docker
# 2.3.4 chmod docker deamon
chmod 666 /var/run/docker.sock
# 2.3.4 Verify that you can run docker commands without sudo
docker run hello-world




# 3 Install docker-compose
# 3.1 Download the current stable release of Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 3.2 Apply executable permissions to the binary
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose




# 4.Install NVIDIA Container Toolkit
# 4.1 Setup the stable repository and the GPG key:
export distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# 4.2 Install the nvidia-docker2 package (and dependencies) after updating the package listing
apt-get update -y
apt-get install -y nvidia-docker2

# 4.3 Restart the Docker daemon to complete the installation after setting the default runtime
systemctl restart docker

# 4.4 Test the setup by running a base CUDA container
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi




# 5 Install Github Desktop
# 5.1 Download the .deb file
wget https://github.com/shiftkey/desktop/releases/download/release-2.9.3-linux3/GitHubDesktop-linux-2.9.3-linux3.deb

# 5.2 Install gdebi-core
apt-get install -y gdebi-core 

# 5.3 Install the .deb file
gdebi -n GitHubDesktop-linux-2.9.3-linux3.deb

# 5.4 Remove the installed .deb file
rm -f GitHubDesktop-linux-2.9.3-linux3.deb




# 6 Install VS Code
# 6.1 Add the right repository 
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# 6.2 Install code
apt update -y
apt install code -y




# 7 Install Pycharm
snap install pycharm-community --classic

