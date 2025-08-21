#!/bin/bash

# VS Code Dotfiles Setup Script
# สำหรับ Mac/Linux

set -e

echo "🆚 เริ่มการติดตั้ง VS Code Configuration..."

# ตรวจสอบ OS และกำหนด path
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    echo "📱 ตรวจพบ macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_USER_DIR="$HOME/.config/Code/User"
    echo "🐧 ตรวจพบ Linux"
else
    echo "❌ ไม่รองรับ OS นี้"
    exit 1
fi

# ตรวจสอบว่ามี VS Code หรือไม่
if ! command -v code &> /dev/null; then
    echo "⚠️  ไม่พบ VS Code CLI"
    echo "กรุณาติดตั้ง VS Code และเปิดใช้งาน CLI:"
    echo "1. เปิด VS Code"
    echo "2. Command Palette (Cmd/Ctrl + Shift + P)"
    echo "3. ค้นหา 'Shell Command: Install code command in PATH'"
    echo "4. รันคำสั่งนี้อีกครั้ง"
    echo ""
    echo "หรือติดตั้ง VS Code:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   brew install --cask visual-studio-code"
    else
        echo "   sudo snap install code --classic"
    fi
    # ไม่ exit เพื่อให้สามารถสร้าง symbolic links ได้
fi

# สร้าง directory ถ้ายังไม่มี
mkdir -p "$VSCODE_USER_DIR"

# Backup ไฟล์เดิม
echo "📋 สำรองไฟล์เดิม..."
if [ -f "$VSCODE_USER_DIR/settings.json" ] && [ ! -L "$VSCODE_USER_DIR/settings.json" ]; then
    cp "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง settings.json เรียบร้อย"
fi

if [ -f "$VSCODE_USER_DIR/keybindings.json" ] && [ ! -L "$VSCODE_USER_DIR/keybindings.json" ]; then
    cp "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง keybindings.json เรียบร้อย"
fi

if [ -d "$VSCODE_USER_DIR/snippets" ] && [ ! -L "$VSCODE_USER_DIR/snippets" ]; then
    cp -r "$VSCODE_USER_DIR/snippets" "$VSCODE_USER_DIR/snippets.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง snippets/ เรียบร้อย"
fi

# ลบไฟล์เดิม
[ -f "$VSCODE_USER_DIR/settings.json" ] && [ ! -L "$VSCODE_USER_DIR/settings.json" ] && rm "$VSCODE_USER_DIR/settings.json"
[ -f "$VSCODE_USER_DIR/keybindings.json" ] && [ ! -L "$VSCODE_USER_DIR/keybindings.json" ] && rm "$VSCODE_USER_DIR/keybindings.json"
[ -d "$VSCODE_USER_DIR/snippets" ] && [ ! -L "$VSCODE_USER_DIR/snippets" ] && rm -rf "$VSCODE_USER_DIR/snippets"

# สร้าง symbolic links
echo "🔗 สร้าง symbolic links..."
ln -sf "$(pwd)/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -sf "$(pwd)/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

# สร้าง symbolic link สำหรับ snippets ถ้ามี
if [ -d "$(pwd)/snippets" ]; then
    ln -sf "$(pwd)/snippets" "$VSCODE_USER_DIR/snippets"
fi

echo "✅ สร้าง symbolic links เรียบร้อย"

# อัปเดตรายการ extensions
if command -v code &> /dev/null; then
    echo "📦 อัปเดตรายการ extensions..."
    code --list-extensions > extensions.txt
    echo "✅ อัปเดตรายการ extensions เรียบร้อย"
    
    # ติดตั้ง extensions
    echo "📦 ติดตั้ง extensions..."
    while IFS= read -r extension; do
        if [ ! -z "$extension" ] && [[ ! "$extension" =~ ^# ]]; then
            echo "ติดตั้ง: $extension"
            code --install-extension "$extension" || echo "⚠️  ไม่สามารถติดตั้ง $extension ได้"
        fi
    done < extensions.txt
    echo "✅ ติดตั้ง extensions เรียบร้อย"
else
    echo "⚠️  ไม่สามารถอัปเดตหรือติดตั้ง extensions ได้"
    echo "กรุณาติดตั้ง extensions เองผ่าน Extensions Marketplace"
fi

# ตรวจสอบการติดตั้ง
echo "🔍 ตรวจสอบการติดตั้ง..."
if [ -L "$VSCODE_USER_DIR/settings.json" ]; then
    echo "✅ settings.json symbolic link"
else
    echo "❌ settings.json ไม่ได้เป็น symbolic link"
fi

if [ -L "$VSCODE_USER_DIR/keybindings.json" ]; then
    echo "✅ keybindings.json symbolic link"
else
    echo "❌ keybindings.json ไม่ได้เป็น symbolic link"
fi

if [ -L "$VSCODE_USER_DIR/snippets" ]; then
    echo "✅ snippets/ symbolic link"
else
    echo "⚠️  snippets/ ไม่ได้เป็น symbolic link"
fi

echo ""
echo "🎉 การติดตั้ง VS Code Configuration เสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - ไฟล์เดิมถูกสำรองไว้ใน $VSCODE_USER_DIR/*.backup.*"
echo "   - รีสตาร์ท VS Code เพื่อให้การตั้งค่าใหม่มีผล"
echo "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup"
echo ""
echo "🚀 คำสั่งที่แนะนำ:"
echo "   code .                    # เปิด VS Code ใน directory ปัจจุบัน"
echo "   code --list-extensions    # ดูรายการ extensions ที่ติดตั้ง"
