#!/usr/bin/env bash

## Author : Manuel B. (manu)
## Github : @imanubdesigner

## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)

dir="$HOME/.config/rofi/cliphist/"
theme='cliphist'

## Run cliphist with rofi
cliphist list | rofi \
  -dmenu \
  -p "Clipboard" \
  -theme ${dir}/${theme}.rasi \
  -i \
  -no-custom \
  -format 'f' \
  -eh 2 | cliphist decode | wl-copy
