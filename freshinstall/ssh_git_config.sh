#!/bin/bash

ssh-keygen -t rsa -b 4096 -C "daleonpz@gmail.com"
ssh-keygen -p
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# copy this to github
cat ~/.ssh/id_rsa.pub

# run this to test connection
# ssh -T git@github.com

