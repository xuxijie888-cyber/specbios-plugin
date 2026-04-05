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
- [pending] T-008 创建 GitHub 仓库并推送代码
- [pending] T-009 完善项目文档（认知档案、架构、范围）
- [pending] T-010 测试插件安装和基本功能
- [pending] T-011 优化 skills 实现（错误处理、边界情况）
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

### 当前未开始（高层摘要）
- [pending] GitHub 发布和测试
- [pending] 完善项目文档
- [pending] 优化和发布到插件市场

---

## 当前推荐任务

### A. 当前优先级
- [pending] T-008 创建 GitHub 仓库并推送代码

### B. 后续任务
- [pending] T-009 完善项目文档（认知档案、架构、范围）
- [pending] T-010 测试插件安装和基本功能

## 推荐执行顺序
1. 完成 T-008 创建 GitHub 仓库并推送
2. 完成 T-009 完善项目文档
3. 完成 T-010 测试插件功能
4. 根据测试结果优化（T-011）
5. 准备发布（T-012, T-013）

## 阻塞与依赖

### 当前阻塞
- T-008 需要用户手动在 GitHub 创建 specbios-plugin 仓库

### 当前关键依赖
- T-010（测试）依赖 T-008（GitHub 发布）
- T-011（优化）依赖 T-010（测试反馈）
- T-013（发布市场）依赖 T-010, T-011（功能验证）

---

## 更新规则

1. 机器可解析任务区是唯一权威任务源。
2. 高层摘要区只做人类阅读摘要，不再单独维护另一套任务状态。
3. 每次推进任务时，优先更新机器可解析任务区。
4. 当前任务必须唯一，且只能有一个 `in_progress`。
