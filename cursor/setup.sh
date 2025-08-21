#!/bin/bash

# Dotfiles Setup Script for Cursor IDE
# สำหรับ Mac/Linux

set -e

echo "🚀 เริ่มการติดตั้ง Dotfiles สำหรับ Cursor IDE..."

# ตรวจสอบ OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
    echo "📱 ตรวจพบ macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CURSOR_CONFIG_DIR="$HOME/.config/Cursor/User"
    echo "🐧 ตรวจพบ Linux"
else
    echo "❌ ไม่รองรับ OS นี้"
    exit 1
fi

# สร้าง directory ถ้ายังไม่มี
mkdir -p "$CURSOR_CONFIG_DIR"

# สร้าง symbolic links
echo "🔗 สร้าง symbolic links..."

# Backup ไฟล์เดิม (ถ้ามี)
if [ -f "$CURSOR_CONFIG_DIR/settings.json" ]; then
    cp "$CURSOR_CONFIG_DIR/settings.json" "$CURSOR_CONFIG_DIR/settings.json.backup"
    echo "📋 สำรองไฟล์ settings.json เรียบร้อย"
fi

if [ -f "$CURSOR_CONFIG_DIR/keybindings.json" ]; then
    cp "$CURSOR_CONFIG_DIR/keybindings.json" "$CURSOR_CONFIG_DIR/keybindings.json.backup"
    echo "📋 สำรองไฟล์ keybindings.json เรียบร้อย"
fi

# สร้าง symbolic links
ln -sf "$(pwd)/cursor/User/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
ln -sf "$(pwd)/cursor/User/keybindings.json" "$CURSOR_CONFIG_DIR/keybindings.json"

# สร้าง symbolic link สำหรับ snippets directory
if [ -d "$(pwd)/cursor/User/snippets" ]; then
    ln -sf "$(pwd)/cursor/User/snippets" "$CURSOR_CONFIG_DIR/snippets"
fi

echo "✅ สร้าง symbolic links เรียบร้อย"

# ติดตั้ง extensions
echo "📦 ติดตั้ง extensions..."
if command -v code &> /dev/null; then
    while IFS= read -r extension; do
        if [ ! -z "$extension" ]; then
            echo "ติดตั้ง: $extension"
            code --install-extension "$extension" || echo "⚠️  ไม่สามารถติดตั้ง $extension ได้"
        fi
    done < cursor/extensions.txt
    echo "✅ ติดตั้ง extensions เรียบร้อย"
else
    echo "⚠️  ไม่พบ Cursor CLI (code command)"
    echo "กรุณาติดตั้ง extensions เองจากไฟล์ cursor/extensions.txt"
fi

echo ""
echo "🎉 การติดตั้งเสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - ไฟล์เดิมถูกสำรองไว้ใน $CURSOR_CONFIG_DIR/*.backup"
echo "   - รีสตาร์ท Cursor เพื่อให้การตั้งค่าใหม่มีผล"
echo "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup"
