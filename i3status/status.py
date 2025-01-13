from i3pystatus import Status
from i3pystatus.updates import pacman, yay

status = Status(logfile='$HOME/.config/i3status/i3pystatus.log')

status.register(
    "clock",
    format="  %a %-d %b %X",
    color="#C678DD",
)

status.register("load", color="#D420AC")

status.register(
    "cpu_usage",
    color="#00AA01",
    on_leftclick="urxvt -e 'htop'",
    format=" {usage}%",
)


status.register(
    "mem",
    color="#999999",
    warn_color="#E5E500",
    alert_color="#FF1919",
    format="   {avail_mem}/{total_mem} GB",
    divisor=1073741824,
)

# status.register("disk",
#     color='#56B6C2',
#     path="/home",
#     on_leftclick="pcmanfm",
#     format="   {avail} GB",)

status.register(
    "disk",
    hints={"separator": False, "separator_block_width": 3},
    color="#DD8600",
    path="/",
    format=" {avail} GB",
)

status.register("temp", color="#EF2929", format="{temp:.0f}°C",)

# status.register(
#     "battery",
#     interval=5,
#     format='{consumption:.2f}W [{levels}{status} {percentage_design:.2f}%] {remaining:%E%hh:%Mm}',
#     color="#FFFFFF",
# color="#FFFFFF",
# critical_color="#FF1919",
# charging_color="#E5E500",
# full_color="#D19A66",
#     alert=True,
#     alert_percentage=15,
#     status={"DIS": "", "CHR": "󱐋", "FULL": ""},
    # levels={10: '󰁺', 20: '󰁻', 30: '󰁼', 40: '󰁽', 50: '󰁾', 60: '󰁿', 70: '󰂀', 80: '󰂁', 90: '󰂂', 100: '󰁹'},
# )

# status.register(
#     "network",
#     interface="wlo1",
#     color_up="#8AE234",
#     color_down="#EF2929",
#     format_up=" {essid}  {kbs} kbs",
#     format_down="  ",
# )

status.register(
    "pulseaudio",
    color_unmuted="#98C379",
    color_muted="#E06C75",
    format_muted="  [muted]",
    format="  {volume}%",
)

status.register(
    "keyboard_locks",
    format="{caps}{num}",
    caps_on="󰯫 ",
    caps_off="",
    num_on=" 󰰒",
    num_off="",
    color="#00B7DC",
)

status.register(
    "updates",
    format="Updates: {count}",
    format_no_updates="",
    # backends=[pacman.Pacman()],
    backends=[pacman.Pacman(), yay.Yay()],
)

status.run()
