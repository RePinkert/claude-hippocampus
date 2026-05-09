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
5. 汇报巩固结果

## 注意

- 巩固是增量式的，不删除已有信息，只追加/更新
- 如果项目记忆文件不存在，自动创建，使用以下模板：
  ```
  # <项目名>

  ## 一句话
  [项目目标的一句话描述]

  ## 当前状态
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
- session 日志在巩固后保留，标记为已处理即可
- 如果 session 日志中有"操作陷阱"节，优先提取到项目记忆的对应节
- session 文件命名格式：`YYYY-MM-DD-HHMM.md`（每次 session 一个文件）
