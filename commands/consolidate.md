---
description: 巩固 session 日志到项目记忆（海马体 replay）
---

# 巩固记忆

读取 auto memory 目录下 `sessions/` 中未处理的 session 日志，提炼关键信息到 `projects/` 和 `MEMORY.md`。

> **路径说明**：所有操作均在 Claude Code 的 auto memory 目录（`~/.claude/projects/<workspace>/memory/`）下进行。从系统提示中的 `persistent auto memory directory` 获知具体路径。

## 流程

1. 扫描 `<auto-memory-dir>/sessions/` 找到未标记 `[consolidated]` 的文件
2. 对每个 session 日志：
   - 提取项目状态变更 → 更新对应 `projects/<name>.md`
   - 提取关键发现/决策 → 追加到 `projects/<name>.md`
   - 提取操作陷阱/Gotchas → 追加到 `projects/<name>.md` 的"操作陷阱"节
   - 提取未完成事项 → 更新 `projects/<name>.md` 的"下一步"
3. 更新 `MEMORY.md` 的项目状态表和 Current Focus
4. 在已处理的 session 日志顶部添加 `[consolidated]` 标记
5. **修剪过时信息（遗忘机制）**：
   a. 扫描本次涉及的每个项目记忆，识别可修剪内容：
      - 被新信息取代的旧条目（同一发现/决策被多次追加）
      - "当前状态"或"下一步"中已完成但仍保留的条目
      - 不同 session 记录的重复操作陷阱（合并为一条）
      - 已归档项目的详细迭代历史（压缩为 1-2 行摘要）
      - 过于具体的 commit hash / 操作过程细节（保留结论即可）
   b. 生成修剪报告：列出每条拟删除/压缩的内容及原因
   c. 使用 AskUserQuestion 展示报告，等待用户确认后执行
   d. 如项目记忆超过 150 行，在报告中标注并建议优先修剪最旧内容
   e. 更新项目记忆中 `<!-- 最后更新: YYYY-MM-DD -->` 标记为当天日期
6. **归档已巩固的 session 日志**：
   a. 创建 `<auto-memory-dir>/sessions/archive/` 目录（如不存在）
   b. 将已标记 `[consolidated]` 的 session 文件移至 `archive/` 子目录
   c. 汇报归档数量
7. 汇报巩固结果（含新提炼信息 + 修剪摘要 + 归档统计）

## 注意

- 巩固以提炼新信息为主，同时可修剪过时/重复/已完成信息——修剪前需用户确认
- 项目记忆超过 150 行时，consolidate 会主动建议修剪最旧内容
- 如果项目记忆文件不存在，自动创建，使用以下模板：
  ```
  # <项目名>

  ## 一句话
  [项目目标的一句话描述]

  ## 当前状态
  <!-- 最后更新: YYYY-MM-DD -->
  [进度/阶段/关键指标]

  ## 关键文件
  - `path/to/file` — 说明

  ## 技术栈
  [使用的技术/工具]

  ## 关键决策
  - [决策及其原因]

  ## 已知问题
  - [当前未解决的问题]

  ## 操作陷阱
  - [在迭代中发现的规律性陷阱，帮助未来 session 避坑]

  ## 下一步
  - [ ] 待办1
  ```
- session 日志在巩固后移至 `sessions/archive/` 子目录，不删除原始记录
- 如果 session 日志中有"操作陷阱"节，优先提取到项目记忆的对应节
- session 文件命名格式：`YYYY-MM-DD-HHMM.md`（每次 session 一个文件）
