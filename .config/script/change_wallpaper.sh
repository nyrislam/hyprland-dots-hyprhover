#!/bin/bash

WALLPAPER_DIR="$HOME/Изображения/wallpapers"

# выбор обоев
CHOICE=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Выберите обои:")

if [ -n "$CHOICE" ]; then
    WALLPAPER_PATH="$WALLPAPER_DIR/$CHOICE"

    # считаем среднюю яркость (0=черный, 100=белый)
    BRIGHTNESS=$(convert "$WALLPAPER_PATH" -colorspace Gray -resize 1x1 -format "%[fx:100*mean]" info:)

    if (( $(echo "$BRIGHTNESS < 50" | bc -l) )); then
        THEME="Dark"
        matugen image "$WALLPAPER_PATH" -m dark
    else
        THEME="Light"
        matugen image "$WALLPAPER_PATH" -m light
    fi

    notify-send "Обои изменены" "$CHOICE ($THEME тема)" -i "$WALLPAPER_PATH" -t 3000
    pkill swaync && swaync &
fi
