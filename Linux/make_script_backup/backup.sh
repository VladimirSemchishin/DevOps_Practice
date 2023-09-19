#!/bin/bash

BDIR=/backup
BDATE=$(date +'%d.%m.%Y_%H.%M')
FILENAME=$BDIR/$(hostname)_$BDATE

tar -cvzf $FILENAME.tar.gz -C /home/user . &> $FILENAME.log