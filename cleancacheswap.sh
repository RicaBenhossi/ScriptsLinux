# !/bin/bash
echo “Cleanning Cache and Swap…”

echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3
swapoff -a && swapon -a
echo “Cache and Swap cleanning complete”
