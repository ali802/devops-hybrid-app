#!/bin/bash

echo "=========================================="
echo "📊 INFRASTRUCTURE HEALTH REPORT"
echo "=========================================="
echo "Timestamp: $(date)"

# Check CPU Idle percentage and calculate usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "🖥️  CPU Usage: $CPU_USAGE%"

# Check Free Memory
MEM_USAGE=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
echo "🧠 Memory Usage: $MEM_USAGE"

# Check Disk Usage on the root partition
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "💾 Disk Usage: $DISK_USAGE"

echo "=========================================="#!/bin/bash

echo "=========================================="
echo "📊 INFRASTRUCTURE HEALTH REPORT"
echo "=========================================="
echo "Timestamp: $(date)"

# Check CPU Idle percentage and calculate usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "🖥️  CPU Usage: $CPU_USAGE%"

# Check Free Memory
MEM_USAGE=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
echo "🧠 Memory Usage: $MEM_USAGE"

# Check Disk Usage on the root partition
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "💾 Disk Usage: $DISK_USAGE"

echo "=========================================="
