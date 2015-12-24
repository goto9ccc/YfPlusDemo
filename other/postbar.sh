#!/bin/bash
while :
    do
        echo -e \\n
	read barcode
        if [ "$barcode" = exit ]
	then
            break
        else
           curl -d "barcode=$barcode" http://192.168.1.115:81/barcode/postbar
        fi
done
