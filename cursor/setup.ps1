# Dotfiles Setup Script for Cursor IDE
# สำหรับ Windows PowerShell

param(
    [switch]$Force
)

Write-Host "🚀 เริ่มการติดตั้ง Dotfiles สำหรับ Cursor IDE..." -ForegroundColor Green

# ตรวจสอบว่าเป็น Administrator หรือไม่
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "❌ กรุณารัน PowerShell เป็น Administrator เพื่อสร้าง symbolic links" -ForegroundColor Red
    Write-Host "   หรือใช้ -Force เพื่อคัดลอกไฟล์แทน" -ForegroundColor Yellow
    exit 1
}

# กำหนด path
$CURSOR_CONFIG_DIR = "$env:APPDATA\Cursor\User"
$DOTFILES_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "📱 ตรวจพบ Windows" -ForegroundColor Green

# สร้าง directory ถ้ายังไม่มี
if (-not (Test-Path $CURSOR_CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $CURSOR_CONFIG_DIR -Force | Out-Null
    Write-Host "📁 สร้าง directory: $CURSOR_CONFIG_DIR" -ForegroundColor Green
}

# สร้าง symbolic links
Write-Host "🔗 สร้าง symbolic links..." -ForegroundColor Green

# Backup ไฟล์เดิม (ถ้ามี)
if (Test-Path "$CURSOR_CONFIG_DIR\settings.json") {
    Copy-Item "$CURSOR_CONFIG_DIR\settings.json" "$CURSOR_CONFIG_DIR\settings.json.backup" -Force
    Write-Host "📋 สำรองไฟล์ settings.json เรียบร้อย" -ForegroundColor Yellow
}

if (Test-Path "$CURSOR_CONFIG_DIR\keybindings.json") {
    Copy-Item "$CURSOR_CONFIG_DIR\keybindings.json" "$CURSOR_CONFIG_DIR\keybindings.json.backup" -Force
    Write-Host "📋 สำรองไฟล์ keybindings.json เรียบร้อย" -ForegroundColor Yellow
}

# ลบ symbolic links เดิม (ถ้ามี)
if (Test-Path "$CURSOR_CONFIG_DIR\settings.json") {
    Remove-Item "$CURSOR_CONFIG_DIR\settings.json" -Force
}
if (Test-Path "$CURSOR_CONFIG_DIR\keybindings.json") {
    Remove-Item "$CURSOR_CONFIG_DIR\keybindings.json" -Force
}
if (Test-Path "$CURSOR_CONFIG_DIR\snippets") {
    Remove-Item "$CURSOR_CONFIG_DIR\snippets" -Force -Recurse
}

# สร้าง symbolic links ใหม่
try {
    New-Item -ItemType SymbolicLink -Path "$CURSOR_CONFIG_DIR\settings.json" -Target "$DOTFILES_DIR\cursor\User\settings.json" -Force | Out-Null
    New-Item -ItemType SymbolicLink -Path "$CURSOR_CONFIG_DIR\keybindings.json" -Target "$DOTFILES_DIR\cursor\User\keybindings.json" -Force | Out-Null
    
    if (Test-Path "$DOTFILES_DIR\cursor\User\snippets") {
        New-Item -ItemType SymbolicLink -Path "$CURSOR_CONFIG_DIR\snippets" -Target "$DOTFILES_DIR\cursor\User\snippets" -Force | Out-Null
    }
    
    Write-Host "✅ สร้าง symbolic links เรียบร้อย" -ForegroundColor Green
} catch {
    Write-Host "❌ ไม่สามารถสร้าง symbolic links ได้" -ForegroundColor Red
    Write-Host "   ลองใช้ -Force เพื่อคัดลอกไฟล์แทน" -ForegroundColor Yellow
    exit 1
}

# ติดตั้ง extensions
Write-Host "📦 ติดตั้ง extensions..." -ForegroundColor Green
if (Get-Command code -ErrorAction SilentlyContinue) {
    $extensions = Get-Content "$DOTFILES_DIR\cursor\extensions.txt"
    foreach ($extension in $extensions) {
        if ($extension.Trim()) {
            Write-Host "ติดตั้ง: $extension" -ForegroundColor Cyan
            try {
                code --install-extension $extension
            } catch {
                Write-Host "⚠️  ไม่สามารถติดตั้ง $extension ได้" -ForegroundColor Yellow
            }
        }
    }
    Write-Host "✅ ติดตั้ง extensions เรียบร้อย" -ForegroundColor Green
} else {
    Write-Host "⚠️  ไม่พบ Cursor CLI (code command)" -ForegroundColor Yellow
    Write-Host "กรุณาติดตั้ง extensions เองจากไฟล์ cursor/extensions.txt" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 การติดตั้งเสร็จสิ้น!" -ForegroundColor Green
Write-Host "📝 หมายเหตุ:" -ForegroundColor Yellow
Write-Host "   - ไฟล์เดิมถูกสำรองไว้ใน $CURSOR_CONFIG_DIR\*.backup" -ForegroundColor White
Write-Host "   - รีสตาร์ท Cursor เพื่อให้การตั้งค่าใหม่มีผล" -ForegroundColor White
Write-Host "   - หากมีปัญหา ให้ลบ symbolic links และใช้ไฟล์ backup" -ForegroundColor White
