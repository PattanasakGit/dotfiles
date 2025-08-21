#!/bin/bash

# Zsh Dotfiles Setup Script
# สำหรับ Mac/Linux

set -e

echo "🐚 เริ่มการติดตั้ง Zsh Configuration..."

# ตรวจสอบ OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "📱 ตรวจพบ macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 ตรวจพบ Linux"
else
    echo "❌ ไม่รองรับ OS นี้"
    exit 1
fi

# ตรวจสอบว่ามี Zsh หรือไม่
if ! command -v zsh &> /dev/null; then
    echo "❌ ไม่พบ Zsh กรุณาติดตั้งก่อน:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   brew install zsh"
    else
        echo "   sudo apt-get install zsh"
    fi
    exit 1
fi

# ติดตั้ง Oh My Zsh ถ้ายังไม่มี
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 ติดตั้ง Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh ติดตั้งแล้ว"
fi

# ติดตั้ง Powerlevel10k theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo "🎨 ติดตั้ง Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "✅ Powerlevel10k theme ติดตั้งแล้ว"
fi

# ติดตั้ง zsh-autosuggestions plugin
AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGESTIONS_DIR" ]; then
    echo "💡 ติดตั้ง zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
else
    echo "✅ zsh-autosuggestions plugin ติดตั้งแล้ว"
fi

# ติดตั้ง zsh-syntax-highlighting plugin
HIGHLIGHTING_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$HIGHLIGHTING_DIR" ]; then
    echo "🌈 ติดตั้ง zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHTING_DIR"
else
    echo "✅ zsh-syntax-highlighting plugin ติดตั้งแล้ว"
fi

# Backup ไฟล์เดิม
echo "📋 สำรองไฟล์เดิม..."
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง .zshrc เรียบร้อย"
fi

if [ -f "$HOME/.p10k.zsh" ] && [ ! -L "$HOME/.p10k.zsh" ]; then
    cp "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง .p10k.zsh เรียบร้อย"
fi

if [ -f "$HOME/.zprofile" ] && [ ! -L "$HOME/.zprofile" ]; then
    cp "$HOME/.zprofile" "$HOME/.zprofile.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   สำรอง .zprofile เรียบร้อย"
fi

# ลบไฟล์เดิม (ถ้าเป็น regular file)
[ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && [ ! -L "$HOME/.p10k.zsh" ] && rm "$HOME/.p10k.zsh"
[ -f "$HOME/.zprofile" ] && [ ! -L "$HOME/.zprofile" ] && rm "$HOME/.zprofile"

# สร้าง symbolic links
echo "🔗 สร้าง symbolic links..."
ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -sf "$(pwd)/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$(pwd)/.zprofile" "$HOME/.zprofile"

echo "✅ สร้าง symbolic links เรียบร้อย"

# เปลี่ยน default shell เป็น zsh (ถ้ายังไม่ใช่)
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/local/bin/zsh" ]; then
    echo "🔄 เปลี่ยน default shell เป็น zsh..."
    ZSH_PATH=$(which zsh)
    
    # เพิ่ม zsh ใน /etc/shells ถ้ายังไม่มี
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "   เพิ่ม $ZSH_PATH ใน /etc/shells..."
        echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    
    # เปลี่ยน shell
    chsh -s "$ZSH_PATH"
    echo "   เปลี่ยน default shell เป็น zsh เรียบร้อย"
else
    echo "✅ Default shell เป็น zsh อยู่แล้ว"
fi

echo ""
echo "🎉 การติดตั้ง Zsh Configuration เสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - ไฟล์เดิมถูกสำรองไว้ใน ~/.*.backup.*"
echo "   - รีสตาร์ท terminal หรือรัน 'exec zsh' เพื่อให้การตั้งค่าใหม่มีผล"
echo "   - รัน 'p10k configure' เพื่อปรับแต่ง Powerlevel10k theme"
echo "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup"
echo ""
echo "🚀 คำสั่งที่แนะนำ:"
echo "   exec zsh          # รีโหลด shell"
echo "   p10k configure    # ปรับแต่ง theme"
