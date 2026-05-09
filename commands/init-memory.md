---
description: 初始化当前工作区的海马体记忆系统
---

# 初始化工作区记忆

检查当前工作区是否已有记忆系统，若无则创建。

## 流程

1. 获取当前工作区路径（`$PWD`）
2. 检查 `memory/MEMORY.md` 是否存在
3. 若已存在：提示"记忆系统已初始化"，显示文件列表，结束
4. 若不存在，执行以下初始化：

### 创建目录结构

```bash
mkdir -p memory/projects memory/sessions
```

### 生成 `memory/MEMORY.md`

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
- **开始**：读取 `memory/MEMORY.md` + `memory/projects/<项目>.md`
- **结束**：写入 `memory/sessions/YYYY-MM-DD-HHMM.md`
- **巩固**：执行 `/consolidate`

## Model Switching
切换模型时：`读取 memory/MEMORY.md 和 memory/projects/<项目>.md`
```

### 生成 `memory/projects/.gitkeep`

空文件，确保 git 能追踪空目录。

### 生成 `memory/sessions/.gitkeep`

空文件，确保 git 能追踪空目录。

## 输出

完成后提示：
- 已创建 `memory/MEMORY.md`（全局索引）
- 已创建 `memory/projects/`（项目记忆）
- 已创建 `memory/sessions/`（session 日志）
- 下一步：编辑 MEMORY.md 添加项目信息，或执行 `/consolidate` 从已有工作日志提炼
