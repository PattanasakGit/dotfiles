# Zsh Configuration

การตั้งค่า Zsh shell พร้อม Oh My Zsh และ Powerlevel10k theme

## 📁 โครงสร้างไฟล์

```
zsh/
├── README.md          # ไฟล์นี้
├── setup.sh           # Setup script สำหรับ Mac
├── .zshrc             # Zsh configuration
├── .p10k.zsh          # Powerlevel10k configuration
├── .zprofile          # Zsh profile
└── plugins.txt        # รายการ plugins ที่แนะนำ
```

## 🚀 การติดตั้งแบบอัตโนมัติ

```bash
# Clone repository
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles/zsh

# รัน setup script
./setup.sh
```

## 🔧 การติดตั้งแบบ Manual

### 1. ติดตั้ง Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. ติดตั้ง Powerlevel10k Theme
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 3. ติดตั้ง Plugins
```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 4. สร้าง Symbolic Links
```bash
# Backup ไฟล์เดิม
mv ~/.zshrc ~/.zshrc.backup
mv ~/.p10k.zsh ~/.p10k.zsh.backup
mv ~/.zprofile ~/.zprofile.backup

# สร้าง symbolic links
ln -sf ~/path/to/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/path/to/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
ln -sf ~/path/to/dotfiles/zsh/.zprofile ~/.zprofile
```

## 🔧 การตั้งค่าที่สำคัญ

### Theme
- **Powerlevel10k**: รวดเร็วและสวยงาม
- **Instant Prompt**: เปิดใช้งานแล้วสำหรับความเร็ว

### Plugins ที่ติดตั้ง
- **git**: Git integration และ aliases
- **zsh-autosuggestions**: แนะนำคำสั่งจากประวัติ
- **zsh-syntax-highlighting**: Syntax highlighting สำหรับคำสั่ง

### Aliases ที่ปรับแต่ง
```bash
alias gs="git status"        # Git status
alias gc="git commit -m"     # Git commit with message
alias ga="git add"           # Git add
alias cls="clear"            # Clear screen
alias yd="yarn dev"          # Yarn dev
alias y="yarn"               # Yarn
alias yb="yarn build"        # Yarn build
alias bd="bun dev"           # Bun dev
alias make=gmake             # Use GNU make
```

### Environment Variables
- **NVM**: Node Version Manager
- **BUN**: Bun runtime
- **PATH**: เพิ่ม Windsurf และ Bun paths

## 📝 การปรับแต่ง

### แก้ไข Powerlevel10k
```bash
p10k configure
```

### เพิ่ม Alias ใหม่
แก้ไขไฟล์ `.zshrc` ในส่วน aliases หรือสร้างไฟล์ `~/.oh-my-zsh/custom/aliases.zsh`

### เพิ่ม Plugin ใหม่
1. ติดตั้ง plugin ใน `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/`
2. เพิ่มชื่อ plugin ใน array `plugins=()` ใน `.zshrc`

## 🔄 การซิงค์การเปลี่ยนแปลง

### บันทึกการเปลี่ยนแปลง
```bash
# หลังจากแก้ไข ~/.zshrc, ~/.p10k.zsh หรือ ~/.zprofile
cd ~/path/to/dotfiles
git add zsh/
git commit -m "Update zsh configuration"
git push origin main
```

### ดึงการเปลี่ยนแปลงบนเครื่องอื่น
```bash
cd ~/path/to/dotfiles
git pull origin main
# รีโหลด zsh
source ~/.zshrc
```

## 🛠️ การแก้ไขปัญหา

### ปัญหา: Powerlevel10k ไม่แสดงถูกต้อง
```bash
# ตรวจสอบ font installation
p10k configure
# หรือติดตั้ง MesloLGS NF font
```

### ปัญหา: Plugins ไม่ทำงาน
```bash
# ตรวจสอบว่า plugins ถูกติดตั้งแล้ว
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
# รีโหลด zsh
source ~/.zshrc
```

### ปัญหา: คำสั่งไม่พบ
```bash
# ตรวจสอบ PATH
echo $PATH
# ตรวจสอบ NVM
command -v nvm
# รีโหลด shell
exec zsh
```

## 📚 ข้อมูลเพิ่มเติม

- [Oh My Zsh Documentation](https://ohmyz.sh/)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Best Zsh Plugins](https://github.com/unixorn/awesome-zsh-plugins)

## 🤝 การมีส่วนร่วม

หากต้องการปรับปรุงการตั้งค่า zsh:
1. ทดสอบการเปลี่ยนแปลงบนเครื่องของคุณ
2. อัปเดตไฟล์ในโฟลเดอร์ zsh/
3. Commit การเปลี่ยนแปลงพร้อมคำอธิบาย
4. Push ไปยัง repository
