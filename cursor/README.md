# Cursor IDE Configuration

การตั้งค่า Cursor IDE สำหรับการใช้งานข้ามแพลตฟอร์ม (Mac/Windows)

## 📁 โครงสร้างไฟล์

```
cursor/
├── README.md           # ไฟล์นี้
├── setup.sh           # Setup script สำหรับ Mac/Linux
├── setup.ps1          # Setup script สำหรับ Windows
├── extensions.txt     # รายการ extensions ที่ติดตั้ง
└── User/
    ├── settings.json  # การตั้งค่าหลัก
    ├── keybindings.json # คีย์บอร์ด shortcuts
    └── snippets/      # โค้ด snippets
```

## 🚀 การติดตั้งแบบอัตโนมัติ

### Mac/Linux
```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/cursor

# รัน setup script
./setup.sh
```

### Windows
```powershell
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/cursor

# รัน PowerShell เป็น Administrator แล้วรัน
.\setup.ps1
```

## 🔧 การติดตั้งแบบ Manual

### Mac
```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles

# สร้าง symbolic links
ln -sf ~/path/to/dotfiles/cursor/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/path/to/dotfiles/cursor/User/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
ln -sf ~/path/to/dotfiles/cursor/User/snippets ~/Library/Application\ Support/Cursor/User/snippets
```

### Windows
```cmd
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles

# สร้าง symbolic links (ต้องรันเป็น Administrator)
mklink "%APPDATA%\Cursor\User\settings.json" "%~dp0cursor\User\settings.json"
mklink "%APPDATA%\Cursor\User\keybindings.json" "%~dp0cursor\User\keybindings.json"
mklink /D "%APPDATA%\Cursor\User\snippets" "%~dp0cursor\User\snippets"
```

## 📦 การติดตั้ง Extensions

### วิธีที่ 1: ใช้ Setup Script (แนะนำ)
Setup script จะติดตั้ง extensions ให้อัตโนมัติ

### วิธีที่ 2: ติดตั้งเอง
```bash
# Mac/Linux
cat extensions.txt | xargs -n 1 code --install-extension

# Windows PowerShell
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```

### วิธีที่ 3: ติดตั้งทีละตัว
เปิด Cursor แล้วติดตั้ง extensions จากรายการใน `extensions.txt` ผ่าน Extensions Marketplace

## 🔧 การตั้งค่าที่สำคัญ

### Theme และ Appearance
- **Theme**: Vitesse Dark
- **Font**: JetBrains Mono
- **Font Size**: 14px
- **Line Height**: 1.5

### Extensions ที่แนะนำ
- **ESLint** - JavaScript/TypeScript linting
- **Prettier** - Code formatting
- **GitLens** - Git integration
- **Tailwind CSS IntelliSense** - Tailwind CSS support
- **Bookmarks** - Code bookmarks
- **Project Manager** - Project management
- **Git Graph** - Git visualization

### Keybindings ที่ปรับแต่ง
- `Cmd/Ctrl + Shift + P` - Command palette
- `Cmd/Ctrl + B` - Toggle sidebar
- `Cmd/Ctrl + J` - Toggle terminal
- `Cmd/Ctrl + Shift + E` - Explorer
- `Cmd/Ctrl + Shift + F` - Search
- `Cmd/Ctrl + Shift + G` - Git

## 📝 การอัปเดตการตั้งค่า

### วิธีที่ 1: อัปเดตผ่าน Cursor
1. แก้ไขการตั้งค่าใน Cursor
2. การเปลี่ยนแปลงจะถูกบันทึกในไฟล์ symbolic link
3. Commit และ push การเปลี่ยนแปลง

### วิธีที่ 2: แก้ไขไฟล์โดยตรง
1. แก้ไขไฟล์ใน `cursor/User/`
2. รีสตาร์ท Cursor
3. Commit และ push การเปลี่ยนแปลง

## 🔄 การซิงค์ระหว่างเครื่อง

### การ Push การเปลี่ยนแปลง
```bash
git add .
git commit -m "Update Cursor settings"
git push origin main
```

### การ Fork และใช้งาน
หากต้องการใช้ dotfiles นี้:
1. Fork repository ไปยัง GitHub ของคุณ
2. Clone repository ที่ fork แล้ว
3. แก้ไข URL ใน README ให้ตรงกับ repository ของคุณ

### การ Pull บนเครื่องใหม่
```bash
git pull origin main
# รัน setup script อีกครั้งเพื่ออัปเดต
./setup.sh  # หรือ .\setup.ps1 สำหรับ Windows
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: Symbolic links ไม่ทำงาน
```bash
# ลบ symbolic links เดิม
rm ~/Library/Application\ Support/Cursor/User/settings.json
rm ~/Library/Application\ Support/Cursor/User/keybindings.json
rm ~/Library/Application\ Support/Cursor/User/snippets

# สร้างใหม่
./setup.sh
```

### ปัญหา: Extensions ไม่ติดตั้ง
1. ตรวจสอบว่า Cursor CLI ทำงานได้: `code --version`
2. ติดตั้ง extensions เองผ่าน Extensions Marketplace
3. ตรวจสอบไฟล์ `extensions.txt` ว่ามี extension ID ที่ถูกต้อง

### ปัญหา: การตั้งค่าไม่แสดงผล
1. รีสตาร์ท Cursor
2. ตรวจสอบว่า symbolic links ถูกสร้างถูกต้อง
3. ตรวจสอบสิทธิ์การเข้าถึงไฟล์

## 📋 การสำรองข้อมูล

Setup script จะสำรองไฟล์เดิมไว้ใน:
- **Mac**: `~/Library/Application Support/Cursor/User/*.backup`
- **Windows**: `%APPDATA%\Cursor\User\*.backup`

หากต้องการกู้คืน:
```bash
# Mac
cp ~/Library/Application\ Support/Cursor/User/settings.json.backup ~/Library/Application\ Support/Cursor/User/settings.json

# Windows
copy "%APPDATA%\Cursor\User\settings.json.backup" "%APPDATA%\Cursor\User\settings.json"
```

## 🔍 การตรวจสอบสถานะ

### ตรวจสอบ Symbolic Links
```bash
# Mac
ls -la ~/Library/Application\ Support/Cursor/User/

# Windows
dir "%APPDATA%\Cursor\User\"
```

### ตรวจสอบ Extensions ที่ติดตั้ง
```bash
code --list-extensions
```

## 📚 ข้อมูลเพิ่มเติม

- [Cursor Documentation](https://cursor.sh/docs)
- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)
- [VS Code Keybindings](https://code.visualstudio.com/docs/getstarted/keybindings)

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
3. Push ไปยัง repository
4. แจ้งให้ทีมทราบเพื่อ review
