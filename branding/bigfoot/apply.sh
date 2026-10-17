#!/usr/bin/env bash
# Bigfoot OS 品牌覆盖脚本
# 用法：在一台已装好官方 Omarchy 的机器上运行：
#   ./apply.sh
# 原理：底座保持 100% 原版 Omarchy，品牌层"盖"在上面。
# 上游更新时直接升级 Omarchy 本体，本脚本可重复运行，品牌永不丢失。
set -euo pipefail

BRAND_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="bigfoot"
OMARCHY_THEMES="$HOME/.config/omarchy/themes"

echo "==> Bigfoot OS: applying brand overlay..."

# 1. 安装 bigfoot 主题
echo "--> installing theme: $THEME_NAME"
mkdir -p "$OMARCHY_THEMES"
rm -rf "$OMARCHY_THEMES/$THEME_NAME"
cp -r "$BRAND_DIR/themes/$THEME_NAME" "$OMARCHY_THEMES/"
if command -v omarchy >/dev/null 2>&1; then
  omarchy theme set "$THEME_NAME" || true
fi
echo "    theme copied. 如未自动切换，请按 Super+Alt+T 手动选择 bigfoot 主题。"

# 2. 壁纸（backgrounds/ 有图时自动设为默认）
if ls "$BRAND_DIR/backgrounds/"*.{png,jpg,jpeg,webp} >/dev/null 2>&1; then
  echo "--> wallpapers found, linking..."
  mkdir -p "$HOME/.config/omarchy/backgrounds"
  cp "$BRAND_DIR/backgrounds/"*.{png,jpg,jpeg,webp} "$HOME/.config/omarchy/backgrounds/" 2>/dev/null || true
fi

# 3. 系统品牌：/etc/os-release 只改显示名，不动 ID=arch
#    （ID 保持 arch，避免依赖发行版判断的脚本出问题）
echo "--> branding /etc/os-release"
if [ -f "$BRAND_DIR/os-release" ]; then
  sudo cp "$BRAND_DIR/os-release" /etc/os-release
  echo "    $(grep PRETTY_NAME /etc/os-release)"
fi

# 4. 主机名（可选，默认 bigfoot）
if ! hostnamectl hostname 2>/dev/null | grep -qi bigfoot; then
  echo "--> set hostname to 'bigfoot' (skip: Ctrl-C)"
  sudo hostnamectl set-hostname bigfoot || true
fi

echo ""
echo "==> Done. 底座仍是纯 Omarchy，表层已是 Bigfoot。"
echo "    上游更新 Omarchy 后，重新跑一遍 ./apply.sh 即可恢复品牌层。"
