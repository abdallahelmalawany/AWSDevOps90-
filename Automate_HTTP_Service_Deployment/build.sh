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

 #Setup SSH for GitHub
echo "Setting up SSH key for GitHub"
sudo -u ubuntu mkdir -p /home/ubuntu/.ssh
cat << 'EOF' > /home/ubuntu/.ssh/id_ed25519
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAACFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAgEAzJxBu/xtLJYhfVYSR/hufFEfNPDM5U9iGjw52vSiH2lvWr1MTw5C
rbrdQHGn8QE/mGWN30LewPxqNTrPdm5cJ2UGVsAIgAk/mQkbwzNflAHivl9zPEgWY9UD9P
9gYcBE59Q35u+fis5pTjH88Wx0QTGVIbQEBgBYbeo5i979KxI2x2UfiUrfhnolAMwTh2KD
RmLjhlvEBSRSZS2IHsG5k1rkkLYXWj6H7kQM+UwkFEvf1KeJJumN+xYHZGApwqHt20BHdi
nGs0pmX+p+Ou/DfBk2H4EEPaXsGW5bJi4NDe8T9ATg8GuOpVqt3Ua6Msf+WTg+7QnfrSNw
KYandvrQ3UZKGoS+qXsHEAqghqkWf/uqoh56IMruGt7BpCBPSH/3qa6vYN4fs2vpcde9/G
yWTEl4So4JT8FEApc16F/qvANdUK1USisiXMlUj4Kk0JqWMPaaP9OkimB5YMuSL/DlkzTE
pqCI7Jqy1VbtJ4ArmZ3bysWlEgRDT8O1LpJS6xU8sMN76dZw6XzglCprhOHmaQCVOJ7NTq
otgcY0K9G6Y88cc6+IdtO6P0uWd8pvQqgY4OY/LRV02rCkRK8DN0ImKL9y/+XKTX7NsRx0
dqGsUK25v9TC4p/r3V4mDsff18iOz0DJVepSFVa9a3SU2bRUgeilSVsh4diZZtpGtf6yuU
EAAAdY6gh2UuoIdlIAAAAHc3NoLXJzYQAAAgEAzJxBu/xtLJYhfVYSR/hufFEfNPDM5U9i
Gjw52vSiH2lvWr1MTw5CrbrdQHGn8QE/mGWN30LewPxqNTrPdm5cJ2UGVsAIgAk/mQkbwz
NflAHivl9zPEgWY9UD9P9gYcBE59Q35u+fis5pTjH88Wx0QTGVIbQEBgBYbeo5i979KxI2
x2UfiUrfhnolAMwTh2KDRmLjhlvEBSRSZS2IHsG5k1rkkLYXWj6H7kQM+UwkFEvf1KeJJu
mN+xYHZGApwqHt20BHdinGs0pmX+p+Ou/DfBk2H4EEPaXsGW5bJi4NDe8T9ATg8GuOpVqt
3Ua6Msf+WTg+7QnfrSNwKYandvrQ3UZKGoS+qXsHEAqghqkWf/uqoh56IMruGt7BpCBPSH
/3qa6vYN4fs2vpcde9/GyWTEl4So4JT8FEApc16F/qvANdUK1USisiXMlUj4Kk0JqWMPaa
P9OkimB5YMuSL/DlkzTEpqCI7Jqy1VbtJ4ArmZ3bysWlEgRDT8O1LpJS6xU8sMN76dZw6X
zglCprhOHmaQCVOJ7NTqotgcY0K9G6Y88cc6+IdtO6P0uWd8pvQqgY4OY/LRV02rCkRK8D
N0ImKL9y/+XKTX7NsRx0dqGsUK25v9TC4p/r3V4mDsff18iOz0DJVepSFVa9a3SU2bRUge
ilSVsh4diZZtpGtf6yuUEAAAADAQABAAACAEGk+Cn5qIUffYsarC7O85OK6zou7226dDz6
iY1H4yO0zfcMuIi8iIP4abedP0ZBIkggfM3eRF0iHmkJfzn92i8BaHE4lwGM9gyBMZkEyG
tR149ATFZQwm4xD13w+NkjuHewTGcZBdSguIRP4VkLdJjd8XyoponOXpCVDvVjC1JgO5bp
SJ7hmKkqUujYkINlBbz1SQ34LwF/T7gKTZugh4tRI/eRlBht62p0Br2Mwh6I4Tz2qzgCwn
yF6sU3XO6GySsIimTMrmUjP4kSUIFUHyGXbRfaaqPkscTO9QtgxutrgrlNP2Wi/Fbsqs9N
O7vDEkVJmFawTkTcE8Ye32d6vLtNlLVsfg/+BQAMlqrHEc7HtEOF1fBzihIQOfCVJUgTSj
0a+RJDVfcUHFg+9X2PPzrEbvkOxk63fzSId65egw+YuRE6zm0gTmOjWNp0oaw69WIZhqHu
52pfEa8DCMi5UDUq9XYTPm6NOJ+aqn3L8hnLxPwuFccLaztghkHozAx2hDIqC7AZGBECwB
TiIcQxgozGQAkQMJN69os1FItQ2z1KOkULkJPjYhiodS1h+Wv+7c3BeRZepkabXpajzZag
JS+h9+mfDj4aw3Boz/D1RGTesY+w9qARcCXMUj1re017fOaeAKrb63f4cIzIjwFAamKjcj
XWaAd1TuEoXQ+kp/4JAAABAQDctuX2GXutSMkan66ZQ1WmE4GWeWRSXTe0mrm1aXhudsf7
8mJjL5iyY22vGcPTVgC5CNOcMSfzDpjJOP+9Rgt9aPUU97FWhDdtP+tY2H4DhmmJilKDJi
s4Clxku4jMcAH/MrI2uDUtLv7SW2S35j724QQujSIC4MefbMWmKVJ4UQNAPsBjyL9+atQz
wOjih0OfMXYmZDD9wLNf+sYFZc0moy8LkYmUKgNnSN/l/gsUPvcyUH7P/H5z0GYGf/XOv5
zdy8OqZc2vL+gXbih017oGjpdFJRCAS6ptxmpdSax6YrjzXraqgFfWjRvssCEdWf3lwmmc
DlEN390TCuskmw/iAAABAQD87ic0aqVFgH5SPZDbkWVlVIDzHLJsxof399NhmNC5w1YN04
O+i9orbLdub2nldALO8kIAlUC0QG0dHc8sKWVpzStaqhbrtX2OH+GYKz5yN//YVctGVTlO
vddn6RUfe/m5uQUR+eiDZqyDgy5Yy71/0NRUwGXf/3mwbUE+838234RFeex0xF2EWdiRAz
pIgw45NeOGkBCM6Yk6easpOVrGT6yKCi0LUktHwTnku2WvHsz4QC92tCDO+azTVQDEN6n/
QP/ifVIn7zhB8Pfi+d2kMi62Qp6xe6vt9WqIZempQs6b5b4YQGzFWzL2bIGrC/N0xI2xRZ
TaYKHUDQZC+0F3AAABAQDPF/mhX7korkKcCJPkNS+0kUNCYg3lcPjUkus5tdgfl6YW+4E3
7PF0p1Z1tGav/CdLT35p3Dafjt7AosQePG4mU7UqJjg7Eof8TTo1CRWFyEaC8vWwoF1u/t
dgTXnCt7YHqeYSSlMpi9njoWPajIW454hpOSftNFbk3262h5v0Xnr/C2Mux2FMWlJHiDYa
x3tNPkW6AYnZ1nzS7uzOtCVWJLeviuiZaMGaIM3k1ywVhLkV683fFG3KIQLTkaTm1lFGFO
Go9fyRqE02wA7vhz/WrglVKiw2g5XtpRcdNLakOSdZ0v/pwiFM4OcsBmB3/JGxf9mVSSaG
39W2vdzPX0kHAAAAHGFiZGFsbGFoYWxtYWxhd2FueUBnbWFpbC5jb20BAgMEBQY=
-----END OPENSSH PRIVATE KEY-----
EOF

chmod 700 /home/ubuntu/.ssh
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_ed25519
chmod 600 /home/ubuntu/.ssh/id_ed25519

# Trust GitHub SSH
sudo -u ubuntu bash -c 'ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts'
chmod 644 /home/ubuntu/.ssh/known_hosts
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
