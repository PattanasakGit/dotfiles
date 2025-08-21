# Git Configuration

การตั้งค่า Git สำหรับการพัฒนาโปรแกรม

## 📁 โครงสร้างไฟล์

```
git/
├── README.md          # ไฟล์นี้
├── setup.sh           # Setup script สำหรับ Mac/Linux
├── .gitconfig         # Git configuration หลัก
├── .gitignore_global  # Global gitignore file
└── aliases.txt        # Git aliases ที่แนะนำ
```

## 🚀 การติดตั้งแบบอัตโนมัติ

```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/git

# รัน setup script
./setup.sh
```

## 🔧 การติดตั้งแบบ Manual

### สร้าง Symbolic Links
```bash
# Backup ไฟล์เดิม
mv ~/.gitconfig ~/.gitconfig.backup
mv ~/.gitignore_global ~/.gitignore_global.backup

# สร้าง symbolic links
ln -sf ~/path/to/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/path/to/dotfiles/git/.gitignore_global ~/.gitignore_global
```

## 🔧 การตั้งค่าที่สำคัญ

### User Information
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### SSH Key Setup
```bash
# สร้าง SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# เพิ่ม SSH key ไปยัง ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# คัดลอก public key
cat ~/.ssh/id_ed25519.pub
# นำไปเพิ่มใน GitHub/GitLab Settings
```

### URL Rewriting (ใน .gitconfig)
```ini
[url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/
```
ทำให้สามารถใช้ SSH แทน HTTPS สำหรับ GitLab

## 📝 Git Aliases ที่มีประโยชน์

### Aliases ในไฟล์ .gitconfig
```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = !gitk
    graph = log --oneline --graph --decorate --all
    amend = commit --amend --no-edit
    pushf = push --force-with-lease
```

### การใช้งาน
```bash
git st              # แทน git status
git co main         # แทน git checkout main
git br              # แทน git branch
git ci -m "message" # แทน git commit -m "message"
git graph           # ดู git log แบบกราฟ
git amend           # แก้ไข commit ล่าสุด
git pushf           # push --force อย่างปลอดภัย
```

## 🔧 การตั้งค่าขั้นสูง

### Global Gitignore
สร้างไฟล์ `.gitignore_global` สำหรับไฟล์ที่ไม่ต้องการใน repository ทุกตัว:
```
# macOS
.DS_Store
.AppleDouble
.LSOverride

# Windows
Thumbs.db
Desktop.ini

# IDE
.vscode/
.idea/
*.swp

# Logs
*.log
npm-debug.log*
```

### การตั้งค่า Editor
```bash
# ใช้ VS Code เป็น editor
git config --global core.editor "code --wait"

# ใช้ Vim เป็น editor
git config --global core.editor "vim"
```

### Line Ending Configuration
```bash
# สำหรับ macOS/Linux
git config --global core.autocrlf input

# สำหรับ Windows
git config --global core.autocrlf true
```

## 🔄 การซิงค์การเปลี่ยนแปลง

### บันทึกการเปลี่ยนแปลง
```bash
# หลังจากแก้ไข ~/.gitconfig
cd ~/path/to/dotfiles
git add git/
git commit -m "Update git configuration"
git push origin main
```

### ดึงการเปลี่ยนแปลงบนเครื่องอื่น
```bash
cd ~/path/to/dotfiles
git pull origin main
# การตั้งค่าจะอัปเดตอัตโนมัติผ่าน symbolic links
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: SSH ไม่ทำงาน
```bash
# ตรวจสอบ SSH keys
ls -la ~/.ssh/

# ทดสอบการเชื่อมต่อ
ssh -T git@github.com
ssh -T git@gitlab.com

# เพิ่ม SSH key ไปยัง ssh-agent
ssh-add ~/.ssh/id_ed25519
```

### ปัญหา: Permission denied
```bash
# ตรวจสอบสิทธิ์ SSH key
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# ตรวจสอบ ssh-agent
eval "$(ssh-agent -s)"
ssh-add -l
```

### ปัญหา: Git ไม่รู้จัก user
```bash
# ตั้งค่า user information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# ตรวจสอบการตั้งค่า
git config --list
```

## 📚 ข้อมูลเพิ่มเติม

- [Git Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book)
- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GitLab SSH Setup](https://docs.gitlab.com/ee/ssh/)

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า Git:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. อัปเดตไฟล์ในโฟลเดอร์ git/
3. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
4. Push ไปยัง repository
