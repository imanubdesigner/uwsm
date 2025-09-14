#!/usr/bin/env bash

#  ┏┓┳┳┓┏┓┏┳┳
#  ┣ ┃┃┃┃┃ ┃┃
#  ┗┛┛ ┗┗┛┗┛┻
#     by Manu

dir="$HOME/.config/rofi/emoji/"
theme='emoji'

## Run
rofi \
  -show emoji \
  -theme ${dir}/${theme}.rasi
