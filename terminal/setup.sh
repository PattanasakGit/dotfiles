#!/bin/bash

# Terminal Dotfiles Setup Script
# สำหรับ macOS

set -e

echo "💻 เริ่มการติดตั้ง Terminal Configuration..."

# ตรวจสอบ OS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Script นี้รองรับเฉพาะ macOS เท่านั้น"
    exit 1
fi

echo "📱 ตรวจพบ macOS"

# Functions
install_fonts() {
    echo "🔤 ติดตั้ง fonts ที่แนะนำ..."
    
    # ตรวจสอบ Homebrew
    if ! command -v brew &> /dev/null; then
        echo "⚠️  ไม่พบ Homebrew กรุณาติดตั้งก่อน:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    # เพิ่ม font tap
    brew tap homebrew/cask-fonts 2>/dev/null || true
    
    # ติดตั้ง fonts ที่แนะนำ
    fonts=(
        "font-jetbrains-mono"
        "font-fira-code"
        "font-sf-mono"
        "font-hack"
        "font-source-code-pro"
    )
    
    for font in "${fonts[@]}"; do
        if brew list --cask | grep -q "^$font\$"; then
            echo "✅ $font ติดตั้งแล้ว"
        else
            echo "📦 ติดตั้ง $font..."
            brew install --cask "$font" || echo "⚠️  ไม่สามารถติดตั้ง $font ได้"
        fi
    done
}

install_terminal_themes() {
    echo "🎨 ติดตั้ง Terminal themes..."
    
    if [ -d "themes" ]; then
        for theme_file in themes/*.terminal; do
            if [ -f "$theme_file" ]; then
                echo "📂 Import theme: $(basename "$theme_file")"
                open "$theme_file"
                sleep 1  # รอให้ Terminal.app process
            fi
        done
        echo "✅ Import Terminal themes เรียบร้อย"
        echo "   ไปที่ Terminal > Preferences > Profiles เพื่อเลือก theme"
    else
        echo "⚠️  ไม่พบโฟลเดอร์ themes/"
    fi
}

install_iterm2() {
    echo "🔧 ตรวจสอบ iTerm2..."
    
    if [ -d "/Applications/iTerm.app" ]; then
        echo "✅ iTerm2 ติดตั้งแล้ว"
        
        # Import iTerm2 profile ถ้ามี
        if [ -f "iterm2_profile.json" ]; then
            echo "📂 พบ iTerm2 profile"
            echo "   กรุณา import manual:"
            echo "   1. เปิด iTerm2"
            echo "   2. ไปที่ iTerm2 > Preferences > Profiles"
            echo "   3. คลิก 'Other Actions...' > 'Import JSON Profiles...'"
            echo "   4. เลือกไฟล์: $(pwd)/iterm2_profile.json"
        fi
    else
        echo "⚠️  ไม่พบ iTerm2"
        read -p "ต้องการติดตั้ง iTerm2 หรือไม่? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if command -v brew &> /dev/null; then
                echo "📦 ติดตั้ง iTerm2..."
                brew install --cask iterm2
                echo "✅ ติดตั้ง iTerm2 เรียบร้อย"
            else
                echo "❌ ต้องการ Homebrew เพื่อติดตั้ง iTerm2"
                echo "   หรือดาวน์โหลดจาก: https://iterm2.com"
            fi
        fi
    fi
}

setup_terminal_preferences() {
    echo "⚙️  ตั้งค่า Terminal preferences..."
    
    # ตั้งค่า Terminal.app ผ่าน defaults
    defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
    
    # เปิดใช้งาน Option key เป็น Meta key
    defaults write com.apple.Terminal SecureKeyboardEntry -bool false
    
    echo "✅ ตั้งค่า Terminal preferences เรียบร้อย"
}

show_manual_steps() {
    echo ""
    echo "📋 ขั้นตอนที่ต้องทำ manual:"
    echo ""
    
    if [ -d "themes" ]; then
        echo "🎨 Terminal.app Themes:"
        echo "   - themes ถูก import แล้ว"
        echo "   - ไปที่ Terminal > Preferences > Profiles"
        echo "   - เลือก theme ที่ต้องการ"
        echo "   - คลิก 'Default' เพื่อตั้งเป็น default"
        echo ""
    fi
    
    if [ -f "iterm2_profile.json" ]; then
        echo "🔧 iTerm2 Profile:"
        echo "   - เปิด iTerm2"
        echo "   - ไปที่ iTerm2 > Preferences > Profiles"
        echo "   - คลิก 'Other Actions...' > 'Import JSON Profiles...'"
        echo "   - เลือกไฟล์: $(pwd)/iterm2_profile.json"
        echo ""
    fi
    
    echo "🔤 Font Recommendations:"
    echo "   - JetBrains Mono (แนะนำ)"
    echo "   - Fira Code (มี ligatures)"
    echo "   - SF Mono (Apple's font)"
    echo "   - ตั้งค่าใน Terminal/iTerm2 > Preferences > Profiles > Text"
    echo ""
    
    echo "⚙️  การตั้งค่าเพิ่มเติม:"
    echo "   - Font size: 13-14pt"
    echo "   - Background opacity: 85-95%"
    echo "   - Scrollback: Unlimited หรือ 10,000 lines"
    echo "   - Close if shell exited cleanly: เปิดใช้งาน"
}

# Main execution
echo "🚀 เริ่มการติดตั้ง..."

# ติดตั้ง fonts
install_fonts

# ติดตั้ง Terminal themes
install_terminal_themes

# ตรวจสอบและติดตั้ง iTerm2
install_iterm2

# ตั้งค่า Terminal preferences
setup_terminal_preferences

# แสดงขั้นตอน manual
show_manual_steps

echo ""
echo "🎉 การติดตั้ง Terminal Configuration เสร็จสิ้น!"
echo "📝 หมายเหตุ:"
echo "   - รีสตาร์ท Terminal applications เพื่อให้การตั้งค่าใหม่มีผล"
echo "   - อ่าน README.md สำหรับรายละเอียดเพิ่มเติม"
echo "   - ทดสอบ colors ด้วยคำสั่ง: curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash"
echo ""
echo "🚀 คำสั่งที่แนะนำ:"
echo "   curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash"
echo "   echo \$TERM                # ตรวจสอบ terminal type"
