#!/usr/bin/env bash

#  ┓ ┏┓┳┳┳┓┏┓┓┏┏┓┳┓
#  ┃ ┣┫┃┃┃┃┃ ┣┫┣ ┣┫
#  ┗┛┛┗┗┛┛┗┗┛┛┗┗┛┛┗
#           by Manu

dir="$HOME/.config/rofi/launcher/"
theme='style-7'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
