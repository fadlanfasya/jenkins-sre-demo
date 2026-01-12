#!/bin/bash

# Folder simulasi
APP_DIR="./live_app"
BACKUP_DIR="./backup_app"

case $1 in
  --deploy)
    echo "SRE: Memulai proses deployment..."
    # 1. Buat backup dari versi yang sedang jalan saat ini
    if [ -d "$APP_DIR" ]; then
        echo "SRE: Mencadangkan versi saat ini ke $BACKUP_DIR..."
        rm -rf "$BACKUP_DIR"
        cp -r "$APP_DIR" "$BACKUP_DIR"
    fi

    # 2. Update aplikasi ke versi baru
    mkdir -p "$APP_DIR"
    echo "Aplikasi Versi Baru (Build: $2)" > "$APP_DIR/version.txt"
    echo "Deployment Berhasil!"
    ;;

  --rollback)
    echo "SRE ALARM: Terdeteksi kegagalan! Melakukan Rollback..."
    if [ -d "$BACKUP_DIR" ]; then
        rm -rf "$APP_DIR"
        cp -r "$BACKUP_DIR" "$APP_DIR"
        echo "SRE: Rollback selesai. Versi stabil dipulihkan."
    else
        echo "SRE ERROR: Tidak ada folder backup ditemukan!"
        exit 1
    fi
    ;;

  *)
    echo "Gunakan parameter --deploy atau --rollback"
    ;;
esac