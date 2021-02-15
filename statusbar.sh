# Date and time
date_and_week="  $(date "+%d/%m")"
current_time="  $(date "+%H:%M")"

# Brightness
backlight="  $(($(($(brightnessctl g)*100))/$(brightnessctl m)))%"

# Battery
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio
audio_volume=$(amixer sget Master | grep "Left:" | cut -d '[' -f2 | cut -d ']' -f1)
audio_is_muted=$(amixer sget Master | grep "off" | wc -c)

# Microphone
mic_volume=$(amixer sget Master | grep "Left:" | cut -d '[' -f2 | cut -d ']' -f1)
mic_is_muted=$(amixer sget Capture | grep "off" | wc -c)

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping="$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1) ms" # 

# Others
# weather=$(env | grep WEATHER)
cpu="  `LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'`%"
ram=" `free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }'`"
disk="  `df -h / | awk '/\// {print $(NF-1)}'`"

# Icons taken from https://fontawesome.com/icons
if [ "$battery_status" = "discharging" ];
then
    battery_pluggedin=''
else
    battery_pluggedin=' '
fi

if ! [ $network ]
then
   network_active=' '
else
   network_active=' '
fi

if [ "$audio_is_muted" != "0" ]
then
    audio_active=' '
else
    audio_active=' '
fi

if [ "$mic_is_muted" = "0" ]
then
    mic_active=' '
else
    mic_active=' '
fi

# Statusline

pied_piper=' '

echo "$network_active $ping | $mic_active $mic_volume | $backlight | $battery_pluggedin $battery_charge | $current_time | $date_and_week | $pied_piper"
