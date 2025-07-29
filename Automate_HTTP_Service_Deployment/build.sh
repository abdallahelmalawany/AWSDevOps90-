curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws

# Add Microsoft repo for Ubuntu 22.04 (Jammy) as workaround for Noble
echo "Adding Microsoft package repository"
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt update -y

# Install .NET 6 SDK and runtime
echo "Installing .NET 6 SDK and Runtime"
apt install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0

# Setup SSH for GitHub
#echo "Setting up SSH key for GitHub"
#sudo -u ubuntu mkdir -p /home/ubuntu/.ssh
#cat << 'EOF' > /home/ubuntu/.ssh/id_ed25519
#BEGIN OPENSSH PRIVATE KEY
#END OPENSSH PRIVATE KEY
#EOF

#chmod 700 /home/ubuntu/.ssh
#chown ubuntu:ubuntu /home/ubuntu/.ssh/id_ed25519
#chmod 600 /home/ubuntu/.ssh/id_ed25519

# Trust GitHub SSH
#sudo -u ubuntu bash -c 'ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts'
#chmod 644 /home/ubuntu/.ssh/known_hosts
# Optional: Configure Git (if needed)
sudo -u ubuntu git config --global credential.helper store
sudo -u ubuntu git config --global credential.useHttpPath false

# Clone the GitHub repository
echo "Cloning GitHub repository"
cd /home/ubuntu
sudo -u ubuntu git clone git@github.com:abdallahelmalawany/AWSDevOps90-.git srv-02 || exit 1

# Build the .NET project
echo "Publishing .NET application"
cd /home/ubuntu/srv-02/Automate_HTTP_Service_Deployment
mkdir -p /temp
echo 'DOTNET_CLI_HOME=/temp' >> /etc/environment
export DOTNET_CLI_HOME=/temp
sudo dotnet publish -c Release --self-contained=false --runtime linux-x64 || exit 1

# Create systemd service
echo "Creating systemd service"
sudo tee /etc/systemd/system/srv-02.service > /dev/null <<EOL
[Unit]
Description=Dotnet S3 info service

[Service]
ExecStart=/usr/bin/dotnet /home/ubuntu/srv-02/Automate_HTTP_Service_Deployment/bin/Release/netcoreapp6/linux-x64/publish/srv02.dll
SyslogIdentifier=srv-02
Environment=DOTNET_CLI_HOME=/home/ubuntu

[Install]
WantedBy=multi-user.target
EOL

# Start and enable the service
systemctl daemon-reload
systemctl enable srv-02
systemctl start srv-02

echo "Deployment complete!"
