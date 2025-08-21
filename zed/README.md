# Zed IDE Configuration

การตั้งค่า Zed IDE สำหรับการพัฒนาโปรแกรมที่รวดเร็วและทันสมัย

## 📁 โครงสร้างไฟล์

```
zed/
├── README.md          # ไฟล์นี้
├── setup.sh           # Setup script สำหรับ Mac/Linux
├── settings.json      # การตั้งค่าหลัก Zed
├── keymap.json        # คีย์บอร์ด shortcuts (ถ้ามี)
└── themes/            # Custom themes (ถ้ามี)
```

## 🚀 การติดตั้งแบบอัตโนมัติ

```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/zed

# รัน setup script
./setup.sh
```

## 🔧 การติดตั้งแบบ Manual

### สร้าง Symbolic Links

#### Mac
```bash
# Backup ไฟล์เดิม
ZED_CONFIG_DIR="$HOME/.config/zed"
mv "$ZED_CONFIG_DIR/settings.json" "$ZED_CONFIG_DIR/settings.json.backup"

# สร้าง symbolic links
ln -sf ~/path/to/dotfiles/zed/settings.json "$ZED_CONFIG_DIR/settings.json"

# สร้าง symbolic link สำหรับ keymap ถ้ามี
if [ -f ~/path/to/dotfiles/zed/keymap.json ]; then
    ln -sf ~/path/to/dotfiles/zed/keymap.json "$ZED_CONFIG_DIR/keymap.json"
fi
```

#### Linux
```bash
# เหมือนกับ Mac แต่ path อาจแตกต่างกัน
ZED_CONFIG_DIR="$HOME/.config/zed"
# ทำขั้นตอนเดียวกัน
```

## 🔧 การตั้งค่าที่สำคัญ

### ฟีเจอร์หลักของ Zed
- **AI-Powered**: Integration กับ AI assistants
- **Collaboration**: Real-time collaborative editing
- **Performance**: เร็วและใช้ทรัพยากรน้อย
- **Modern UI**: Interface ที่ทันสมัยและสวยงาม

### Editor Settings
- **Font**: JetBrains Mono, Fira Code
- **Font Size**: 14px
- **Tab Size**: 2 spaces
- **Theme**: Dark mode themes
- **Line Numbers**: เปิดใช้งาน

### Extensions และ Plugins
Zed มี plugins ในตัวสำหรับ:
- **Languages**: Rust, TypeScript, Python, Go, etc.
- **LSP Support**: Language server protocol
- **Git Integration**: Git status และ diff
- **Terminal**: Integrated terminal

## ⌨️ Keybindings ที่สำคัญ

### Navigation
- `Cmd + P`: Quick open file
- `Cmd + Shift + P`: Command palette
- `Cmd + T`: Go to symbol
- `Cmd + G`: Go to line

### Editing
- `Cmd + D`: Select next occurrence
- `Cmd + Shift + L`: Select all occurrences
- `Cmd + /`: Toggle comment
- `Alt + Up/Down`: Move line up/down

### Panels
- `Cmd + B`: Toggle sidebar
- `Cmd + J`: Toggle terminal
- `Cmd + Shift + E`: File explorer
- `Cmd + Shift + F`: Global search

## 🤖 AI Features

### AI Assistant
- **Code Completion**: Smart code suggestions
- **Code Generation**: Generate code from comments
- **Code Explanation**: Explain complex code
- **Refactoring**: AI-powered code improvements

### การตั้งค่า AI
```json
{
  "assistant": {
    "default_model": {
      "provider": "copilot",
      "model": "gpt-4"
    },
    "version": "2"
  }
}
```

## 🎨 Themes และ Appearance

### Built-in Themes
- **One Dark**: Popular dark theme
- **Ayu**: Clean and minimal
- **Gruvbox**: Retro and warm colors
- **Material**: Google Material Design

### Custom Themes
สร้าง custom theme ในโฟลเดอร์ `themes/`:
```json
{
  "name": "My Custom Theme",
  "appearance": "dark",
  "styles": {
    "editor.background": "#1e1e1e",
    "editor.foreground": "#d4d4d4"
  }
}
```

## 🔄 การซิงค์การเปลี่ยนแปลง

### บันทึกการเปลี่ยนแปลง
```bash
# หลังจากแก้ไขการตั้งค่าใน Zed
cd ~/path/to/dotfiles
git add zed/
git commit -m "Update Zed configuration"
git push origin main
```

### ดึงการเปลี่ยนแปลงบนเครื่องอื่น
```bash
cd ~/path/to/dotfiles
git pull origin main
# การตั้งค่าจะอัปเดตอัตโนมัติผ่าน symbolic links
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: Zed ไม่เปิด
```bash
# ตรวจสอบการติดตั้ง
which zed

# ติดตั้งใหม่
brew install --cask zed
```

### ปัญหา: การตั้งค่าไม่แสดงผล
1. รีสตาร์ท Zed
2. ตรวจสอบ symbolic links:
   ```bash
   ls -la ~/.config/zed/
   ```
3. ตรวจสอบ JSON syntax ใน settings.json

### ปัญหา: LSP ไม่ทำงาน
1. ตรวจสอบว่าติดตั้ง language server แล้ว
2. รีสตาร์ท Zed
3. ตรวจสอบ logs ใน Zed's developer tools

## 🚀 เคล็ดลับการใช้งาน

### Multi-cursor Editing
- `Alt + Click`: เพิ่ม cursor ที่ตำแหน่งที่คลิก
- `Cmd + D`: Select และเพิ่ม cursor ที่คำเดียวกันถัดไป
- `Cmd + Shift + L`: Select ทุกคำที่เหมือนกัน

### Code Folding
- `Cmd + Shift + [`: Fold code block
- `Cmd + Shift + ]`: Unfold code block

### Split Panes
- `Cmd + \\`: Split pane vertically
- `Cmd + Shift + \\`: Split pane horizontally

## 📚 ข้อมูลเพิ่มเติม

- [Zed Documentation](https://zed.dev/docs)
- [Zed GitHub Repository](https://github.com/zed-industries/zed)
- [Zed Community](https://github.com/zed-industries/community)
- [Zed Extensions](https://github.com/zed-industries/extensions)

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า Zed:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. อัปเดตไฟล์ในโฟลเดอร์ zed/
3. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
4. Push ไปยัง repository

## 🆚 เปรียบเทียบกับ Editors อื่น

### Zed vs VS Code
- **Performance**: Zed เร็วกว่า
- **AI Integration**: Zed มี AI ในตัว
- **Extensions**: VS Code มี extensions มากกว่า
- **Collaboration**: Zed มี real-time collaboration

### Zed vs Sublime Text
- **Modern Features**: Zed มีฟีเจอร์ทันสมัยกว่า
- **Performance**: ทั้งคู่เร็วพอๆ กัน
- **Price**: Zed ฟรี, Sublime Text เสียเงิน
