#!/usr/bin/env bash
# kb-monitor.sh — следим за раскладкой и уведомляем через dunst

kbd_name="micro-star-int'l-co.,ltd--msi-gk30-gaming-keyboard-"
notif_replace_id=2601  # чтобы уведомления заменялись
interval=0.5            # проверяем каждые 0.5 секунды

# Проверка утилит
for cmd in hyprctl jq notify-send; do
    command -v $cmd >/dev/null 2>&1 || { echo "$cmd не найден!"; exit 1; }
done

last_layout=""

while true; do
    # получаем текущую раскладку
    active_layout=$(hyprctl -j devices | jq -r \
        --arg k "$kbd_name" '.keyboards[] | select(.name==$k) | .active_keymap')
    
    [ -z "$active_layout" ] && { sleep $interval; continue; }

    # если раскладка изменилась — показываем уведомление
    if [ "$active_layout" != "$last_layout" ]; then
        last_layout="$active_layout"
        
        # преобразуем к флагу
        flag="$active_layout"
        case "$active_layout" in
            "English (US)") flag="🇺🇸" ;;
            "Russian") flag="🇷🇺" ;;
            de|DE) flag="🇩🇪" ;;
            fr|FR) flag="🇫🇷" ;;
            tr|TR) flag="🇹🇷" ;;
            uk|UK) flag="🇬🇧" ;;
            ua|UA) flag="🇺🇦" ;;
        esac
        
        # уведомление через dunst
        notify-send -u low -t 1200 -r "$notif_replace_id" "Layout" "$flag  $active_layout"
    fi

    sleep $interval
done
