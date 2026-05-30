# Recon Report Generator

A Bash-based reconnaissance automation script that runs common recon tasks against a target domain and organizes the results into a structured output directory.

This script supports Nmap scanning, Dirsearch content discovery, and crt.sh certificate transparency collection. It is designed for authorized security testing, lab environments, bug bounty research, and penetration testing workflows.

## Features

* Runs Nmap against a target domain
* Runs Dirsearch for web content discovery
* Pulls certificate transparency data from crt.sh
* Stores results in a dedicated output directory
* Generates a basic reconnaissance report
* Supports selective scan modes
* Automates common reconnaissance tasks into a single workflow

## Requirements

The following tools must be installed:

* nmap
* curl
* jq
* python3
* dirsearch

## Installation

Clone the repository:

```bash
git clone https://github.com/TrillHill/recon-report-generator.git
```

Navigate to the project directory:

```bash
cd recon-report-generator
```

Make the script executable:

```bash
chmod +x recon.sh
```

Verify required dependencies are installed:

```bash
which nmap
which curl
which jq
which python3
```

The script currently expects Dirsearch to be located at:

```bash
/home/kali/dirsearch
```

If your Dirsearch installation is located elsewhere, update the following variable inside the script:

```bash
PATH_TO_DIRSEARCH="/path/to/dirsearch"
```

## Quick Start

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

Run only crt.sh certificate collection:

```bash
./recon.sh example.com crt-only
```

## Supported Scan Modes

| Mode           | Description                                         |
| -------------- | --------------------------------------------------- |
| all            | Runs all reconnaissance modules                     |
| nmap-only      | Runs only Nmap scanning                             |
| dirsearch-only | Runs only Dirsearch enumeration                     |
| crt-only       | Retrieves certificate transparency data from crt.sh |

## Output

Results are stored in a directory named after the target domain:

```text
example.com_recon/
```

Generated files may include:

```text
nmap_results.txt
dirsearch_results.txt
crt_results.json
report.txt
```

## Example

```bash
./recon.sh testphp.vulnweb.com all
```

Output:

```text
testphp.vulnweb.com_recon/
├── nmap_results.txt
├── dirsearch_results.txt
├── crt_results.json
└── report.txt
```

## Sample Report Structure

```text
Reconnaissance Report for example.com

========================
NMAP RESULTS
========================

80/tcp open http
443/tcp open https

========================
DIRSEARCH RESULTS
========================

/admin
/login
/uploads

========================
CRT.SH RESULTS
========================

api.example.com
vpn.example.com
dev.example.com
```

## Security Notice

This tool is intended for:

* Authorized penetration testing
* Security research
* Bug bounty activities
* Lab environments
* Educational purposes

Do not run this tool against systems, networks, or domains without explicit authorization.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Author

Jacob Hill

TrillCyber

https://trillcyber.wordpress.com

