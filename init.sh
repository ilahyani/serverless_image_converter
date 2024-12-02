#! /bin/bash

set -e
trap 'echo "setup Failed. Exiting..."; exit 1;' ERR

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y wget unzip

cd /tmp

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 20

sudo wget "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip"
sudo unzip "terraform_1.9.8_linux_amd64.zip"
sudo mv terraform /usr/bin
sudo terraform -v

sudo wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
sudo unzip "awscli-exe-linux-x86_64.zip"
sudo ./aws/install
sudo aws --version

# sudo aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
# sudo aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
# sudo aws configure set region "$AWS_REGION"

# cd /home/vagrant/watermark_function/function
# npm run dev