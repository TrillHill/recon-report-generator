#!/bin/bash

set -euo pipefail

PATH_TO_DIRSEARCH="/home/kali/dirsearch"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <domain> [scan-type]"
  echo "scan-type: nmap-only | dirsearch-only | crt-only | all"
  exit 1
fi

DOMAIN=$1
SCAN_TYPE=${2:-all}
DIRECTORY="${DOMAIN}_recon"

mkdir -p "$DIRECTORY"

command -v nmap >/dev/null || { echo "nmap is not installed."; exit 1; }
command -v curl >/dev/null || { echo "curl is not installed."; exit 1; }
command -v jq >/dev/null || { echo "jq is not installed."; exit 1; }

if [[ ! -f "$PATH_TO_DIRSEARCH/dirsearch.py" ]]; then
  echo "Dirsearch not found at $PATH_TO_DIRSEARCH."
  exit 1
fi

nmap_scan() {
  echo "Running Nmap scan on $DOMAIN..."
  nmap "$DOMAIN" > "$DIRECTORY/nmap_results.txt"
}

dirsearch_scan() {
  echo "Running Dirsearch scan on $DOMAIN..."
  python3 "$PATH_TO_DIRSEARCH/dirsearch.py" -u "$DOMAIN" -e php -o "$DIRECTORY/dirsearch_results.txt"
}

crt_scan() {
  echo "Fetching certificate data from crt.sh for $DOMAIN..."
  curl -s "https://crt.sh/?q=$DOMAIN&output=json" -o "$DIRECTORY/crt_results.json"
}

case "$SCAN_TYPE" in
  nmap-only)
    nmap_scan
    ;;
  dirsearch-only)
    dirsearch_scan
    ;;
  crt-only)
    crt_scan
    ;;
  all)
    nmap_scan
    dirsearch_scan
    crt_scan
    ;;
  *)
    echo "Invalid scan type: $SCAN_TYPE"
    echo "Valid types: nmap-only | dirsearch-only | crt-only | all"
    exit 1
    ;;
esac

REPORT_FILE="$DIRECTORY/report.txt"
TODAY=$(date)

{
  echo "Reconnaissance Report for $DOMAIN"
  echo "Scan Date: $TODAY"
  echo

  echo "========================"
  echo "NMAP RESULTS"
  echo "========================"
  if [[ -f "$DIRECTORY/nmap_results.txt" ]]; then
    cat "$DIRECTORY/nmap_results.txt"
  else
    echo "Nmap scan was not run."
  fi
  echo

  echo "========================"
  echo "DIRSEARCH RESULTS"
  echo "========================"
  if [[ -f "$DIRECTORY/dirsearch_results.txt" ]]; then
    cat "$DIRECTORY/dirsearch_results.txt"
  else
    echo "Dirsearch scan was not run."
  fi
  echo

  echo "========================"
  echo "CRT.SH RESULTS"
  echo "========================"
  if [[ -f "$DIRECTORY/crt_results.json" ]]; then
    jq -r ".[]? | .name_value" "$DIRECTORY/crt_results.json" 2>/dev/null || echo "No valid crt.sh results found."
  else
    echo "crt.sh scan was not run."
  fi

} > "$REPORT_FILE"

echo "Recon report generated: $REPORT_FILE"
