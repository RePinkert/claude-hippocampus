# claude-hippocampus — 海马体记忆系统

跨项目、跨模型的 Session 间知识持久化方案。借鉴海马体的记忆机制（编码 → 巩固 → 检索），用文件系统模拟长期记忆。

## 安装

```bash
# 克隆项目
git clone https://github.com/RePinkert/claude-hippocampus.git
cd claude-hippocampus

# 一键安装命令到 Claude Code
bash install.sh
```

或手动复制：

```bash
cp commands/*.md ~/.claude/commands/
```

## 使用

### 1. 初始化工作区记忆

在任意工作区的 Claude Code 中执行：

```
/init-memory
```

自动创建：
- `memory/MEMORY.md` — 全局索引（自动加载）
- `memory/projects/` — 项目记忆目录
- `memory/sessions/` — Session 日志目录

### 2. 每次 Session

**开始时**：读取相关项目记忆
```
读取 memory/MEMORY.md 和 memory/projects/<项目>.md
```

**结束时**：写入 Session 日志到 `memory/sessions/YYYY-MM-DD-HHMM.md`

### 3. 巩固记忆

```
/consolidate
```

从 session 日志提炼关键信息到项目记忆。

## 架构

```
<workspace>/memory/
├── MEMORY.md              ← 全局索引（自动加载，< 80 行）
├── projects/              ← 语义记忆（按需读取）
│   └── <project>.md
└── sessions/              ← 情景记忆（仅巩固时读取）
    └── YYYY-MM-DD-HHMM.md
```

### 海马体映射

| 海马体功能 | 文件 | 加载时机 |
|---|---|---|
| 工作记忆 | `MEMORY.md` | 自动（每次 session） |
| 语义记忆 | `projects/*.md` | 按需（提到项目时） |
| 情景记忆 | `sessions/*.md` | 仅巩固时 |
| 记忆巩固 | `/consolidate` | 手动触发 |

### 上下文成本

| 组件 | 大小 | 占 256K 预算 |
|------|------|-------------|
| MEMORY.md | ~1.5K tokens | 0.6% |
| 1 个项目记忆 | ~2-3K tokens | 0.8-1.2% |
| 首次加载总计 | ~3-5K tokens | 1.4-2.3% |

## 参考来源

- [Cline/Roo Code Memory Bank](https://github.com/cline/cline) — 纯 Markdown 文件模式
- [Stanford Generative Agents](https://github.com/joonspk-research/generative_agents) — Memory Stream + Retrieval + Reflection
- [HippoRAG](https://github.com/OSU-NLP-Group/HippoRAG) — 海马体索引理论
- [MemGPT/Letta](https://github.com/letta-ai/letta) — OS 式分层内存
