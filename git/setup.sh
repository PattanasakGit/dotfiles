#!/bin/bash

# Git Dotfiles Setup Script
# สำหรับ Mac/Linux

set -e

echo "🔧 เริ่มการติดตั้ง Git Configuration..."

# ตรวจสอบว่ามี Git หรือไม่
if ! command -v git &> /dev/null; then
    echo "❌ ไม่พบ Git กรุณาติดตั้งก่อน:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   brew install git"
    else
        echo "   sudo apt-get install git"
    fi
    exit 1
fi

# Backup ไฟล์เดิม
echo "📋 สำรองไฟล์เดิม..."
if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง .gitconfig เรียบร้อย"
fi

if [ -f "$HOME/.gitignore_global" ] && [ ! -L "$HOME/.gitignore_global" ]; then
    cp "$HOME/.gitignore_global" "$HOME/.gitignore_global.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง .gitignore_global เรียบร้อย"
fi

# ลบไฟล์เดิม (ถ้าเป็น regular file)
[ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ] && rm "$HOME/.gitconfig"
[ -f "$HOME/.gitignore_global" ] && [ ! -L "$HOME/.gitignore_global" ] && rm "$HOME/.gitignore_global"

# สร้าง symbolic links
echo "🔗 สร้าง symbolic links..."
ln -sf "$(pwd)/.gitconfig" "$HOME/.gitconfig"

# สร้าง global gitignore ถ้ามี
if [ -f "$(pwd)/.gitignore_global" ]; then
    ln -sf "$(pwd)/.gitignore_global" "$HOME/.gitignore_global"
    # ตั้งค่า global gitignore
    git config --global core.excludesfile ~/.gitignore_global
fi

echo "✅ สร้าง symbolic links เรียบร้อย"

# ตรวจสอบการตั้งค่า Git user
echo "🔍 ตรวจสอบการตั้งค่า Git user..."
GIT_USER_NAME=$(git config --global user.name 2>/dev/null || echo "")
GIT_USER_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ]; then
    echo "⚠️  ยังไม่ได้ตั้งค่า Git user information"
    echo "กรุณารันคำสั่งต่อไปนี้:"
    echo ""
    echo "git config --global user.name \"Your Name\""
    echo "git config --global user.email \"your.email@example.com\""
    echo ""
else
    echo "✅ Git user information:"
    echo "   Name: $GIT_USER_NAME"
    echo "   Email: $GIT_USER_EMAIL"
fi

# ตรวจสอบ SSH keys
echo "🔐 ตรวจสอบ SSH keys..."
if [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]; then
    echo "✅ พบ SSH keys แล้ว"
    
    # ตรวจสอบ ssh-agent
    if ! ssh-add -l &>/dev/null; then
        echo "🔄 เริ่ม ssh-agent..."
        eval "$(ssh-agent -s)"
        
        # เพิ่ม SSH keys
        if [ -f "$HOME/.ssh/id_ed25519" ]; then
            ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || echo "   ไม่สามารถเพิ่ม id_ed25519"
        fi
        if [ -f "$HOME/.ssh/id_rsa" ]; then
            ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null || echo "   ไม่สามารถเพิ่ม id_rsa"
        fi
    else
        echo "✅ ssh-agent ทำงานอยู่แล้ว"
    fi
    
    # ทดสอบการเชื่อมต่อ
    echo "🔍 ทดสอบการเชื่อมต่อ SSH..."
    if ssh -T git@github.com -o ConnectTimeout=5 2>&1 | grep -q "successfully authenticated"; then
        echo "✅ GitHub SSH ทำงานปกติ"
    else
        echo "⚠️  GitHub SSH ไม่ทำงาน"
    fi
    
    if ssh -T git@gitlab.com -o ConnectTimeout=5 2>&1 | grep -q "Welcome to GitLab"; then
        echo "✅ GitLab SSH ทำงานปกติ"
    else
        echo "⚠️  GitLab SSH ไม่ทำงาน"
    fi
else
    echo "⚠️  ไม่พบ SSH keys"
    echo "กรุณาสร้าง SSH key:"
    echo ""
    echo "ssh-keygen -t ed25519 -C \"your.email@example.com\""
    echo "ssh-add ~/.ssh/id_ed25519"
    echo "cat ~/.ssh/id_ed25519.pub"
    echo ""
    echo "แล้วนำ public key ไปเพิ่มใน GitHub/GitLab Settings"
fi

# แสดงการตั้งค่า Git ที่สำคัญ
echo ""
echo "📋 การตั้งค่า Git ปัจจุบัน:"
echo "User Name: $(git config --global user.name || echo 'Not set')"
echo "User Email: $(git config --global user.email || echo 'Not set')"
echo "Default Editor: $(git config --global core.editor || echo 'Default')"
echo "Global Gitignore: $(git config --global core.excludesfile || echo 'Not set')"

echo ""
echo "🎉 การติดตั้ง Git Configuration เสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - ไฟล์เดิมถูกสำรองไว้ใน ~/.*.backup.*"
echo "   - ตรวจสอบการตั้งค่าด้วย: git config --list"
echo "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup"
echo ""
echo "🚀 คำสั่งที่แนะนำ:"
echo "   git config --list     # ดูการตั้งค่าทั้งหมด"
echo "   ssh -T git@github.com # ทดสอบ GitHub SSH"
echo "   ssh -T git@gitlab.com # ทดสอบ GitLab SSH"
