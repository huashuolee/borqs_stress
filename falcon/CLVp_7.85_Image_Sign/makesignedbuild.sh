#!/bin/bash
./isu -i boot.unsigned -o signed_boot.bin -l key/key.pem -t 4
./xfstk-stitcher -c xfstk_boot_config.txt -k xfstk_boot.xml

