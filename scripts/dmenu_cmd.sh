#!/bin/bash

# not from stdin to get a running bar
cmd=$(dmenu -p "Run command:" <&-)
[ -n "$cmd" ] && bash -c "$cmd" &
