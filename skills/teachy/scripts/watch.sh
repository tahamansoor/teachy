#!/usr/bin/env bash
# Watch the learner's working file(s) and exit when it's time for the tutor to look.
# Run this with run_in_background so its exit wakes the tutor up.
#
# Usage: watch.sh <state_dir> <idle_seconds> <max_seconds> <file>...
#   state_dir     where snapshots live (e.g. ./.teachy)
#   idle_seconds  exit with IDLE when content hasn't changed for this long (possible "stuck")
#   max_seconds   exit with CHECKIN after this long if the learner has been making changes
#
# On exit it takes a snapshot (only if content changed) and prints a diff against
# the previous snapshot, so the tutor sees exactly what the learner did since last time.
set -u

if [ $# -lt 4 ]; then
  echo "usage: watch.sh <state_dir> <idle_seconds> <max_seconds> <file>..." >&2
  exit 2
fi

state="$1"; idle="$2"; max="$3"; shift 3
files=("$@")
here="$(cd "$(dirname "$0")" && pwd)"
poll=5

hash_now() {
  for f in "${files[@]}"; do
    if [ -f "$f" ]; then md5sum < "$f"; else echo "missing $f"; fi
  done | md5sum | cut -d' ' -f1
}

start=$(date +%s)
last_change=$start
h=$(hash_now)
changed=0

rm -f "$state/STOP"

while :; do
  sleep "$poll"
  now=$(date +%s)
  # touch <state_dir>/STOP to end the watch quietly (pause or end of session)
  if [ -f "$state/STOP" ]; then
    rm -f "$state/STOP"
    echo "TEACHY_WATCH reason=STOPPED"
    exit 0
  fi
  nh=$(hash_now)
  if [ "$nh" != "$h" ]; then
    h=$nh; last_change=$now; changed=1
  fi
  if (( now - last_change >= idle )); then reason=IDLE; break; fi
  if (( changed && now - start >= max )); then reason=CHECKIN; break; fi
done

echo "TEACHY_WATCH reason=$reason"
echo "watched_for=$(( now - start ))s  quiet_for=$(( now - last_change ))s  changed_during_watch=$changed"
echo
"$here/snapshot.sh" "$state" "$reason" "${files[@]}"
