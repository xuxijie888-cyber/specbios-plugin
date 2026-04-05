---
name: specbios-auto-detect
trigger: session-start
---

# SpecBIOS Auto-Detection Hook

Automatically detect if the current project uses SpecBIOS and provide helpful context.

## What this does

When Claude Code starts in a directory, this hook:
1. Checks if `.specbios.json` exists
2. If found, reads the task board
3. Shows the current project status
4. Suggests next actions

## Trigger

This hook runs automatically when:
- Claude Code session starts in a directory
- User changes to a new directory with `.specbios.json`

## Implementation

### Detection logic

1. Check if `.specbios.json` exists in current directory
2. If not found, do nothing (silent)
3. If found, proceed with context loading

### Context loading

1. Read `.specbios.json` to get project name
2. Read `docs/05-live-task-board.md`
3. Parse current task status:
   - Find any `[in_progress]` task
   - Count `[pending]` tasks
   - Count `[completed]` tasks

### User notification

Display a friendly message:

```
✓ SpecBIOS project detected: [Project Name]

Current status:
  → T-007 [In Progress] 创建一个简单的 Python 计算器程序
  
Tasks: 2 completed, 4 pending, 1 in progress

💡 Quick actions:
  • /specbios-dispatch - Continue working on current task
  • /specbios-task-list - View all tasks
  • /specbios-task-add "description" - Add a new task
```

If no task is in progress:

```
✓ SpecBIOS project detected: [Project Name]

Tasks: 2 completed, 5 pending

💡 Next steps:
  • /specbios-dispatch - Start the next pending task
  • /specbios-task-list - View all tasks
```

## Behavior notes

- This hook should be non-intrusive
- Only show notification once per session
- Don't block or require user interaction
- Provide actionable suggestions
