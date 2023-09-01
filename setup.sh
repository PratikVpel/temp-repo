
#!/bin/bash

# Update package lists
sudo apt update

# Install OpenJDK 11
sudo apt install -y openjdk-11-jdk

# Install Maven
sudo apt install -y maven

# Download simulator files
wget https://github.com/PratikVpel/temp-repo/raw/main/vstsimulator-master.zip
wget https://github.com/PratikVpel/temp-repo/raw/main/vstdb.sql

# Install MySQL Server
sudo apt install -y mysql-server

# Start and enable MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql


# Install unzip
sudo apt install -y unzip

# Extract simulator files
unzip vstsimulator-master.zip
cd vstsimulator-master


