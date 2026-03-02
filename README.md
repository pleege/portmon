# PortMon - Linux Port Traffic Monitor

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)

A lightweight, zero-dependency Linux port traffic monitoring tool using iptables. Track per-port network traffic with hourly/daily statistics and process identification.

## Features

- 📊 **Per-Port Traffic Monitoring** - Track inbound/outbound traffic for each port
- 🕐 **Hourly/Daily Statistics** - Automatic aggregation and historical reporting
- 🔍 **Process Identification** - See which application is using each port
- 🚀 **Zero Dependencies** - Pure Bash, only requires iptables
- 💾 **Low Resource Usage** - Minimal CPU and memory footprint
- 🎨 **Colorized Output** - Easy to read terminal output

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/pleege/portmon.git
cd portmon

# Install
sudo cp portmon /usr/local/bin/
sudo chmod +x /usr/local/bin/portmon

# Setup (initialize iptables rules)
sudo portmon setup
```

### Usage

```bash
# View current traffic status
sudo portmon status

# Start background recording (every 60 seconds)
sudo portmon live &

# View today's statistics
sudo portmon report today

# View current hour's statistics
sudo portmon report hour

# View yesterday's statistics
sudo portmon report yesterday

# View specific date
sudo portmon report 20260302

# List available reports
sudo portmon list
```

## Sample Output

### Status View
```
=== PortMon - Current Traffic Status ===
Time: 2026-03-02 16:59:56

Port     Process                  Inbound    Outbound
─────────────────────────────────────────────────────────────────────
22       sshd                        5 MB        6 MB
80       nginx                     153 KB        1 MB
443      nginx                      13 MB      317 MB
8000     python3                    26 KB       43 KB
8008     app                         8 MB       18 MB
```

### Daily Report
```
=== Daily Stats: 2026-03-02 ===

Port     Process               Inbound   Outbound      Total  Share
────────────────────────────────────────────────────────────────────────────────
22       sshd                     5 MB       6 MB      12 MB      3%
80       nginx                  155 KB       1 MB       2 MB      0%
443      nginx                   13 MB     317 MB     331 MB     87%
8008     app                      8 MB      18 MB      27 MB      7%
8808     docker-proxy           274 KB       3 MB       4 MB      1%
────────────────────────────────────────────────────────────────────────────────
Total                                                  377 MB
```

## Systemd Service

For persistent monitoring, use the included systemd service:

```bash
# Copy service file
sudo cp systemd/portmon.service /etc/systemd/system/

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable portmon
sudo systemctl start portmon

# Check status
sudo systemctl status portmon
```

## How It Works

PortMon uses iptables to count packets and bytes for each port:

1. Creates a custom iptables chain `PORTMON`
2. Adds rules to count traffic for each monitored port
3. Reads counters from `/proc/net/ip_tables_names`
4. Stores data in `/var/lib/portmon/` for historical analysis

## Data Storage

- **Hourly data**: `/var/lib/portmon/hourly/YYYYMMDDHH.log`
- **Daily data**: `/var/lib/portmon/daily/YYYYMMDD.log`

Logs are rotated automatically (7 days for hourly, 30 days for daily).

## Requirements

- Linux with iptables support
- Root privileges (for iptables manipulation)
- Bash 4.0+

## Commands Reference

| Command | Description |
|---------|-------------|
| `setup` | Initialize iptables and auto-detect ports |
| `live` | Start background recording |
| `status` | Show current traffic status |
| `report [period]` | Show statistics for period |
| `list` | List available reports |
| `reset` | Reset iptables counters |
| `cleanup` | Remove all iptables rules |

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

- **pleege** - [@pleege](https://github.com/pleege)
