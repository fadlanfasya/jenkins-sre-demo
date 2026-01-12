echo "Aplikasi SRE sedang berjalan..."
echo "Mengecek status sistem..."
df -h | grep '^/' # Cek sisa disk
echo "Selesai!"