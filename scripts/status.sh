# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

date_formatted=$(date +'%d-%m-%Y %T')

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT1/status)

# Battery percentage
battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)

# Emojis and characters for the status bar
#     ⚡  \|
echo  $battery_percent% $battery_status ⚡ $date_formatted

