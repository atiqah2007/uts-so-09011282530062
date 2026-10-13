# UTS Sistem Operasi - Backup Otomatis

## Identitas
- Nama: Nur Atiqah
- NIM: 09011282530062
- Kelas: SKU3B

## Deskripsi
`script/backup.sh` mencari semua file `.txt` (termasuk subdirektori) di `~/data_09011282530062` dengan `find`, mengarsipkannya dengan `tar -czvf` menjadi `backup_NIM_TANGGAL_JAM.tar.gz` di `~/backup_09011282530062`, menampilkan isi arsip dengan `tar -tzvf`, lalu menambahkan satu baris ke `backup.log` (tanggal jam | nama arsip | jumlah file | ukuran).

`script/backup_loop.sh` menjalankan `backup.sh` berulang dengan `while true` dan `sleep $INTERVAL` (bawaan 60 detik).

`script/alias.sh` berisi alias `bk062` yang menjalankan `backup.sh`; baris yang sama ada di `~/.bashrc`.


## Cara menjalankan
```bash
cd ~/uts-so-09011282530062/script
./backup.sh                  # satu kali backup
./backup_loop.sh &           # berulang tiap 60 detik di background
./backup_loop.sh 5 &         # berulang tiap 5 detik
kill %1                      # hentikan job background
source alias.sh              # aktifkan alias di terminal ini
bk062                        # jalankan backup lewat alias
```

## Fitur pengembangan
Rotasi arsip: hanya 5 arsip terbaru yang disimpan, yang lebih lama dihapus otomatis.


Cara mencoba:
```bash
for i in 1 2 3 4 5 6 7; do ./backup.sh > /dev/null; sleep 1; done
ls ~/backup_09011282530062
```
Hasilnya hanya ada 5 file `.tar.gz`.

## Bukti job control
```
 ./backup_loop.sh 5 > /dev/null &
[1] 2226
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ jobs -l
[1]+  2226 Berjalan                ./backup_loop.sh 5 > /dev/null &
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ fg
./backup_loop.sh 5 > /dev/null
^Z
[1]+  Terhenti                ./backup_loop.sh 5 > /dev/null
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ bg
[1]+ ./backup_loop.sh 5 > /dev/null &
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ ps x | grep backup_loop
   2226 pts/0    S      0:00 /bin/bash ./backup_loop.sh 5
   2391 pts/0    S+     0:00 grep --color=auto backup_loop
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ kill %1
atiqah@atiqah-VirtualBox:~/uts-so-09011282530062/script$ jobs -l
[1]+  2226 Terakhiri               ./backup_loop.sh 5 > /dev/null

```

## Kendala
- `git clone` gagal "Not Found": alamat repositori tidak memuat username GitHub. Diatasi dengan memakai `https://github.com/USERNAME/uts-so-NIM.git`.
- `ECHO: perintah tidak ditemukan`: `echo` terketik huruf besar. Diatasi dengan menggantinya ke huruf kecil.
- `EOF: perintah tidak ditemukan` di akhir script: kata penutup heredoc ikut tertulis di dalam file. Diatasi dengan menghapus baris tersebut.
- Ukuran arsip di log tertulis `4,0K` (koma) karena locale Indonesia. Diatasi dengan `LC_ALL=C du -h` agar menjadi `4.0K`.
