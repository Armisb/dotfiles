#!/bin/bash

hyprctl reload
sleep 0.3
hyprctl dispatch dpms off
sleep 0.5
hyprctl dispatch dpms on

