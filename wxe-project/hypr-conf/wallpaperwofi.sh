#!/usr/bin/env bash

# Папка с твоими обоями
WALLPAPER_DIR="/home/mrblack/.config/sway/wallpaper"
MONITOR="HDMI-A-1"

# Проверяем rofi
if ! command -v rofi &> /dev/null; then
    echo "Ошибка: rofi не установлен."
    exit 1
fi

# Выбор файла через Rofi
SELECTED_WALLPAPER=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Выбери обои:")

# Если нажали Esc — выходим
if [ -z "$SELECTED_WALLPAPER" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER"

# Убиваем старый плеер
pkill mpvpaper
sleep 0.2

# Запуск mpvpaper с жестко прописанными флагами (без бьющихся переменных)
mpvpaper -o "loop" --mpv-options "--video-unscaled=no --keepaspect=no --loop-file=inf --loop-anim=yes" "$MONITOR" "$FULL_PATH" &

exit 0
