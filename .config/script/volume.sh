#!/bin/bash

SINK="@DEFAULT_SINK@"
STATE_FILE="/tmp/.wp_volume_state"

get_vol() { wpctl get-volume "$SINK" | awk '/Volume:/ {printf("%d",$2*100+0.5)}'; }
get_mute() { wpctl get-mute "$SINK" | awk '{print $2}'; }

notify_vol() {
  local vol="$1" mute="$2"
  local icon body

  if [ "$mute" = "yes" ] || [ "$vol" -le 0 ]; then
    icon="audio-volume-muted"
    body="Выключен"
  elif [ "$vol" -le 33 ]; then
    icon="audio-volume-low"
    body="${vol}%"
  elif [ "$vol" -le 66 ]; then
    icon="audio-volume-medium"
    body="${vol}%"
  else
    icon="audio-volume-high"
    body="${vol}%"
  fi

  # Проигрываем звук уведомления
  paplay /usr/share/sounds/freedesktop/stereo/message.oga &

  # Отправляем уведомление через dunst
  notify-send -a "Volume" -i "$icon" -r 5566 "Громкость" "$body" -t 1200
}

PREV_VOL=-1
PREV_MUTE="unknown"

while true; do
  CUR_VOL="$(get_vol)"
  CUR_MUTE="$(get_mute)"

  if [ "$CUR_VOL" != "$PREV_VOL" ] || [ "$CUR_MUTE" != "$PREV_MUTE" ]; then
    notify_vol "$CUR_VOL" "$CUR_MUTE"
    PREV_VOL="$CUR_VOL"
    PREV_MUTE="$CUR_MUTE"
  fi

  sleep 0.3
done
