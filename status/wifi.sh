show_wifi() {
  local wifi_name
  local wifi_icon

  wifi_name=$(get_wifi_name)
  wifi_icon=""

  # Module
  local index
  local icon
  local color
  local text
  local module

  index=$1
  icon=$(get_tmux_option "@catppuccin_wifi_icon" "$wifi_icon")
  color=$(get_tmux_option "@catppuccin_wifi_color" "$thm_yellow")
  text=$(get_tmux_option "@catppuccin_wifi_text" "$wifi_name")
  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}

get_wifi_name() {
  wifi=""

  if command -v iwgetid &>/dev/null; then
    wifi=$(iwgetid -r)
  elif command -v wsl &>/dev/null; then
    wifi=$(wsl powershell -command "& {Get-NetConnectionProfile | Select-Object -ExpandProperty SSID}")
  fi

  if [ -n "$wifi" ]; then
    echo "$wifi"
  else
    echo "No Active Wifi"
  fi
}
