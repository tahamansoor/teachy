#!/usr/bin/env bash
# Save a timestamped copy of the learner's file(s) and print the diff vs the previous snapshot.
# Snapshots are the evidence used to grade the learner's process, so never delete them mid-session.
#
# Usage: snapshot.sh <state_dir> <label> <file>...
#   label is a short tag recorded in the index (e.g. START, IDLE, CHECKIN, MANUAL, FINAL)
set -u

if [ $# -lt 3 ]; then
  echo "usage: snapshot.sh <state_dir> <label> <file>..." >&2
  exit 2
fi

state="$1"; label="$2"; shift 2
snaps="$state/snapshots"
mkdir -p "$snaps"

prev=$(find "$snaps" -mindepth 1 -maxdepth 1 -type d | sort | tail -n 1)
ts=$(date +%Y%m%d-%H%M%S)
cur="$snaps/$ts"
tmp="$snaps/.tmp-$ts"
mkdir -p "$tmp"

for f in "$@"; do
  name=$(echo "$f" | sed 's#^/##; s#/#__#g')
  if [ -f "$f" ]; then cp "$f" "$tmp/$name"; fi
done

if [ -n "$prev" ] && diff -rq "$prev" "$tmp" > /dev/null 2>&1; then
  rm -rf "$tmp"
  echo "$ts $label (no change since $(basename "$prev"))" >> "$snaps/INDEX.log"
  echo "No content change since last snapshot ($(basename "$prev"))."
  exit 0
fi

mv "$tmp" "$cur"
echo "$ts $label" >> "$snaps/INDEX.log"
echo "snapshot=$cur"
if [ -n "$prev" ]; then
  echo "--- diff vs $(basename "$prev") ---"
  diff -ru "$prev" "$cur" | head -n 300
else
  echo "(first snapshot)"
fi
