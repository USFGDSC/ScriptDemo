#!/bin/bash

# Get today's date in the format "jan31"
today=$(date +"%b%d")

# Remove the folder if it already exists
if [ -d $today ]; then
echo "removing existing folder"
  rm -rf $today
  sleep 2
fi

# Create a new folder with today's date as the name
echo "creating new folder"
sleep 2
mkdir $today

# Get URL from user input
read -p "Enter URL: " url

cd $today
# Download the zip file from the specified URL using curl
curl -LJO $url
echo "Download Complete..."

# Extract the build file into the new folder
echo "extract files to the folder"
unzip build.zip
sleep 2
rm build.zip

#cd build
# Replace "System_name" and "ip_address" in the "setup.txt" file
system_name=$(hostname)
ip_address=$(Ipconfig getifaddr en0)
perl -pi -e "s/System_name/$system_name/g; s/ip_address/$ip_address/g" build/Setup.txt

# Zip all the extracted files and name it as the same name as the original zip file
sleep 2
zip -r "build.zip" build

# Delete the original zip file
sleep 2
rm -r build

