#!/bin/bash
# Nama: Nur Atiqah | NIM: 09011282530062 | Kelas: SKU3B

# ===== Variabel (ubah di sini kalau lokasi berubah) =====
NIM="09011282530062"
SUMBER="$HOME/data_$NIM"
TUJUAN="$HOME/backup_$NIM"
LOG="$TUJUAN/backup.log"
DAFTAR="$TUJUAN/daftar_file.txt"

# ===== Buat direktori tujuan jika belum ada =====
mkdir -p "$TUJUAN"

# ===== Cari semua file .txt (termasuk subdirektori), simpan daftarnya =====
(cd "$SUMBER" && find . -type f -name "*.txt") > "$DAFTAR"
JUMLAH=$(wc -l < "$DAFTAR")
echo "Ditemukan $JUMLAH file .txt:"
cat "$DAFTAR"
