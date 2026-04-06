# 架构设计（SpecBIOS Claude Code Plugin）

## 1. 设计目标

### 核心目标
将 SpecBIOS 的文档驱动工作流无缝集成到 Claude Code 中，并把长期项目的上下文恢复做成稳定闭环。

### 具体目标
1. **零摩擦集成**：用户无需切换工具，在 Claude Code 中完成所有操作
2. **恢复优先**：会话中断后优先恢复当前任务、最近检查点和下一步动作
3. **简单性**：尽量沿用 Claude Code 官方插件模式，不引入额外 runtime
4. **兼容性**：与 SpecBIOS 文档格式兼容，保留 docs 作为长期真相层

## 2. 当前活动结构

```
specbios-claude-plugin/
├── .claude-plugin/
│   └── plugin.json                # 当前活动 manifest
├── commands/
│   ├── specbios-init.md
│   ├── specbios-task-add.md
│   ├── specbios-task-list.md
│   ├── specbios-task-update.md
│   └── specbios-dispatch.md
├── hooks/
│   └── hooks.json                 # 官方 hook 配置入口
├── hooks-handlers/
│   └── session-start.sh           # SessionStart 恢复摘要注入
└── docs/
    ├── 00-project-dossier.md
    ├── 01-architecture.md
    ├── 02-data-model-and-apis.md
    ├── 03-scope-and-mvp.md
    ├── 04-roadmap-and-progress.md
    └── 05-live-task-board.md
```

> `skills/` 和仓库根目录 `plugin.json` 属于历史遗留，不再是当前主运行面。

## 3. 三层恢复架构

### Layer 1: 长期真相层（docs）
- **职责**：保存长期有效的项目背景、边界、架构和任务状态
- **核心原则**：`docs/05-live-task-board.md` 的机器可解析任务区是唯一权威任务源
- **组成**：
  - `00-project-dossier.md`：项目背景与关键判断
  - `01-architecture.md`：架构约束
  - `02-data-model-and-apis.md`：数据/API 约束
  - `03-scope-and-mvp.md`：范围边界
  - `04-roadmap-and-progress.md`：阶段性路线图
  - `05-live-task-board.md`：任务状态真相源

### Layer 2: 短期交接层（handoff）
- **职责**：保存最近一轮工作的短期恢复信息
- **默认文件**：`.claude/specbios-session.local.md`
- **内容限制**：只记录当前任务、最后检查点、下一原子步骤、阻塞、触碰文件、待确认问题
- **设计原因**：把易变的会话状态从长期 docs 中隔离出去，避免长期文档被噪音污染

### Layer 3: 启动引导层（CLAUDE.md + SessionStart）
- **职责**：在 Claude 进入项目时，尽快告诉它应该如何恢复
- **实现方式**：
  - `CLAUDE.md`：写死稳定恢复协议
  - `hooks/hooks.json` + `hooks-handlers/session-start.sh`：在 SessionStart 注入 recovery summary
- **目标**：即使旧聊天上下文已经丢失，也能优先从磁盘状态恢复

## 4. 恢复协议

### 默认恢复顺序
由 `.specbios.json` 提供默认配置：

1. `.claude/specbios-session.local.md`
2. `docs/05-live-task-board.md`
3. `docs/04-roadmap-and-progress.md`
4. `docs/03-scope-and-mvp.md`
5. `docs/01-architecture.md`
6. `docs/00-project-dossier.md`
7. `docs/02-data-model-and-apis.md`

### 恢复原则
1. 优先信任磁盘状态，不信任过期聊天记忆
2. 优先恢复“我现在该做什么”，而不是重新加载所有历史细节
3. 任务状态只认机器可解析任务区
4. 高层摘要区只做人类阅读摘要，不维护第二套实时状态

## 5. 核心工作流

### 工作流 1：初始化项目

```
用户: /specbios-init
  ↓
创建 .specbios.json
  ↓
创建 CLAUDE.md
  ↓
创建 .claude/specbios-session.local.md
  ↓
创建 docs/00~05
  ↓
提示用户先补核心 docs，再开始 dispatch
```

### 工作流 2：会话启动自动恢复

```
用户: cd project && claude
  ↓
Claude 自动读取 CLAUDE.md
  ↓
SessionStart hook 触发
  ↓
检测 .specbios.json
  ↓
优先读取 handoff 文件
  ↓
若 handoff 缺失，则回退到 task board
  ↓
注入一段 recovery summary
```

### 工作流 3：调度执行

```
用户: /specbios-dispatch
  ↓
读取 .specbios.json
  ↓
按 recoveryReadOrder 读取上下文
  ↓
确定当前任务
  ↓
先写一次 handoff checkpoint
  ↓
执行任务
  ↓
更新任务板机器区
  ↓
再写一次 handoff，记录最新停止点或下一任务
```

### 工作流 4：手动调整任务状态

```
用户: /specbios-task-update T-XXX in_progress|completed
  ↓
更新机器可解析任务区
  ↓
如影响当前任务，则同步改写 handoff
  ↓
若板子不一致，则优先报错，不伪造恢复状态
```

## 6. 关键设计原则

### 原则 1：文档是长期记忆
长期有效的信息必须写进 docs，而不是依赖聊天历史。

### 原则 2：handoff 是短期记忆
短期状态只放进 `.claude/specbios-session.local.md`，不要混入长期 docs。

### 原则 3：机器区是唯一任务真相
任务状态只由 `05-live-task-board.md` 的机器可解析区定义。

### 原则 4：官方 hook 模式优先
自动恢复优先用 `hooks/hooks.json` + handler 脚本，而不是只写概念性 markdown hook。

### 原则 5：渐进增强
本阶段只补恢复闭环，不扩展到依赖分析、执行器推荐、GUI 或团队协作。

## 7. 技术约束

### Claude Code 插件约束
- 当前活动 manifest 位于 `.claude-plugin/plugin.json`
- 用户命令面使用 `commands/*.md`
- hook 使用 `hooks/hooks.json`
- handler 脚本输出 `additionalContext`

### 文件约束
- `.specbios.json`：恢复配置中心
- `CLAUDE.md`：稳定恢复协议
- `.claude/specbios-session.local.md`：短期会话交接
- `docs/05-live-task-board.md`：任务真相源

### 执行约束
- 命令由 Claude 解释执行，不是独立二进制
- 不能把恢复逻辑建立在“上一轮聊天还在”这个前提上
- 必须接受某些上下文文件可能缺失，并优雅回退

## 8. 当前不纳入

本阶段不做：
- CLI core 重写
- 依赖分析集成
- 执行器推荐
- GUI
- 团队协作与后端同步

当前增强版插件只解决一件核心事：**让 Claude Code 在长期项目里更可靠地找回工作上下文。**
