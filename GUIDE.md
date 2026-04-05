# SpecBIOS Claude Code Plugin - 使用指南

[English](#english) | [中文](#chinese)

<a name="chinese"></a>
## 中文指南

### 什么是 SpecBIOS？

SpecBIOS 解决了 AI 辅助编程的最大痛点：**上下文丢失**。

当你做长期项目时，AI 工具会忘记：
- 你在构建什么
- 为什么做某些设计决策
- 还有哪些任务要做

SpecBIOS 通过以下方式保持项目上下文：
- **持久化文档** - 架构、范围、设计决策都存储在 markdown 文件中
- **任务追踪** - 清晰的任务板显示已完成和待完成的任务
- **自动加载上下文** - AI 在每个任务前都会读取你的文档
- **执行器无关** - 可以配合任何 AI 编程工具使用

### 安装

```bash
# 从 GitHub 安装
claude plugin install https://github.com/xuxijie888-cyber/specbios-plugin

# 或从本地目录安装（用于开发）
claude plugin install /path/to/specbios-claude-plugin
```

### 快速开始

#### 1. 初始化新项目

```bash
cd your-project
claude
> /specbios-init
```

这会创建：
- `.specbios.json` - 项目配置
- `docs/` - 文档目录及模板

#### 2. 定义你的项目

编辑 `docs/` 中的文档文件：
- `01-architecture.md` - 代码结构设计
- `03-scope-and-mvp.md` - 要构建的功能（以及不做什么）
- `04-cognitive-profile.md` - 项目背景和上下文

#### 3. 添加任务

```bash
> /specbios-task-add "实现用户登录"
> /specbios-task-add "添加密码重置"
> /specbios-task-add "创建用户资料页"
```

#### 4. 开始工作

```bash
> /specbios-dispatch
```

Claude 会：
- 读取你的文档
- 理解当前任务
- 编写代码
- 完成后更新任务板

#### 5. 继续下一个任务

```bash
> /specbios-dispatch
```

重复直到所有任务完成！

### 可用命令

| 命令 | 说明 |
|------|------|
| `/specbios-init` | 初始化新的 SpecBIOS 项目 |
| `/specbios-task-add "描述"` | 添加新任务 |
| `/specbios-task-list` | 查看所有任务 |
| `/specbios-task-update T-001 completed` | 更新任务状态 |
| `/specbios-dispatch` | 执行当前任务 |

### 实际使用示例

```bash
# 第 1 天：开始新项目
$ cd my-app
$ claude
> /specbios-init my-app
> [编辑 docs/01-architecture.md 定义结构]
> /specbios-task-add "搭建 Express 服务器"
> /specbios-task-add "添加数据库连接"
> /specbios-dispatch
# Claude 构建 Express 服务器

# 第 2 天：从上次中断的地方继续
$ cd my-app
$ claude
# ✓ 检测到 SpecBIOS 项目
# → T-002 [进行中] 添加数据库连接
> /specbios-dispatch
# Claude 读取文档并继续工作

# 一周后：仍然记得所有内容
$ cd my-app
$ claude
> /specbios-task-list
# 显示所有已完成和待完成的任务
> /specbios-dispatch
# 准确地从上次停下的地方继续
```

---

<a name="english"></a>
## English Guide

### What is SpecBIOS?

SpecBIOS solves the biggest problem in AI-assisted programming: **context loss**.

When working on long-term projects, AI tools forget:
- What you're building
- Why you made certain design decisions
- What tasks remain

SpecBIOS keeps your project context alive through:
- **Persistent documentation** - Architecture, scope, and design decisions stored in markdown files
- **Task tracking** - Clear task board showing what's done and what's next
- **Automatic context loading** - AI reads your docs before every task
- **Executor agnostic** - Works with any AI coding tool

### Installation

```bash
# Install from GitHub
claude plugin install https://github.com/xuxijie888-cyber/specbios-plugin

# Or install from local directory (for development)
claude plugin install /path/to/specbios-claude-plugin
```

### Quick Start

#### 1. Initialize a new project

```bash
cd your-project
claude
> /specbios-init
```

This creates:
- `.specbios.json` - Project configuration
- `docs/` - Documentation directory with templates

#### 2. Define your project

Edit the documentation files in `docs/`:
- `01-architecture.md` - How you want to structure the code
- `03-scope-and-mvp.md` - What features to build (and what to skip)
- `04-cognitive-profile.md` - Project background and context

#### 3. Add tasks

```bash
> /specbios-task-add "Implement user login"
> /specbios-task-add "Add password reset"
> /specbios-task-add "Create user profile page"
```

#### 4. Start working

```bash
> /specbios-dispatch
```

Claude will:
- Read your documentation
- Understand the current task
- Write the code
- Update the task board when done

#### 5. Continue with next task

```bash
> /specbios-dispatch
```

Repeat until all tasks are complete!

### Available Commands

| Command | Description |
|---------|-------------|
| `/specbios-init` | Initialize a new SpecBIOS project |
| `/specbios-task-add "description"` | Add a new task |
| `/specbios-task-list` | View all tasks |
| `/specbios-task-update T-001 completed` | Update task status |
| `/specbios-dispatch` | Execute the current task |

### Example Workflow

```bash
# Day 1: Start a new project
$ cd my-app
$ claude
> /specbios-init my-app
> [Edit docs/01-architecture.md to define structure]
> /specbios-task-add "Setup Express server"
> /specbios-task-add "Add database connection"
> /specbios-dispatch
# Claude builds the Express server

# Day 2: Continue where you left off
$ cd my-app
$ claude
# ✓ SpecBIOS project detected
# → T-002 [In Progress] Add database connection
> /specbios-dispatch
# Claude reads the docs and continues working

# Week later: Still remembers everything
$ cd my-app
$ claude
> /specbios-task-list
# Shows all completed and pending tasks
> /specbios-dispatch
# Picks up exactly where you left off
```

## Links

- GitHub: https://github.com/xuxijie888-cyber/specbios
- npm (CLI tool): https://www.npmjs.com/package/specbios
- Issues: https://github.com/xuxijie888-cyber/specbios/issues

## License

MIT
