# Bigfoot OS

Bigfoot 品牌的 Linux 发行版：**底座是 100% 原版 Omarchy，品牌是 Bigfoot。**

## 架构：「底座不动，品牌覆盖」

```
┌─────────────────────────────┐
│  Bigfoot 品牌层（本仓库）     │  ← 主题 / 壁纸 / logo / os-release / 预装
│  branding/bigfoot/apply.sh  │  ← 一键覆盖脚本，可重复运行
├─────────────────────────────┤
│  Omarchy 官方原版（上游）     │  ← 直接装官方版，跟官方更新
├─────────────────────────────┤
│  Arch Linux                 │
└─────────────────────────────┘
```

- 不 fork Omarchy，不改它一行代码 → 上游更新零冲突、零维护负担。
- 品牌层是独立目录 + 一个覆盖脚本 → Omarchy 升级后重跑 `apply.sh`，品牌即恢复。
- 协议：Omarchy 是 MIT，本项目同样 MIT。保留上游版权声明，不用 "Omarchy" 商标。

## 安装

```bash
# 1. 先按官方文档装好原版 Omarchy：https://omarchy.org
# 2. 克隆本仓库并应用品牌层
git clone https://github.com/yatstudio/bigfoot-os.git
cd bigfoot-os
./install/install.sh
# 或直接：
./branding/bigfoot/apply.sh
```

## 目录

- `branding/bigfoot/apply.sh` —— 品牌覆盖脚本（主题 / 壁纸 / os-release / 主机名）
- `branding/bigfoot/themes/bigfoot/` —— Bigfoot 默认主题（源自 Downlink 配色体系）
- `branding/bigfoot/backgrounds/` —— 品牌壁纸（待补充）
- `branding/bigfoot/os-release` —— 系统显示名模板（ID 保持 arch）
- `install/install.sh` —— 一键安装入口

## 路线图

- [x] 品牌覆盖层骨架 + apply.sh
- [ ] Bigfoot 专属壁纸 / logo.svg / icon.png
- [ ] 预装软件清单（bigfoot 硬件用户常用工具）
- [ ] archiso 定制 ISO（一键出厂镜像，给 bigfoot 整机预装用）
- [ ] OTA 更新通道（omarchy 更新 + 品牌层自动重应用）

## 协议

MIT。详见 LICENSE。本项目基于 [omacom/omarchy](https://github.com/basecamp/omarchy)（MIT），
版权归原作者所有；"Omarchy" 商标归其持有者，本项目不使用该商标。
