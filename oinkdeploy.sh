#!/bin/bash
if ! command -v lftp &> /dev/null; then
    echo "lftp is not installed."
    exit 1
fi

read -r -p "Enter FTP server address (default: pixie-ftp.porkbun.com): " ftpserver
ftpserver=${ftpserver:-pixie-ftp.porkbun.com}

while [[ -z "$ftpusername" ]]; do
    read -r -p "Enter FTP username: " ftpusername
done

read -r -s -p "Enter FTP password: " ftppassword
echo

# Modify below to suit your needs:

localfolder='public/'
remotefolder='/'

echo "Wiping old site"
lftp -c "open ftp://$ftpusername:$ftppassword@$ftpserver && \
echo 'Deleting files from server' && \
rm -rf . && \
echo 'Mirroring' && \
mirror -R --parallel=3 $localfolder $remotefolder"

echo Done
