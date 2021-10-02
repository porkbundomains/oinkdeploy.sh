#!/bin/bash
ftpusername='same as the domain name'
ftppassword='generate this from the static hosting settings page'
ftpserver='pixie-ftp.porkbun.com'
localfolder='public/'
remotefolder='/'


echo Wiping old site
lftp -c "open ftp://$ftpusername:$ftppassword@$ftpserver \
echo Deleting files from server; \
rm -rf .; \
echo Mirroring; \
mirror -R --parallel=3 $localfolder $remotefolder"

echo Done