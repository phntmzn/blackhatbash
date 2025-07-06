#!/bin/bash

# Usage: ./trace_process.sh <process_name>
PROCESS=$1

if [ -z "$PROCESS" ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi

echo "Finding PID for process: $PROCESS"
PID=$(pgrep "$PROCESS")

if [ -z "$PID" ]; then
  echo "Process $PROCESS not found."
  exit 1
fi

echo "Tracing system calls for PID: $PID"
sudo dtruss -p "$PID"
