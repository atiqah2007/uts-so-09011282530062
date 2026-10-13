#!/bin/bash
# Nama: Nur Atiqah | NIM: 09011282530062 | Kelas: SKU3B
# ===== Jeda antar backup dalam detik (bawaan 60, bisa diubah: ./backup_loop.sh 10) =====
INTERVAL="${1:-60}"
FOLDER="$(cd "$(dirname "$0")" && pwd)"

# ===== Ulangi backup terus-menerus sampai dihentikan dengan kill =====
while true; do
"$FOLDER/backup.sh"
sleep "$INTERVAL"
done
