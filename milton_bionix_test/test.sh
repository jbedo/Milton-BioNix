#!/bin/bash
cp ../result ./output.txt
diff sample-output.txt output.txt
if [[ $(ls -A) ]]; then
    echo "Your BioNix is working perfectly!"
else
    echo "Something is wrong, please follow this guide and try to configure BioNix again"
fi