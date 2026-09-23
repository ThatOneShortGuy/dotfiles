#!/usr/bin/env bash
# Claude Code notification hook.
#
#   notify.sh done    (Stop hook)          Claude finished its turn
#   notify.sh input   (Notification hook)  Claude needs permission / input
#
# Reads the hook JSON on stdin. The notification stays up until dismissed;
# left-clicking it (dunst: do_action) focuses the Hyprland window and the kitty
# tab that Claude is running in.
set -uo pipefail

kind=${1:-done}
json=$(cat)
dir=$(basename "$(jq -r '.cwd // "."' <<<"$json")")

# The kitty window this Claude runs in. KITTY_LISTEN_ON is only set when kitty
# was started with listen_on; fall back to the socket name kitty.conf uses.
kitty_pid=${KITTY_PID:-}
kitty_win=${KITTY_WINDOW_ID:-}
kitty_sock=${KITTY_LISTEN_ON:-${kitty_pid:+unix:@kitty-$kitty_pid}}

# Prefer the kitty tab title (vpws names them "<workspace>:claude").
where=$dir
if [[ -n $kitty_sock && -n $kitty_win ]]; then
    tab=$(kitten @ --to "$kitty_sock" ls --match "id:$kitty_win" 2>/dev/null |
        jq -r '.[0].tabs[0].title // empty' 2>/dev/null)
    [[ -n $tab ]] && where=$tab
fi

if [[ $kind == input ]]; then
    title="Claude Code — needs input ($where)"
    body=$(jq -r '.message // "Needs your input"' <<<"$json")
    urgency=critical
else
    title="Claude Code — done"
    body="Finished in $where"
    urgency=normal
fi

focus() {
    if [[ -n $kitty_pid ]]; then
        hyprctl dispatch focuswindow "pid:$kitty_pid" >/dev/null 2>&1
    fi
    if [[ -n $kitty_sock && -n $kitty_win ]]; then
        kitten @ --to "$kitty_sock" focus-window --match "id:$kitty_win" >/dev/null 2>&1
    fi
}

# Detach so the hook returns immediately while the notification waits for a click.
export -f focus
export kitty_pid kitty_win kitty_sock
setsid -f bash -c '
    action=$(notify-send -t 0 -u "$1" -a "Claude Code" -A default=Focus "$2" "$3")
    [[ $action == default ]] && focus
' _ "$urgency" "$title" "$body" >/dev/null 2>&1 </dev/null

exit 0
