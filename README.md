# DevOpsShellHub

## Introduction
Welcome to **DevOpsShellHub** – a comprehensive collection of shell scripts tailored for DevOps tasks. This repository is designed to simplify and automate various DevOps operations. These scripts are here to save you time and effort.

## Repository Structure
The repository is organized into different folders, each dedicated to a specific DevOps function:

- `aws/`: Scripts related to Amazon Web Services operations.
- `benchmarkers/`: Scripts to get system hardware information and capacity.
- `docker/`: Scripts for docker management and monitoring.
- `libs/`: Library scripts that support various functionalities.
- `log-management/`: Scripts for managing and analyzing logs.
- `monitoring/`: Scripts to set up and manage monitoring solutions.
- `user-management/`: Scripts for managing linux system users.

### aws
- `autoscale.sh`: Fetches and displays detailed information about AWS Auto-Scaling Groups.
- `cost.sh`: Fetches and displays detailed information about AWS cloud bill.
- `ec2-list.sh`: Fetches and displays details of running EC2 instances, including names, private and public IP addresses, and instance types in a formatted table.
### benchmarker
- `spec-collector.sh`: Collect and report system hardware and software configuration.
- `system-benchmark.sh`: Benchmarks CPU, memory, and disk.
### docker
- `container-stats.sh`:  Monitors and logs CPU and memory usage of Docker containers
### libs
- `common-log.sh`: Library scripts for log format.
### log-management
- `rotate-log.sh`: Automates the rotation and compression of log files.
### monitoring
- `disk-monitor.sh`:  Monitors specified mount points for disk usage in a Linux system.
- `network-latency-monitor.sh`: Logs the latency in a file.
- `process-monitor.sh`:  Monitors specified critical processes on a server and automatically attempts to restart them if they are not running.
- `ssl-monitor.sh`: Checks the expiration dates of SSL certificates.
- `web-monitor.sh`: Monitors a list of websites for availability.


## Getting Started
To use these scripts, clone the repository and navigate to the desired script directory:

```bash
git clone https://github.com/yourusername/DevOpsShellHub.git
cd DevOpsShellHub/