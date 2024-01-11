show_battery() {
  local battery_icon
  local battery_percentage

  battery=$(get_battery_percentage)
  battery_icon=$(display_icon "$battery")
  battery_percentage="${battery} %"

  # Module
  local index
  local icon
  local color
  local text
  local module

  index=$1
  icon=$(get_tmux_option "@catppuccin_battery_icon" "$battery_icon")
  color=$(get_tmux_option "@catppuccin_battery_color" "$thm_red")
  text=$(get_tmux_option "@catppuccin_battery_text" "$battery_percentage")
  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}

get_battery_percentage() {
  if command -v upower &>/dev/null; then
    upower -i "$(upower -e | grep BAT)" | grep --color=never -E "percentage" | awk '{print $2}' | tr -d '%'
  elif command -v wsl &>/dev/null; then
    bat_percentage=$(wsl powershell -command "& {Get-WmiObject -Class 'BatteryStatus' -Namespace 'root/cimv2/power' | Select-Object -ExpandProperty 'EstimatedChargeRemaining'}")
    echo "$bat_percentage"
  else
    echo "Battery Status Unknown"
    exit 1
  fi
}

display_icon() {
  percentage=$1
  state=$(upower -i "$(upower -e | grep BAT)" | grep --color=never -E "state" | awk '{print $2}')

  if [ "$state" = "charging" ]; then
    echo "󰚥"
  elif [ "$percentage" -ge 90 ]; then
    echo "󰁹"
  elif [ "$percentage" -ge 80 ]; then
    echo "󰁹"
  elif [ "$percentage" -ge 70 ]; then
    echo "󰂁"
  elif [ "$percentage" -ge 60 ]; then
    echo "󰁿"
  elif [ "$percentage" -ge 50 ]; then
    echo "󰁾"
  elif [ "$percentage" -ge 40 ]; then
    echo "󰁽"
  elif [ "$percentage" -ge 30 ]; then
    echo "󰁼"
  elif [ "$percentage" -ge 20 ]; then
    echo "󰁻"
  elif [ "$percentage" -ge 10 ]; then
    echo "󰁺"
  fi
}
