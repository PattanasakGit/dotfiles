#!/bin/bash

# Complete Dotfiles Setup Script
# ติดตั้ง dotfiles ทั้งหมดสำหรับ Mac

set -e

echo "🚀 เริ่มการติดตั้ง Dotfiles ทั้งหมด..."

# ตรวจสอบ OS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Script นี้รองรับเฉพาะ macOS เท่านั้น"
    exit 1
fi

echo "📱 ตรวจพบ macOS"

# Function เพื่อขอความยินยอมจากผู้ใช้
ask_user() {
    local prompt="$1"
    local default="${2:-n}"
    
    if [ "$default" = "y" ]; then
        read -p "$prompt (Y/n): " -n 1 -r
        echo
        [[ $REPLY =~ ^[Nn]$ ]] && return 1 || return 0
    else
        read -p "$prompt (y/N): " -n 1 -r
        echo
        [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
    fi
}

# รายการโปรแกรมที่สามารถติดตั้งได้
programs=(
    "git:Git Configuration"
    "zsh:Zsh Shell + Oh My Zsh"
    "cursor:Cursor IDE"
    "vscode:VS Code"
    "zed:Zed IDE"
    "terminal:Terminal Configuration"
)

echo ""
echo "📋 โปรแกรมที่สามารถติดตั้งได้:"
for program in "${programs[@]}"; do
    IFS=':' read -r key desc <<< "$program"
    echo "   - $desc ($key/)"
done

echo ""
echo "🔧 เลือกโปรแกรมที่ต้องการติดตั้ง:"
echo "   a) ติดตั้งทั้งหมด"
echo "   s) เลือกเอง"
echo "   q) ออกจากโปรแกรม"

read -p "เลือก (a/s/q): " -n 1 -r choice
echo

case $choice in
    [Aa])
        selected_programs=()
        for program in "${programs[@]}"; do
            IFS=':' read -r key desc <<< "$program"
            selected_programs+=("$key")
        done
        ;;
    [Ss])
        selected_programs=()
        for program in "${programs[@]}"; do
            IFS=':' read -r key desc <<< "$program"
            if ask_user "ติดตั้ง $desc หรือไม่?"; then
                selected_programs+=("$key")
            fi
        done
        ;;
    [Qq])
        echo "👋 ออกจากโปรแกรม"
        exit 0
        ;;
    *)
        echo "❌ ตัวเลือกไม่ถูกต้อง"
        exit 1
        ;;
esac

# ตรวจสอบว่าเลือกโปรแกรมอย่างน้อย 1 ตัว
if [ ${#selected_programs[@]} -eq 0 ]; then
    echo "❌ ไม่ได้เลือกโปรแกรมใดเลย"
    exit 1
fi

echo ""
echo "📦 จะติดตั้งโปรแกรมต่อไปนี้:"
for prog in "${selected_programs[@]}"; do
    for program in "${programs[@]}"; do
        IFS=':' read -r key desc <<< "$program"
        if [ "$key" = "$prog" ]; then
            echo "   - $desc"
            break
        fi
    done
done

echo ""
if ! ask_user "ดำเนินการต่อหรือไม่?" "y"; then
    echo "👋 ยกเลิกการติดตั้ง"
    exit 0
fi

# ติดตั้งโปรแกรมที่เลือก
echo ""
echo "🚀 เริ่มการติดตั้ง..."

install_count=0
error_count=0

for prog in "${selected_programs[@]}"; do
    echo ""
    echo "📦 ติดตั้ง $prog..."
    
    if [ -d "$prog" ] && [ -f "$prog/setup.sh" ]; then
        cd "$prog"
        if ./setup.sh; then
            echo "✅ ติดตั้ง $prog เรียบร้อย"
            ((install_count++))
        else
            echo "❌ การติดตั้ง $prog ล้มเหลว"
            ((error_count++))
        fi
        cd ..
    else
        echo "❌ ไม่พบ setup script สำหรับ $prog"
        ((error_count++))
    fi
done

# สรุปผลการติดตั้ง
echo ""
echo "📊 สรุปผลการติดตั้ง:"
echo "   ✅ สำเร็จ: $install_count โปรแกรม"
echo "   ❌ ล้มเหลว: $error_count โปรแกรม"

if [ $error_count -eq 0 ]; then
    echo ""
    echo "🎉 การติดตั้ง Dotfiles เสร็จสิ้นสมบูรณ์!"
    echo ""
    echo "📝 ขั้นตอนถัดไป:"
    echo "   1. รีสตาร์ท Terminal หรือรัน 'exec zsh'"
    echo "   2. รีสตาร์ท applications ที่ติดตั้ง"
    echo "   3. ตรวจสอบการตั้งค่าในแต่ละโปรแกรม"
    echo "   4. อ่าน README.md ของแต่ละโปรแกรมสำหรับการปรับแต่งเพิ่มเติม"
    echo ""
    echo "🚀 คำสั่งที่แนะนำ:"
    echo "   exec zsh               # รีโหลด shell"
    echo "   git config --list      # ตรวจสอบ Git config"
    echo "   code --version         # ตรวจสอบ VS Code"
else
    echo ""
    echo "⚠️  การติดตั้งเสร็จสิ้นแต่มีข้อผิดพลาด"
    echo "กรุณาตรวจสอบ error messages ด้านบนและลองติดตั้งโปรแกรมที่ล้มเหลวอีกครั้ง"
    echo ""
    echo "💡 วิธีติดตั้งเฉพาะโปรแกรม:"
    echo "   cd <program_name>/"
    echo "   ./setup.sh"
fi

echo ""
echo "📚 ข้อมูลเพิ่มเติม:"
echo "   - อ่าน README.md ในโฟลเดอร์หลัก"
echo "   - อ่าน README.md ในแต่ละโฟลเดอร์โปรแกรม"
echo "   - Repository: https://github.com/PattanasakGit/dotfiles"
