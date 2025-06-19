#!/bin/bash

# ========== Config ==========
THRESHOLD_MB=1024        # RAM minimum dalam MB sebelum auto-clean
LOG_FILE="/var/log/memreduct.log"
SLEEP_INTERVAL=10        # delay loop (detik)
# ============================

# Warna buat output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# Show header
function show_header() {
    echo -e "${CYAN}🚀 Mem Reduct CLI - Linux Edition${RESET}"
    echo "----------------------------------------"
}

# Show RAM usage
function show_usage() {
    local total used free
    read total used free <<< $(free -m | awk '/^Mem:/ { print $2, $3, $4 }')

    echo -e "${YELLOW}📊 RAM: Total=${total}MB | Used=${used}MB | Free=${free}MB${RESET}"
}

# Clean cache
function clean_ram() {
    echo -e "${RED}🧹 Cleaning RAM Cache...${RESET}"
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    echo -e "${GREEN}✅ Done cleaning.${RESET}"
    log_event "RAM cleaned manually or via auto"
}

# Logging
function log_event() {
    local msg="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" | sudo tee -a "$LOG_FILE" > /dev/null
}

# Persentase threshold
THRESHOLD_PERCENT=80

# Auto-cleaning loop
function auto_loop() {
    echo -e "${CYAN}🧠 Auto-clean mode aktif. Threshold: ${THRESHOLD_PERCENT}% Used RAM${RESET}"
    while true; do
        read total used <<< $(free -m | awk '/^Mem:/ {print $2, $3}')
        used_percent=$(( 100 * used / total ))

        if [ "$used_percent" -ge "$THRESHOLD_PERCENT" ]; then
            echo -e "${RED}⚠️  Memory Usage ${used_percent}% (used: ${used}MB). Triggering cleaning...${RESET}"
            clean_ram
        else
            echo -e "${GREEN}✅ Memory OK (${used_percent}% used)${RESET}"
        fi

        sleep $SLEEP_INTERVAL
    done
}


# Menu
function main_menu() {
    clear
    show_header
    show_usage
    echo ""
    echo -e "${CYAN}Pilih opsi:${RESET}"
    echo "1) Manual Clean"
    echo "2) Auto Clean (loop)"
    echo "3) Show Memory Only"
    echo "4) Exit"
    echo ""
    read -p "Pilihanmu: " choice

    case $choice in
        1) clean_ram ;;
        2) auto_loop ;;
        3) show_usage ;;
        4) exit 0 ;;
        *) echo "Pilihan gak valid";;
    esac
}

# Run
main_menu

