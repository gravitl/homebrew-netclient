#!/bin/bash

# must be run from fileserver
# set environment var VERSION = netclient version without leading v  --- 0.13.0 vice v0.13.0
# run from build dir

#cp arch independent files
cp ../Casks/scripts/install.sh .
cp ../Casks/scripts/uninstall.sh .
sed -i s/"VERSION/$VERSION"/  install.sh

#get amd64 binary
wget -O netclient "https://github.com/gravitl/netclient/releases/download/v$VERSION/netclient_darwin_amd64"
chmod +x netclient
cp ../service/com.gravitl.netclient.plist .
tar -zcf netclient-amd64.tgz netclient com.gravitl.netclient.plist install.sh uninstall.sh

#get arm64 binary
wget -O netclient "https://github.com/gravitl/netclient/releases/download/v$VERSION/netclient_darwin_arm64"
chmod +x netclient
cp ../service/com.gravitl.netclient.plist.m1 com.gravitl.netclient.plist
tar -zcf netclient-arm64.tgz netclient com.gravitl.netclient.plist install.sh uninstall.sh

#calc sha
SHA1=$(shasum -a 256 netclient-amd64.tgz | cut -d " " -f 1)
SHA2=$(shasum -a 256 netclient-arm64.tgz | cut -d " " -f 1)

#update 
sed -i "3s/.*/\  version \"$VERSION\"/" ../Casks/netclient.rb
sed -i "6s/.*/\    sha256 \"$SHA1\"/"  ../Casks/netclient.rb
sed -i "8s/.*/\    sha256 \"$SHA2\"/" ../Casks/netclient.rb

#copy files to netmaker.org
mkdir -p /var/www/files/v$VERSION/darwin/
cp netclient-amd64.tgz /var/www/files/v$VERSION/darwin/
cp netclient-arm64.tgz /var/www/files/v$VERSION/darwin/
