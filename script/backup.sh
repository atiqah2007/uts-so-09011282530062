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

# ===== Buat arsip .tar.gz, hanya berisi file hasil find =====
WAKTU=$(date +%Y%m%d_%H%M%S)
NAMA_ARSIP="backup_${NIM}_${WAKTU}.tar.gz"
tar -czvf "$TUJUAN/$NAMA_ARSIP" -C "$SUMBER" -T "$DAFTAR"

# ===== Verifikasi: tampilkan isi arsip tanpa mengekstrak =====
echo "--- Isi arsip $NAMA_ARSIP ---"
tar -tzvf "$TUJUAN/$NAMA_ARSIP"

# ===== Catat tepat satu baris ke log (>> menambah, tidak menimpa) =====
UKURAN=$(LC_ALL=C du -h "$TUJUAN/$NAMA_ARSIP" | cut -f1)
echo "$(date '+%Y-%m-%d %H:%M:%S') | $NAMA_ARSIP | $JUMLAH | $UKURAN" >> "$LOG"
# ===== Rotasi: simpan 5 arsip terbaru, hapus yang lebih lama =====
MAKS_ARSIP=5
ls -1t "$TUJUAN"/backup_"$NIM"_*.tar.gz | tail -n +$((MAKS_ARSIP + 1)) | xargs -r rm -f
