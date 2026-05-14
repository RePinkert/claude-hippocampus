---
description: 初始化当前工作区的海马体记忆系统
---

# 初始化工作区记忆

检查当前工作区是否已有记忆系统，若无则创建。

## 流程

> **路径说明**：Claude Code 的 project memory 目录由系统自动管理，路径为 `~/.claude/projects/<workspace>/memory/`（即你当前可写入的 auto memory 目录）。以下所有操作均在此目录下进行。`<auto-memory-dir>` 即系统提示中 `persistent auto memory directory` 指定的路径。

1. 获取 auto memory 目录路径（从系统提示中的 `persistent auto memory directory` 获知）
2. 检查该目录下是否已有 `MEMORY.md`
3. 若已存在：提示"记忆系统已初始化"，显示文件列表，结束
4. 若不存在，执行以下初始化：

### 创建目录结构

```bash
mkdir -p <auto-memory-dir>/projects <auto-memory-dir>/sessions
```

### 生成 `MEMORY.md`

使用以下模板（根据当前工作区自动填充工作区名称）：

```markdown
# Workspace Memory

## Projects
| # | 项目 | 状态 | 记忆文件 |
|---|------|------|---------|
| | | | |

## Current Focus
- [待填写]

## Session Protocol
- **开始**：读取 `<auto-memory-dir>/MEMORY.md` + `<auto-memory-dir>/projects/<项目>.md`
- **结束**：执行 `date +%Y-%m-%d-%H%M` 获取时间戳，写入 `<auto-memory-dir>/sessions/<timestamp>.md`
- **巩固**：执行 `/consolidate`

## Model Switching
切换模型时：`读取 <auto-memory-dir>/MEMORY.md 和 <auto-memory-dir>/projects/<项目>.md`
```

## 输出

完成后提示：
- 已创建 `<auto-memory-dir>/MEMORY.md`（全局索引）
- 已创建 `<auto-memory-dir>/projects/`（项目记忆）
- 已创建 `<auto-memory-dir>/sessions/`（session 日志）
- 下一步：编辑 MEMORY.md 添加项目信息，或执行 `/consolidate` 从已有工作日志提炼
