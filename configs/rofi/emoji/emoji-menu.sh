#!/usr/bin/env bash

## Author : Manuel B. (manu)
## Github : @imanubdesigner

## Rofi   : Launcher for Emoji

dir="$HOME/.config/rofi/emoji/"
theme='emoji'

## Run
rofi \
  -show emoji \
  -theme ${dir}/${theme}.rasi
