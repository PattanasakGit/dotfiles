# Dotfiles Collection

คอลเลกชันการตั้งค่าและ configuration files สำหรับเครื่องมือต่างๆ

## 📁 โครงสร้างโปรเจค

```
dotfiles/
├── cursor/              # Cursor IDE configuration
│   ├── README.md        # คู่มือการใช้งาน Cursor
│   ├── setup.sh         # Setup script สำหรับ Mac/Linux
│   ├── setup.ps1        # Setup script สำหรับ Windows
│   ├── extensions.txt   # รายการ extensions
│   └── User/
│       ├── settings.json
│       ├── keybindings.json
│       └── snippets/
├── zsh/                 # Zsh shell configuration
│   ├── README.md        # คู่มือการใช้งาน Zsh
│   ├── setup.sh         # Setup script
│   ├── .zshrc           # Zsh configuration
│   ├── .p10k.zsh        # Powerlevel10k theme
│   ├── .zprofile        # Zsh profile
│   └── plugins.txt      # รายการ plugins ที่แนะนำ
├── git/                 # Git configuration
│   ├── README.md        # คู่มือการใช้งาน Git
│   ├── setup.sh         # Setup script
│   ├── .gitconfig       # Git configuration
│   └── .gitignore_global # Global gitignore
├── vscode/              # VS Code configuration
│   ├── README.md        # คู่มือการใช้งาน VS Code
│   ├── setup.sh         # Setup script
│   ├── settings.json    # VS Code settings
│   ├── keybindings.json # Keybindings
│   ├── extensions.txt   # รายการ extensions
│   └── snippets/        # Code snippets
├── zed/                 # Zed IDE configuration
│   ├── README.md        # คู่มือการใช้งาน Zed
│   ├── setup.sh         # Setup script
│   └── settings.json    # Zed settings
├── terminal/            # Terminal configuration
│   ├── README.md        # คู่มือการใช้งาน Terminal
│   ├── setup.sh         # Setup script
│   └── themes/          # Terminal themes
└── README.md           # ไฟล์นี้
```

## 🚀 การติดตั้ง

แต่ละโปรแกรมมีคู่มือการใช้งานแยกกัน:

- **[Cursor IDE](./cursor/README.md)** - การตั้งค่า Cursor IDE สำหรับ Mac/Windows
- **[Zsh Shell](./zsh/README.md)** - การตั้งค่า Zsh + Oh My Zsh + Powerlevel10k
- **[Git](./git/README.md)** - การตั้งค่า Git และ SSH keys
- **[VS Code](./vscode/README.md)** - การตั้งค่า Visual Studio Code
- **[Zed IDE](./zed/README.md)** - การตั้งค่า Zed IDE (AI-powered editor)
- **[Terminal](./terminal/README.md)** - การตั้งค่า Terminal apps (Terminal.app, iTerm2)

## 📥 การ Clone Repository

```bash
git clone https://github.com/PattanasakGit/dotfiles.git
cd dotfiles
```

## ⚡ การติดตั้งทั้งหมดอัตโนมัติ

```bash
# ติดตั้งทั้งหมดในครั้งเดียว
./setup_all.sh

# หรือเลือกติดตั้งเฉพาะโปรแกรมที่ต้องการ
./setup_all.sh
```

## 📝 การอัปเดต

1. แก้ไขการตั้งค่าในโปรแกรมที่ต้องการ
2. Commit การเปลี่ยนแปลง
3. Push ไปยัง repository
4. Pull บนเครื่องอื่นเพื่อซิงค์

## 🔗 Repository

- **GitHub**: [https://github.com/PattanasakGit/dotfiles.git](https://github.com/PattanasakGit/dotfiles.git)
- **Clone URL**: `https://github.com/PattanasakGit/dotfiles.git`

## 🤝 การมีส่วนร่วม

1. Fork repository
2. สร้าง feature branch
3. Commit การเปลี่ยนแปลง
4. Push ไปยัง branch
5. สร้าง Pull Request

## 📄 License

MIT License