# Terminal Configuration

การตั้งค่า Terminal applications สำหรับ macOS

## 📁 โครงสร้างไฟล์

```
terminal/
├── README.md                    # ไฟล์นี้
├── setup.sh                     # Setup script สำหรับ Mac
├── macos_terminal_profile.txt   # Terminal.app profile export
├── iterm2_profile.json          # iTerm2 profile export
└── themes/                      # Terminal themes
    ├── one_dark.terminal
    ├── gruvbox.terminal
    └── dracula.terminal
```

## 🚀 การติดตั้งแบบอัตโนมัติ

```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/terminal

# รัน setup script
./setup.sh
```

## 🔧 การติดตั้งแบบ Manual

### Terminal.app (Default macOS Terminal)

#### Import Profile
1. เปิด Terminal.app
2. ไปที่ Terminal > Preferences (หรือ Cmd + ,)
3. ไปที่แท็บ "Profiles"
4. คลิกปุ่ม gear icon ด้านล่าง
5. เลือก "Import..."
6. เลือกไฟล์ `.terminal` จากโฟลเดอร์ `themes/`

#### Export Profile (สำหรับสำรองข้อมูล)
1. เลือก profile ที่ต้องการ export
2. คลิกปุ่ม gear icon
3. เลือก "Export..."
4. บันทึกเป็น `.terminal` file

### iTerm2

#### Import Profile
1. เปิด iTerm2
2. ไปที่ iTerm2 > Preferences (หรือ Cmd + ,)
3. ไปที่แท็บ "Profiles"
4. คลิก "Other Actions..." ด้านล่างซ้าย
5. เลือก "Import JSON Profiles..."
6. เลือกไฟล์ `iterm2_profile.json`

#### Export Profile (สำหรับสำรองข้อมูล)
1. เลือก profile ที่ต้องการ export
2. คลิก "Other Actions..."
3. เลือก "Save Profile as JSON..."

## 🎨 Themes และ Color Schemes

### Popular Themes
1. **One Dark** - จาก Atom editor
2. **Gruvbox** - Retro และ warm colors
3. **Dracula** - Dark theme ที่นิยม
4. **Solarized** - Classic และดูง่าย
5. **Monokai** - จาก Sublime Text

### การติดตั้ง Theme
```bash
# วิธีที่ 1: Import ผ่าน GUI (แนะนำ)
# ตาม Manual installation ด้านบน

# วิธีที่ 2: Command line (สำหรับ Terminal.app)
open themes/one_dark.terminal
```

## ⚙️ การตั้งค่าที่แนะนำ

### Font Settings
- **Font**: SF Mono, JetBrains Mono, Fira Code
- **Size**: 13-14pt
- **Line Spacing**: 1.0-1.2
- **Character Spacing**: 1.0

### Terminal Behavior
- **Scrollback**: Unlimited หรือ 10,000 lines
- **Close if shell exited cleanly**: เปิดใช้งาน
- **Audible bell**: ปิดใช้งาน
- **Visual bell**: เปิดใช้งาน (ถ้าต้องการ)

### Appearance
- **Background Opacity**: 85-95%
- **Blur**: เล็กน้อย (ถ้าชอบ)
- **Cursor**: Block หรือ Underline
- **Cursor Blink**: ตามความชอบ

## 🔧 การปรับแต่งขั้นสูง

### Terminal.app

#### การตั้งค่าในไฟล์ .terminal
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>name</key>
    <string>Custom Theme</string>
    <key>BackgroundColor</key>
    <data>
    <!-- Base64 encoded color data -->
    </data>
    <!-- เพิ่มการตั้งค่าอื่นๆ -->
</dict>
</plist>
```

### iTerm2

#### Hotkey Window
- **Hotkey**: `` Cmd + ` `` หรือ `F12`
- **Animation**: Slide in from top
- **Auto-hide**: เปิดใช้งาน

#### Split Panes
- **Vertical Split**: Cmd + D
- **Horizontal Split**: Cmd + Shift + D
- **Navigate**: Cmd + Option + Arrow Keys

#### Session Restoration
- **Restore windows**: เปิดใช้งาน
- **Save/Restore window positions**: เปิดใช้งาน

## 🔄 การซิงค์การเปลี่ยนแปลง

### Export การตั้งค่าปัจจุบัน
```bash
# Terminal.app - Export manual ผ่าน GUI

# iTerm2 - Export manual ผ่าน GUI
# หรือใช้ script
./export_terminal_configs.sh
```

### บันทึกการเปลี่ยนแปลง
```bash
cd ~/path/to/dotfiles
git add terminal/
git commit -m "Update terminal configuration"
git push origin main
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: Font ไม่แสดงถูกต้อง
```bash
# ติดตั้ง font ที่จำเป็น
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono
brew install --cask font-fira-code
brew install --cask font-sf-mono

# รีสตาร์ท Terminal
```

### ปัญหา: Color ไม่แสดงถูกต้อง
1. ตรวจสอบ TERM environment variable:
   ```bash
   echo $TERM
   # ควรเป็น xterm-256color หรือ screen-256color
   ```
2. เพิ่มใน .zshrc หรือ .bash_profile:
   ```bash
   export TERM=xterm-256color
   ```

### ปัญหา: Theme ไม่ import ได้
1. ตรวจสอบไฟล์ format ถูกต้อง
2. ลองดาวน์โหลดใหม่จาก official source
3. Import manual ทีละขั้นตอน

## 📱 Alternative Terminal Apps

### iTerm2 (แนะนำ)
```bash
brew install --cask iterm2
```
**ฟีเจอร์เด่น:**
- Split panes
- Hotkey window
- Search และ selection ดีกว่า
- Tmux integration

### Alacritty (GPU-accelerated)
```bash
brew install --cask alacritty
```
**ฟีเจอร์เด่น:**
- เร็วมาก (GPU acceleration)
- Cross-platform
- Configuration ผ่าน YAML

### Kitty (Fast)
```bash
brew install --cask kitty
```
**ฟีเจอร์เด่น:**
- เร็วและใช้ทรัพยากรน้อย
- Advanced features
- Scriptable

### Warp (AI-powered)
```bash
brew install --cask warp
```
**ฟีเจอร์เด่น:**
- AI assistant
- Modern UI
- Collaboration features

## 📚 ข้อมูลเพิ่มเติม

- [iTerm2 Documentation](https://iterm2.com/documentation.html)
- [Terminal.app User Guide](https://support.apple.com/guide/terminal/)
- [Alacritty Configuration](https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.yml.5.scd)
- [Oh My Zsh Themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

## 🎨 สร้าง Theme เอง

### สำหรับ Terminal.app
1. Duplicate existing profile
2. แก้ไข colors manually
3. Export เป็น .terminal file

### สำหรับ iTerm2
1. ใช้ Color Preset editor
2. หรือแก้ไข JSON file โดยตรง
3. Share ผ่าน Gist หรือ GitHub

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า Terminal:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. Export configuration ใหม่
3. อัปเดตไฟล์ในโฟลเดอร์ terminal/
4. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
5. Push ไปยัง repository
