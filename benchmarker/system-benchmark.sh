#!/bin/bash
# This script benchmarks CPU, memory, and disk
# If you are using this script, you can star this repo ;)

# Function to check OS and install sysbench
install_sysbench() {
	os_name=$(grep '^ID=' /etc/os-release | cut -d= -f2)
	if [[ "$os_name" == "ubuntu" ]]; then
		echo "Ubuntu detected. Installing sysbench..."
		sudo apt-get update
		sudo apt-get install sysbench -y
	else
		echo "This script supports only Ubuntu. Exiting."
		exit 1
	fi
}

# Check if sysbench is installed, if not, install it
if ! command -v sysbench &>/dev/null; then
	install_sysbench
fi

# Output file for the benchmark report
benchmark_report="system_benchmark_report_$(date +%F).txt"

echo "Starting System Benchmarking..." >"$benchmark_report"

# CPU Benchmark
echo "Running CPU benchmark..." >>"$benchmark_report"
sysbench cpu --cpu-max-prime=20000 run >>"$benchmark_report"

# Memory Benchmark
echo "Running Memory benchmark..." >>"$benchmark_report"
sysbench memory run >>"$benchmark_report"

# Disk I/O Benchmark
echo "Running Disk I/O benchmark..." >>"$benchmark_report"
sysbench fileio --file-total-size=1G prepare
sysbench fileio --file-total-size=1G --file-test-mode=rndrw --time=300 --max-requests=0 run >>"$benchmark_report"
sysbench fileio --file-total-size=1G cleanup

echo "Benchmarking Completed. Report generated: $benchmark_report"
