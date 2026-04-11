#!/usr/bin/env bash
LOG_FILE="/tmp/eve-debug.log"
TMUX="/opt/homebrew/bin/tmux"
URL="$1"

echo "URL received: $URL" >> "$LOG_FILE"

# --- Parse URL (no subshells) ---
PROTO="${URL%%:*}"
REST="${URL#*://}"
HOST="${REST%:*}"
PORT="${REST##*:}"

if [ -z "$PORT" ]; then
  [ "$PROTO" = "ssh" ]    && PORT=22
  [ "$PROTO" = "telnet" ] && PORT=23
fi

if [ "$PROTO" = "ssh" ]; then
  CMD="/usr/bin/ssh $HOST -p $PORT"
else
  CMD="/opt/homebrew/bin/telnet $HOST $PORT"
fi

echo "Parsed -> proto=$PROTO host=$HOST port=$PORT" >> "$LOG_FILE"

# --- Serialize concurrent executions ---
LOCK="/tmp/eve-tmux.lock"
exec 9>"$LOCK"
flock 9

# --- Ensure tmux server + session ---
if ! $TMUX ls >/dev/null 2>&1; then
  echo "No tmux session, launching Alacritty" >> "$LOG_FILE"
  /usr/bin/open -a Alacritty
  sleep 2
fi

SESSION=$($TMUX ls -F '#{session_attached} #{session_name}' 2>/dev/null \
  | awk '$1 > 0 {print $2}' | head -n1)

if [ -z "$SESSION" ]; then
  SESSION="main"
  $TMUX new-session -d -s "$SESSION"
fi

echo "Using session: $SESSION" >> "$LOG_FILE"

TARGET="$SESSION:eve-lab"

# --- Kill eve-lab if all panes are dead ---
if $TMUX list-windows -t "$SESSION" -F '#W' | grep -q "^eve-lab$"; then
  ALIVE=$($TMUX list-panes -t "$TARGET" -F '#{pane_dead}' | grep -c "^0$")
  if [ "$ALIVE" -eq 0 ]; then
    echo "All panes dead, killing eve-lab window" >> "$LOG_FILE"
    $TMUX kill-window -t "$TARGET"
  fi
fi

# --- Create eve-lab window or split a new pane ---
if ! $TMUX list-windows -t "$SESSION" -F '#W' | grep -q "^eve-lab$"; then
  echo "Creating eve-lab window with first connection" >> "$LOG_FILE"
  $TMUX new-window -t "$SESSION" -n "eve-lab" $CMD
else
  PANE_COUNT=$($TMUX list-panes -t "$TARGET" -F '#{pane_dead}' | grep -c "^0$")
  echo "Splitting new pane, alive count: $PANE_COUNT" >> "$LOG_FILE"
  if (( PANE_COUNT % 2 == 0 )); then
    $TMUX split-window -h -t "$TARGET" $CMD
  else
    $TMUX split-window -v -t "$TARGET" $CMD
  fi
fi

# --- Label, layout, focus ---
$TMUX select-pane -t "$TARGET" -T "$HOST:$PORT"
$TMUX select-layout -t "$TARGET" tiled
$TMUX select-window -t "$TARGET"
osascript -e 'tell application "Alacritty" to activate'
