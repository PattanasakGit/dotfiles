# VS Code Configuration

การตั้งค่า Visual Studio Code สำหรับการพัฒนาโปรแกรม

## 📁 โครงสร้างไฟล์

```
vscode/
├── README.md           # ไฟล์นี้
├── setup.sh            # Setup script สำหรับ Mac/Linux
├── settings.json       # การตั้งค่าหลัก VS Code
├── keybindings.json    # คีย์บอร์ด shortcuts
├── extensions.txt      # รายการ extensions ที่ติดตั้ง
└── snippets/           # โค้ด snippets
```

## 🚀 การติดตั้งแบบอัตโนมัติ

```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/vscode

# รัน setup script
./setup.sh
```

## 🔧 การติดตั้งแบบ Manual

### สร้าง Symbolic Links

#### Mac
```bash
# Backup ไฟล์เดิม
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup"
mv "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json.backup"
mv "$VSCODE_USER_DIR/snippets" "$VSCODE_USER_DIR/snippets.backup"

# สร้าง symbolic links
ln -sf ~/path/to/dotfiles/vscode/settings.json "$VSCODE_USER_DIR/settings.json"
ln -sf ~/path/to/dotfiles/vscode/keybindings.json "$VSCODE_USER_DIR/keybindings.json"
ln -sf ~/path/to/dotfiles/vscode/snippets "$VSCODE_USER_DIR/snippets"
```

#### Windows
```cmd
# Backup ไฟล์เดิม
set VSCODE_USER_DIR=%APPDATA%\Code\User
move "%VSCODE_USER_DIR%\settings.json" "%VSCODE_USER_DIR%\settings.json.backup"
move "%VSCODE_USER_DIR%\keybindings.json" "%VSCODE_USER_DIR%\keybindings.json.backup"
move "%VSCODE_USER_DIR%\snippets" "%VSCODE_USER_DIR%\snippets.backup"

# สร้าง symbolic links (ต้องรันเป็น Administrator)
mklink "%VSCODE_USER_DIR%\settings.json" "%~dp0settings.json"
mklink "%VSCODE_USER_DIR%\keybindings.json" "%~dp0keybindings.json"
mklink /D "%VSCODE_USER_DIR%\snippets" "%~dp0snippets"
```

## 📦 การติดตั้ง Extensions

### ติดตั้งจากไฟล์ extensions.txt
```bash
# Mac/Linux
cat extensions.txt | xargs -n 1 code --install-extension

# Windows PowerShell
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```

### สร้างรายการ Extensions ใหม่
```bash
# สร้างรายการ extensions ปัจจุบัน
code --list-extensions > extensions.txt
```

## 🔧 การตั้งค่าที่สำคัญ

### Editor Settings
- **Font**: JetBrains Mono, Fira Code
- **Font Size**: 14px
- **Tab Size**: 2 spaces
- **Word Wrap**: ปิดใช้งาน
- **Auto Save**: onDelay (1 second)

### Extensions ที่แนะนำ
- **Prettier**: Code formatting
- **ESLint**: JavaScript/TypeScript linting
- **Bracket Pair Colorizer**: สีแยกวงเล็บ
- **GitLens**: Git integration
- **Auto Rename Tag**: แก้ไข HTML tags
- **Live Server**: Local development server
- **Path Intellisense**: Path autocomplete
- **Material Icon Theme**: File icons
- **One Dark Pro**: Color theme

### Keybindings ที่ปรับแต่ง
- `Cmd/Ctrl + Shift + P`: Command palette
- `Cmd/Ctrl + B`: Toggle sidebar
- `Cmd/Ctrl + J`: Toggle terminal
- `Cmd/Ctrl + Shift + E`: Explorer
- `Cmd/Ctrl + Shift + F`: Search
- `Cmd/Ctrl + Shift + G`: Git
- `Cmd/Ctrl + D`: Add selection to next find match
- `Cmd/Ctrl + Shift + L`: Select all occurrences

## 📝 การจัดการ Snippets

### สร้าง Snippet ใหม่
1. เปิด Command Palette (`Cmd/Ctrl + Shift + P`)
2. ค้นหา "Configure User Snippets"
3. เลือกภาษาที่ต้องการ
4. เพิ่ม snippet ใหม่

### ตัวอย่าง Snippets
```json
{
  "Console Log": {
    "prefix": "cl",
    "body": [
      "console.log('$1');"
    ],
    "description": "Log output to console"
  },
  "React Function Component": {
    "prefix": "rfc",
    "body": [
      "import React from 'react';",
      "",
      "const $1 = () => {",
      "  return (",
      "    <div>",
      "      $2",
      "    </div>",
      "  );",
      "};",
      "",
      "export default $1;"
    ],
    "description": "React Function Component"
  }
}
```

## 🔄 การซิงค์การเปลี่ยนแปลง

### บันทึกการเปลี่ยนแปลง
```bash
# หลังจากแก้ไขการตั้งค่าใน VS Code
cd ~/path/to/dotfiles
git add vscode/
git commit -m "Update VS Code configuration"
git push origin main
```

### อัปเดต Extensions List
```bash
# สร้างรายการ extensions ใหม่
code --list-extensions > vscode/extensions.txt
git add vscode/extensions.txt
git commit -m "Update VS Code extensions list"
git push origin main
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: Symbolic links ไม่ทำงาน
```bash
# ลบ symbolic links เดิม
rm "$HOME/Library/Application Support/Code/User/settings.json"
rm "$HOME/Library/Application Support/Code/User/keybindings.json"
rm "$HOME/Library/Application Support/Code/User/snippets"

# สร้างใหม่
./setup.sh
```

### ปัญหา: Extensions ไม่ติดตั้ง
1. ตรวจสอบว่า VS Code CLI ทำงานได้: `code --version`
2. ติดตั้ง VS Code CLI:
   - เปิด VS Code
   - Command Palette (`Cmd/Ctrl + Shift + P`)
   - ค้นหา "Shell Command: Install 'code' command in PATH"
3. ติดตั้ง extensions เองผ่าน Extensions Marketplace

### ปัญหา: การตั้งค่าไม่แสดงผล
1. รีสตาร์ท VS Code
2. ตรวจสอบว่า symbolic links ถูกสร้างถูกต้อง:
   ```bash
   ls -la "$HOME/Library/Application Support/Code/User/"
   ```
3. ตรวจสอบสิทธิ์การเข้าถึงไฟล์

## 🔧 การปรับแต่งขั้นสูง

### Custom CSS
ใช้ extension "Custom CSS and JS Loader" เพื่อปรับแต่ง UI

### Settings Sync
VS Code มี Settings Sync ในตัว:
1. เปิด Settings (`Cmd/Ctrl + ,`)
2. ค้นหา "Settings Sync"
3. เปิดใช้งานและเชื่อมต่อกับ GitHub/Microsoft account

### Workspace Settings
สร้างไฟล์ `.vscode/settings.json` ในโปรเจคสำหรับการตั้งค่าเฉพาะโปรเจค

## 📚 ข้อมูลเพิ่มเติม

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)
- [VS Code Keybindings](https://code.visualstudio.com/docs/getstarted/keybindings)
- [VS Code Extensions Marketplace](https://marketplace.visualstudio.com/vscode)

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า VS Code:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. อัปเดตไฟล์ในโฟลเดอร์ vscode/
3. อัปเดต extensions.txt ด้วย `code --list-extensions > extensions.txt`
4. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
5. Push ไปยัง repository
