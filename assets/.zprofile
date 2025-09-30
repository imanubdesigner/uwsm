if uwsm check may-start > /dev/null 2>&1; then
    exec uwsm start hyprland-uwsm.desktop > /dev/null 2>&1
fi

