#!/bin/bash
# ~/.config/i3/scripts/rootkit_check.sh
# Improved rootkit detection script for i3blocks

# Configuration
CACHE_FILE="/tmp/rootkit_check_cache"
CACHE_VALIDITY=3600  # Cache validity in seconds (1 hour)
TIMEOUT=300          # Timeout in seconds (5 minutes)
LOG_FILE="/var/log/rootkit_check.log"
ENABLE_LOGGING=false  # Set to true to enable logging

# Function to log messages if logging is enabled
log_message() {
    if [ "$ENABLE_LOGGING" = true ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE" > /dev/null
    fi
}

# Check if we can use sudo without password
check_sudo_nopasswd() {
    sudo -n true 2>/dev/null
    return $?
}

# Function to display status
display_status() {
    local status="$1"
    local icon="$2"
    local color="$3"
    
    echo "$status"
    echo "$icon"
    echo "$color"
    
    if [ "$ENABLE_LOGGING" = true ]; then
        log_message "Status: $status"
    fi
    
    exit 0
}

# Check if chkrootkit is installed
if ! command -v chkrootkit >/dev/null; then
    display_status "chkrootkit?" "?" "#AAAAAA"
fi

# Check if we can use sudo
if ! check_sudo_nopasswd; then
    display_status "Need sudo" "🔒" "#FFAA00"
fi

# Check if cache exists and is still valid
if [ -f "$CACHE_FILE" ]; then
    cache_time=$(stat -c %Y "$CACHE_FILE")
    current_time=$(date +%s)
    elapsed_time=$((current_time - cache_time))
    
    if [ "$elapsed_time" -lt "$CACHE_VALIDITY" ]; then
        # Cache is still valid, read from it
        cached_result=$(cat "$CACHE_FILE")
        if [ "$cached_result" = "CLEAN" ]; then
            display_status "✅ Secure" "✅" "#00FF00"
        else
            display_status "🛑 Rootkit!" "🛑" "#FF0000"
        fi
    fi
fi

# Show scanning status while check is running
echo "🔍 Scanning..."
echo "🔍"
echo "#FFFF00"

# Run chkrootkit with timeout
result=$(timeout "$TIMEOUT" sudo chkrootkit 2>/dev/null | grep -i "INFECTED" || echo "TIMEOUT")

# Handle timeout
if [ "$result" = "TIMEOUT" ]; then
    log_message "chkrootkit timed out after $TIMEOUT seconds"
    display_status "⏱️ Timeout" "⏱️" "#FF8800"
fi

# Save result to cache
if [ -n "$result" ]; then
    echo "INFECTED" > "$CACHE_FILE"
    display_status "🛑 Rootkit!" "🛑" "#FF0000"
else
    echo "CLEAN" > "$CACHE_FILE"
    display_status "✅ Secure" "✅" "#00FF00"
fi