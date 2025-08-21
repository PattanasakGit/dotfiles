#!/bin/bash

# Zed IDE Dotfiles Setup Script
# สำหรับ Mac/Linux

set -e

echo "⚡ เริ่มการติดตั้ง Zed IDE Configuration..."

# ตรวจสอบ OS และกำหนด path
if [[ "$OSTYPE" == "darwin"* ]]; then
    ZED_CONFIG_DIR="$HOME/.config/zed"
    echo "📱 ตรวจพบ macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ZED_CONFIG_DIR="$HOME/.config/zed"
    echo "🐧 ตรวจพบ Linux"
else
    echo "❌ ไม่รองรับ OS นี้"
    exit 1
fi

# ตรวจสอบว่ามี Zed หรือไม่
if ! command -v zed &> /dev/null; then
    echo "⚠️  ไม่พบ Zed IDE"
    echo "กรุณาติดตั้ง Zed IDE ก่อน:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   brew install --cask zed"
        echo "   หรือดาวน์โหลดจาก: https://zed.dev"
    else
        echo "   ดาวน์โหลดจาก: https://zed.dev"
        echo "   หรือติดตั้งผ่าน package manager ของระบบ"
    fi
    echo ""
    echo "หลังจากติดตั้งแล้ว รันคำสั่งนี้อีกครั้ง"
    # ไม่ exit เพื่อให้สามารถสร้าง symbolic links ได้
fi

# สร้าง directory ถ้ายังไม่มี
mkdir -p "$ZED_CONFIG_DIR"

# Backup ไฟล์เดิม
echo "📋 สำรองไฟล์เดิม..."
if [ -f "$ZED_CONFIG_DIR/settings.json" ] && [ ! -L "$ZED_CONFIG_DIR/settings.json" ]; then
    cp "$ZED_CONFIG_DIR/settings.json" "$ZED_CONFIG_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง settings.json เรียบร้อย"
fi

if [ -f "$ZED_CONFIG_DIR/keymap.json" ] && [ ! -L "$ZED_CONFIG_DIR/keymap.json" ]; then
    cp "$ZED_CONFIG_DIR/keymap.json" "$ZED_CONFIG_DIR/keymap.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง keymap.json เรียบร้อย"
fi

if [ -d "$ZED_CONFIG_DIR/themes" ] && [ ! -L "$ZED_CONFIG_DIR/themes" ]; then
    cp -r "$ZED_CONFIG_DIR/themes" "$ZED_CONFIG_DIR/themes.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง themes/ เรียบร้อย"
fi

# ลบไฟล์เดิม
[ -f "$ZED_CONFIG_DIR/settings.json" ] && [ ! -L "$ZED_CONFIG_DIR/settings.json" ] && rm "$ZED_CONFIG_DIR/settings.json"
[ -f "$ZED_CONFIG_DIR/keymap.json" ] && [ ! -L "$ZED_CONFIG_DIR/keymap.json" ] && rm "$ZED_CONFIG_DIR/keymap.json"
[ -d "$ZED_CONFIG_DIR/themes" ] && [ ! -L "$ZED_CONFIG_DIR/themes" ] && rm -rf "$ZED_CONFIG_DIR/themes"

# สร้าง symbolic links
echo "🔗 สร้าง symbolic links..."

# settings.json (บังคับ)
ln -sf "$(pwd)/settings.json" "$ZED_CONFIG_DIR/settings.json"
echo "   สร้าง symbolic link สำหรับ settings.json"

# keymap.json (ถ้ามี)
if [ -f "$(pwd)/keymap.json" ]; then
    ln -sf "$(pwd)/keymap.json" "$ZED_CONFIG_DIR/keymap.json"
    echo "   สร้าง symbolic link สำหรับ keymap.json"
fi

# themes/ directory (ถ้ามี)
if [ -d "$(pwd)/themes" ]; then
    ln -sf "$(pwd)/themes" "$ZED_CONFIG_DIR/themes"
    echo "   สร้าง symbolic link สำหรับ themes/"
fi

echo "✅ สร้าง symbolic links เรียบร้อย"

# ตรวจสอบการติดตั้ง
echo "🔍 ตรวจสอบการติดตั้ง..."
if [ -L "$ZED_CONFIG_DIR/settings.json" ]; then
    echo "✅ settings.json symbolic link"
else
    echo "❌ settings.json ไม่ได้เป็น symbolic link"
fi

if [ -f "$(pwd)/keymap.json" ]; then
    if [ -L "$ZED_CONFIG_DIR/keymap.json" ]; then
        echo "✅ keymap.json symbolic link"
    else
        echo "❌ keymap.json ไม่ได้เป็น symbolic link"
    fi
fi

if [ -d "$(pwd)/themes" ]; then
    if [ -L "$ZED_CONFIG_DIR/themes" ]; then
        echo "✅ themes/ symbolic link"
    else
        echo "❌ themes/ ไม่ได้เป็น symbolic link"
    fi
fi

# ตรวจสอบ JSON syntax
echo "🔍 ตรวจสอบ JSON syntax..."
if command -v python3 &> /dev/null; then
    if python3 -m json.tool "$ZED_CONFIG_DIR/settings.json" > /dev/null 2>&1; then
        echo "✅ settings.json syntax ถูกต้อง"
    else
        echo "❌ settings.json syntax ผิด"
    fi
elif command -v jq &> /dev/null; then
    if jq empty "$ZED_CONFIG_DIR/settings.json" > /dev/null 2>&1; then
        echo "✅ settings.json syntax ถูกต้อง"
    else
        echo "❌ settings.json syntax ผิด"
    fi
else
    echo "⚠️  ไม่สามารถตรวจสอบ JSON syntax ได้ (ต้องการ python3 หรือ jq)"
fi

# แสดงข้อมูลการติดตั้ง Zed
if command -v zed &> /dev/null; then
    echo ""
    echo "📋 ข้อมูล Zed IDE:"
    ZED_VERSION=$(zed --version 2>/dev/null || echo "Unknown")
    echo "Version: $ZED_VERSION"
    echo "Config Directory: $ZED_CONFIG_DIR"
else
    echo ""
    echo "⚠️  Zed IDE ยังไม่ได้ติดตั้ง"
fi

echo ""
echo "🎉 การติดตั้ง Zed IDE Configuration เสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - ไฟล์เดิมถูกสำรองไว้ใน $ZED_CONFIG_DIR/*.backup.*"
echo "   - รีสตาร์ท Zed เพื่อให้การตั้งค่าใหม่มีผล"
echo "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup"
echo ""
echo "🚀 คำสั่งที่แนะนำ:"
echo "   zed .                     # เปิด Zed ใน directory ปัจจุบัน"
echo "   zed --version             # ตรวจสอบเวอร์ชัน"

# เคล็ดลับสำหรับผู้ใช้ใหม่
echo ""
echo "💡 เคล็ดลับสำหรับผู้ใช้ใหม่:"
echo "   - Cmd/Ctrl + Shift + P: เปิด Command Palette"
echo "   - Cmd/Ctrl + P: Quick open file"
echo "   - Cmd/Ctrl + D: Select next occurrence"
echo "   - ดู keybindings เพิ่มเติมใน README.md"
