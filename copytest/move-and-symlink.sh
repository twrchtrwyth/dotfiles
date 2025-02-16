#!/bin/bash
echo "---"
echo "The following files were moved and symlinked:"
for file in *.{py,sh}
do
	echo $file | cut -d "." -f 1
done
echo "---"
