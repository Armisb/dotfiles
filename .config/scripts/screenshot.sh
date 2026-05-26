#!/bin/fish


set screenshot_dir ~/screenshots
set filename $screenshot_dir/screenshot-(date +%Y%m%d-%H%M%S).png


mkdir -p $screenshot_dir


if grim -g (slurp) $filename
    if command -q notify-send
        notify-send "Скриншот сохранен" (basename $filename)
    end
    echo "Скриншот сохранен в: $filename"
else
    echo "Создание скриншота отменено"
end
