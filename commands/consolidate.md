---
description: 巩固 session 日志到项目记忆（海马体 replay）
---

# 巩固记忆

读取 `memory/sessions/` 下未处理的 session 日志，提炼关键信息到 `memory/projects/` 和 `memory/MEMORY.md`。

## 流程

1. 扫描 `memory/sessions/` 找到未标记 `[consolidated]` 的文件
2. 对每个 session 日志：
   - 提取项目状态变更 → 更新对应 `projects/<name>.md`
   - 提取关键发现/决策 → 追加到 `projects/<name>.md`
   - 提取未完成事项 → 更新 `projects/<name>.md` 的"下一步"
3. 更新 `MEMORY.md` 的项目状态表和 Current Focus
4. 在已处理的 session 日志顶部添加 `[consolidated]` 标记
5. 汇报巩固结果

## 注意

- 巩固是增量式的，不删除已有信息，只追加/更新
- 如果项目记忆文件不存在，自动创建（使用 `11-hippocapmus/templates/project.md.tmpl` 作为模板）
- session 日志在巩固后保留，标记为已处理即可
