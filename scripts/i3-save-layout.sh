#! /bin/bash

if [ $# -eq 0 ];
then
	echo "$0: Missing arguments"
	exit 1
elif [ $# -gt 1 ];
then
	echo "$0: Too many arguments: $@"
	exit 1
else
	i3-save-tree --workspace $1 > ~/.config/i3/workspace-$1.json
	echo "Success! workspace-$1.json created!"
fi
