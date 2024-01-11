show_vpn() {
  local vpn_name
  local vpn_icon

  vpn_name=$(get_vpn_name)
  vpn_icon=""

  # Module
  local index
  local icon
  local color
  local text
  local module

  index=$1
  icon=$(get_tmux_option "@catppuccin_vpn_icon" "$vpn_icon")
  color=$(get_tmux_option "@catppuccin_vpn_color" "$thm_magenta")
  text=$(get_tmux_option "@catppuccin_vpn_text" "$vpn_name")
  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}

get_vpn_name() {
  if nmcli -f NAME,TYPE con show --active | grep -i "vpn" 1>/dev/nul; then
    nmcli -f NAME,TYPE con show --active | grep --color=never -i "vpn" | awk '{print $1}'
  else
    echo "No Active VPN"
  fi
}
