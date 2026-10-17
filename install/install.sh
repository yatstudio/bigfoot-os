#!/usr/bin/env bash
# Bigfoot OS 一键安装入口
# 流程：1) 装官方原版 Omarchy（底座） 2) 克隆本仓库 3) 跑品牌覆盖脚本
set -euo pipefail

echo "=== Bigfoot OS installer ==="
echo ""
echo "第 1 步：请先按官方文档装好原版 Omarchy：https://omarchy.org"
echo "（Arch ISO 启动 → 跑官方安装脚本，底座保持 100% 原版）"
read -rp "官方 Omarchy 已装好？(y/N) " ok
[[ "$ok" == [yY] ]] || { echo "先装好 Omarchy 再回来跑我。"; exit 1; }

echo ""
echo "第 2 步：应用 Bigfoot 品牌层..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../branding/bigfoot/apply.sh"

echo ""
echo "=== 安装完成，欢迎来到 Bigfoot OS ==="
