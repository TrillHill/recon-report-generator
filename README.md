# Recon Report Generator

A Bash-based reconnaissance automation script that runs common recon tasks against a target domain and organizes the results into a structured output directory.

This script supports Nmap scanning, Dirsearch content discovery, and crt.sh certificate transparency collection. It is designed for authorized security testing, lab environments, and personal penetration testing workflows.

## Features

* Runs Nmap against a target domain
* Runs Dirsearch for web content discovery
* Pulls certificate transparency data from crt.sh
* Stores results in a dedicated output directory
* Generates a basic reconnaissance report
* Supports selective scan modes

## Supported Scan Modes

```bash
all
nmap-only
dirsearch-only
crt-only
```

## Requirements

The following tools must be installed:

* nmap
* curl
* jq
* python3
* dirsearch

The script currently expects Dirsearch to be located at:

```bash
/home/kali/dirsearch
```

You can update the `PATH_TO_DIRSEARCH` variable in the script if your installation path is different.

## Usage

Run all scans:

```bash
./recon.sh example.com
```

Run only Nmap:

```bash
./recon.sh example.com nmap-only
```

Run only Dirsearch:

```bash
./recon.sh example.com dirsearch-only
```

Run only crt.sh collection:

```bash
./recon.sh example.com crt-only
```

## Output

Results are saved in a directory named after the target domain:

```bash
example.com_recon/
```

Generated files may include:

```bash
nmap_results.txt
dirsearch_results.txt
crt_results.json
report.txt
```

## Example

```bash
./recon.sh testphp.vulnweb.com all
```

This creates:

```bash
testphp.vulnweb.com_recon/
```

and stores scan results and a generated report inside that directory.

## Security Notice

This tool is intended only for authorized security testing, educational use, lab environments, and systems you own or have explicit permission to assess. Do not run this script against targets without authorization.

## Author
Jacob Hill
TrillCyber
https://trillcyber.wordpress.com
