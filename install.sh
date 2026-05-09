#!/bin/bash
# 海马体记忆系统 — Claude Code 命令安装脚本
# 用法: bash install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude/commands"

mkdir -p "$TARGET"

for f in "$SCRIPT_DIR/commands/"*.md; do
    cp "$f" "$TARGET/"
    echo "  已安装: $(basename "$f") → $TARGET/"
done

echo ""
echo "安装完成。在 Claude Code 中使用："
echo "  /init-memory   — 初始化当前工作区的记忆系统"
echo "  /consolidate   — 巩固 session 日志到项目记忆"
