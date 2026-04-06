# 实时任务板（SpecBIOS Project）

> 这是当前项目的动态任务计划与进度文档。未来上下文丢失或中断恢复时，先读本文件。

---

## 机器可解析任务区（权威任务源）
- [completed] T-001 建立 docs 骨架
- [completed] T-002 创建插件基础结构（plugin.json, skills, hooks）
- [completed] T-003 实现 5 个核心 skills（init, task-add, task-list, task-update, dispatch）
- [completed] T-004 实现自动检测 hook（on-start.md）
- [completed] T-005 创建 README 和 GUIDE 文档
- [completed] T-006 添加 LICENSE 和 .gitignore
- [completed] T-007 初始化 git 仓库并提交
- [completed] T-008 创建 GitHub 仓库并推送代码
- [completed] T-009 完善项目文档（认知档案、架构、范围）
- [completed] T-010 测试插件安装和基本功能
- [completed] T-011 优化 skills 实现（错误处理、边界情况）
- [pending] T-012 添加示例项目和使用演示
- [pending] T-013 发布到 Claude Code 插件市场
- [pending] T-014 编写贡献指南和开发文档
---

## 当前执行状态

### 当前阶段
- 阶段：Development - MVP Implementation
- 当前重点：Complete plugin core functionality and prepare for first release

### 当前已完成（高层摘要）
- [completed] 建立 docs 骨架
- [completed] 创建插件基础结构（plugin.json, 5 skills, 1 hook）
- [completed] 编写文档（README, GUIDE, LICENSE）
- [completed] Git 初始化和首次提交
- [completed] GitHub 发布
- [completed] 修正 Claude Code 插件结构并验证命令已可识别
- [completed] 优化命令边界情况和错误提示

### 当前未开始（高层摘要）
- [pending] 添加示例与演示
- [pending] 发布到插件市场
- [pending] 编写贡献指南和开发文档

---

## 当前推荐任务

### A. 当前优先级
- [pending] T-012 添加示例项目和使用演示

### B. 后续任务
- [pending] T-013 发布到 Claude Code 插件市场
- [pending] T-014 编写贡献指南和开发文档

## 推荐执行顺序
1. 完成 T-012 添加示例项目和使用演示
2. 完成 T-013 发布到 Claude Code 插件市场
3. 完成 T-014 编写贡献指南和开发文档

## 阻塞与依赖

### 当前无硬阻塞
当前插件已推送到 GitHub，且本地验证通过。

### 当前关键依赖
- T-013 依赖 T-012（先验证可用性）
- T-014 可与 T-013 并行推进

---

## 更新规则

1. 机器可解析任务区是唯一权威任务源。
2. 高层摘要区只做人类阅读摘要，不再单独维护另一套任务状态。
3. 每次推进任务时，优先更新机器可解析任务区。
4. 当前任务必须唯一，且只能有一个 `in_progress`。
