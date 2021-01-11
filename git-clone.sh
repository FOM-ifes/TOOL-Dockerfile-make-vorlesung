#!/bin/sh
mv ./temp_ssh_key ~/.ssh/id_ed25519
mv ./temp_ssh_key.pub ~/.ssh/id_ed25519.pub

chmod 0644 ~/.ssh/id_ed25519.pub
chmod 0600 ~/.ssh/id_ed25519
chmod 0644 ~/.ssh/config

eval `ssh-agent`

ssh-add
ssh-add -l
git clone $1 $2