# SpecBIOS Claude Code Plugin

[中文](#中文) | [English](#english)

Documentation-driven AI programming orchestrator for Claude Code.

---

## 中文

### 它是什么？

SpecBIOS 是一个面向长期项目的 Claude Code 插件，核心目标是解决 **上下文丢失 / 项目记忆丢失**。

当你做多天、多周的项目时，AI 往往会忘记：
- 你到底在做什么项目
- 为什么这样设计
- 现在做到哪一步了
- 下一步该做什么

SpecBIOS 通过“文档 + 任务板 + 会话交接文件”把这些状态落到磁盘里，让 Claude Code 在下一次进入项目时还能恢复工作上下文。

### 核心思路

SpecBIOS 现在采用三层恢复结构：
- **长期真相层**：`docs/` 文档体系
- **短期交接层**：`.claude/specbios-session.local.md`
- **启动引导层**：`CLAUDE.md` + `SessionStart` hook

其中：
- `docs/05-live-task-board.md` 的机器可解析任务区是唯一权威任务源
- `CLAUDE.md` 告诉 Claude 应该按什么顺序恢复上下文
- `.claude/specbios-session.local.md` 保存最近一次停点、下一步、阻塞、触碰文件

### 适合谁？

适合这些场景：
- 你在用 Claude Code 做长期项目
- 你不想每次开新会话都重新解释项目
- 你希望任务推进和上下文恢复能落盘保存
- 你希望工作流尽量留在 Claude Code 内完成

### 安装

```bash
# 从 GitHub 安装
claude plugin install https://github.com/xuxijie888-cyber/specbios-plugin

# 或从本地目录安装（开发时）
claude plugin install /path/to/specbios-claude-plugin
```

> 插件仓库需要包含 `.claude-plugin/plugin.json`

### 快速开始

#### 1. 初始化项目

```bash
cd your-project
claude
> /specbios-init
```

初始化后会创建：
- `.specbios.json` - 恢复配置中心
- `CLAUDE.md` - Claude 的恢复协议
- `.claude/specbios-session.local.md` - 短期会话交接文件
- `docs/` - 项目文档目录

#### 2. 填写核心文档

优先补这些文件：
- `docs/00-project-dossier.md` - 项目背景和关键判断
- `docs/01-architecture.md` - 架构设计
- `docs/03-scope-and-mvp.md` - 范围边界
- `docs/05-live-task-board.md` - 实时任务板

#### 3. 添加任务

```bash
> /specbios-task-add "实现用户登录"
> /specbios-task-add "添加密码重置"
> /specbios-task-add "创建用户资料页"
```

#### 4. 开始推进

```bash
> /specbios-dispatch
```

Claude 会：
1. 先读取短期 handoff（如果存在）
2. 再按恢复顺序读取任务板和核心 docs
3. 选出当前任务
4. 刷新 checkpoint
5. 开始执行任务

#### 5. 下次继续

下次重新进入项目时：
- `CLAUDE.md` 会先提供恢复协议
- SessionStart hook 会注入恢复摘要
- Claude 会优先从磁盘上的 handoff / task board 恢复，而不是依赖旧聊天记录

### 可用命令

| 命令 | 说明 |
|------|------|
| `/specbios-init` | 初始化 SpecBIOS 项目 |
| `/specbios-task-add "描述"` | 添加任务 |
| `/specbios-task-list` | 查看任务 |
| `/specbios-task-update T-001 completed` | 更新任务状态 |
| `/specbios-dispatch` | 执行当前任务 |

### 恢复工作流示例

```bash
# 第 1 天
$ cd my-app
$ claude
> /specbios-init my-app
> /specbios-task-add "搭建 Express 服务器"
> /specbios-dispatch

# 第 2 天
$ cd my-app
$ claude
# SessionStart 自动显示恢复摘要
> /specbios-dispatch

# 一周后
$ cd my-app
$ claude
> /specbios-task-list
> /specbios-dispatch
# 继续从磁盘状态恢复，而不是从旧聊天记忆恢复
```

### 内置示例项目

仓库现在包含一个正式示例项目：
- `examples/recovery-demo/`

你可以直接在这个目录里演示：
1. 进入 `examples/recovery-demo`
2. 用本插件启动 Claude Code
3. 查看 SessionStart 恢复摘要
4. 运行 `/specbios-task-list`
5. 运行 `/specbios-dispatch` 继续后续任务

### 为什么这个插件现在更重要？

因为当前增强版已经不只是“把 SpecBIOS 命令搬进 Claude Code”，而是补上了真正的恢复闭环：
- 有恢复配置中心
- 有短期 handoff
- 有 SessionStart 自动恢复摘要
- 有稳定的恢复顺序
- 有任务板机器区作为唯一任务真相

### 支持与排障

如果遇到问题，先检查：
- 插件仓库是否包含 `.claude-plugin/plugin.json`
- 当前目录是否存在 `.specbios.json`
- `docs/05-live-task-board.md` 是否仍保留机器可解析任务区
- Windows 环境下 Claude Code 是否已正确配置 Git Bash

支持渠道：
- 插件仓库: https://github.com/xuxijie888-cyber/specbios-plugin
- Issues: https://github.com/xuxijie888-cyber/specbios-plugin/issues

### 相关链接

- GitHub: https://github.com/xuxijie888-cyber/specbios
- npm: https://www.npmjs.com/package/specbios
- Issues: https://github.com/xuxijie888-cyber/specbios/issues

---

## English

### What is it?

SpecBIOS is a Claude Code plugin for long-running projects. Its main goal is to solve **context loss / project memory loss**.

When you work across multiple days or weeks, AI tools often forget:
- what you are building
- why certain decisions were made
- where the project currently stands
- what should happen next

SpecBIOS persists that state to disk through docs, a live task board, and a short-term session handoff file so Claude Code can reconstruct working context in later sessions.

### Core idea

SpecBIOS now uses a three-layer recovery model:
- **Long-term truth layer**: the `docs/` system
- **Short-term handoff layer**: `.claude/specbios-session.local.md`
- **Startup guidance layer**: `CLAUDE.md` + `SessionStart` hook

In this model:
- the machine-parseable section in `docs/05-live-task-board.md` is the only authoritative task source
- `CLAUDE.md` tells Claude how to recover context
- `.claude/specbios-session.local.md` stores the latest stop point, next step, blockers, and touched files

### Who is this for?

This plugin is a good fit if:
- you use Claude Code for long-running projects
- you do not want to re-explain the whole project every session
- you want task progress and recovery state to live on disk
- you want the workflow to stay inside Claude Code as much as possible

### Installation

```bash
# Install from GitHub
claude plugin install https://github.com/xuxijie888-cyber/specbios-plugin

# Or install from a local directory (for development)
claude plugin install /path/to/specbios-claude-plugin
```

> The plugin repo must include `.claude-plugin/plugin.json`.

### Quick Start

#### 1. Initialize a project

```bash
cd your-project
claude
> /specbios-init
```

Initialization creates:
- `.specbios.json` - recovery configuration center
- `CLAUDE.md` - Claude recovery protocol
- `.claude/specbios-session.local.md` - short-term session handoff
- `docs/` - project documentation directory

#### 2. Fill in the core docs

Start with these files:
- `docs/00-project-dossier.md` - project background and key decisions
- `docs/01-architecture.md` - architecture design
- `docs/03-scope-and-mvp.md` - scope boundaries
- `docs/05-live-task-board.md` - live task board

#### 3. Add tasks

```bash
> /specbios-task-add "Implement user login"
> /specbios-task-add "Add password reset"
> /specbios-task-add "Create user profile page"
```

#### 4. Start work

```bash
> /specbios-dispatch
```

Claude will:
1. read the short-term handoff first when available
2. read the task board and core docs in recovery order
3. select the current task
4. refresh the checkpoint
5. start executing the task

#### 5. Continue later

When you return to the project later:
- `CLAUDE.md` provides the recovery protocol
- the SessionStart hook injects a recovery summary
- Claude reconstructs context from handoff + task board + docs instead of relying on stale chat memory

### Available Commands

| Command | Description |
|---------|-------------|
| `/specbios-init` | Initialize a SpecBIOS project |
| `/specbios-task-add "description"` | Add a task |
| `/specbios-task-list` | View tasks |
| `/specbios-task-update T-001 completed` | Update a task status |
| `/specbios-dispatch` | Execute the current task |

### Recovery workflow example

```bash
# Day 1
$ cd my-app
$ claude
> /specbios-init my-app
> /specbios-task-add "Set up Express server"
> /specbios-dispatch

# Day 2
$ cd my-app
$ claude
# SessionStart automatically shows the recovery summary
> /specbios-dispatch

# A week later
$ cd my-app
$ claude
> /specbios-task-list
> /specbios-dispatch
# Resume from disk-backed state rather than old chat memory
```

### Built-in example project

The repository now includes a formal example project:
- `examples/recovery-demo/`

You can demo the workflow there by:
1. entering `examples/recovery-demo`
2. starting Claude Code with this plugin loaded
3. checking the SessionStart recovery summary
4. running `/specbios-task-list`
5. running `/specbios-dispatch` to continue the next task

### Why this plugin matters now

The enhanced plugin is no longer just “SpecBIOS commands inside Claude Code.” It now includes a real recovery loop:
- a recovery configuration center
- short-term handoff state
- SessionStart recovery summaries
- a stable recovery order
- one authoritative task truth source in the machine-parseable task board

### Support and troubleshooting

If something does not work, check:
- the plugin repository includes `.claude-plugin/plugin.json`
- the target project contains `.specbios.json`
- `docs/05-live-task-board.md` still includes the machine-parseable task section
- on Windows, Claude Code is correctly configured to use Git Bash

Support channels:
- Plugin repository: https://github.com/xuxijie888-cyber/specbios-plugin
- Issues: https://github.com/xuxijie888-cyber/specbios-plugin/issues

### Related Links

- GitHub: https://github.com/xuxijie888-cyber/specbios
- npm: https://www.npmjs.com/package/specbios
- Issues: https://github.com/xuxijie888-cyber/specbios/issues

## License

MIT
