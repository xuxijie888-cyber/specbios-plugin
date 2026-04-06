# SpecBIOS Claude Code Plugin

Documentation-driven AI programming orchestrator for Claude Code.

## What is SpecBIOS?

SpecBIOS solves the biggest problem in AI-assisted programming: **context loss**. When working on long-term projects, AI tools forget what you're building, why you made certain decisions, and what tasks remain.

SpecBIOS keeps your project context alive through:
- **Persistent documentation** - Architecture, scope, and design decisions stored in markdown files
- **Task tracking** - Clear task board showing what's done and what's next
- **Automatic context loading** - AI reads your docs before every task
- **Executor agnostic** - Works with any AI coding tool

## Installation

```bash
# Install from GitHub
claude plugin install https://github.com/xuxijie888-cyber/specbios-plugin

# Or install from local directory (for development)
claude plugin install /path/to/specbios-claude-plugin
```

## Quick Start

### 1. Initialize a new project

```bash
cd your-project
claude
> /specbios-init
```

This creates:
- `.specbios.json` - Project configuration
- `docs/` - Documentation directory with templates

### 2. Define your project

Edit the documentation files in `docs/`:
- `00-project-dossier.md` - Project background and key decisions
- `01-architecture.md` - How you want to structure the code
- `03-scope-and-mvp.md` - What features to build (and what to skip)
- `05-live-task-board.md` - Live task board

### 3. Add tasks

```bash
> /specbios-task-add "Implement user login"
> /specbios-task-add "Add password reset"
> /specbios-task-add "Create user profile page"
```

### 4. Start working

```bash
> /specbios-dispatch
```

Claude will:
- Read your documentation
- Understand the current task
- Write the code
- Update the task board when done

### 5. Continue with next task

```bash
> /specbios-dispatch
```

Repeat until all tasks are complete!

## Available Commands

| Command | Description |
|---------|-------------|
| `/specbios-init` | Initialize a new SpecBIOS project |
| `/specbios-task-add "description"` | Add a new task |
| `/specbios-task-list` | View all tasks |
| `/specbios-task-update T-001 completed` | Update task status |
| `/specbios-dispatch` | Execute the current task |

## Key Features

### 🎯 Documentation-Driven

Your requirements live in markdown files, not in chat history. AI reads them every time, so context never gets lost.

### 📋 Task Tracking

Clear task board shows what's done, what's in progress, and what's next. No more "what was I working on?"

### 🔄 Automatic Context Loading

When you run `/specbios-dispatch`, Claude automatically:
1. Reads your architecture docs
2. Understands your scope boundaries
3. Loads the current task
4. Starts working

### 🚀 Slash Commands Inside Claude Code

The plugin adds native `/specbios-*` commands inside Claude Code, so you can manage docs and tasks without switching back to a separate CLI flow.

## Example Workflow

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
> /specbios-task-list
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

## Why SpecBIOS?

### The Problem

Traditional AI coding tools:
- ❌ Forget context between sessions
- ❌ Lose track of what's been done
- ❌ Don't remember architectural decisions
- ❌ Require re-explaining the project constantly

### The Solution

SpecBIOS:
- ✅ Persistent documentation keeps context alive
- ✅ Task board tracks progress automatically
- ✅ Architecture docs guide every decision
- ✅ Works across sessions, days, weeks

## CLI Tool

This plugin works alongside the SpecBIOS CLI tool for advanced features:
- Dependency analysis
- Executor recommendation
- AI-powered task splitting

Install the CLI:
```bash
npm install -g specbios
```

Learn more: https://github.com/xuxijie888-cyber/specbios

## License

MIT

## Links

- GitHub: https://github.com/xuxijie888-cyber/specbios
- npm: https://www.npmjs.com/package/specbios
- Issues: https://github.com/xuxijie888-cyber/specbios/issues
