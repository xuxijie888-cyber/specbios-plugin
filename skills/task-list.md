---
name: specbios-task-list
description: List all tasks from the SpecBIOS task board
---

# SpecBIOS Task List

Display all tasks from the project task board with their current status.

## What this does

1. Reads the task board (`docs/05-live-task-board.md`)
2. Parses all tasks from the machine-parseable section
3. Displays them in a formatted list with status indicators

## Usage

```
/specbios-task-list
```

## Implementation

1. Check if `.specbios.json` exists (error if not - suggest `/specbios-init`)
2. Read `docs/05-live-task-board.md`
3. Parse the "机器可解析任务区（权威任务源）" section
4. Extract all task lines matching pattern: `- [status] T-XXX Description`
5. Display in a formatted table:
   ```
   Total X tasks:
   
   T-001 [Completed] Task description
   T-002 [Pending] Another task
   T-003 [In Progress] Current task
   ```
6. Highlight the current `in_progress` task if one exists
7. Show summary: X completed, Y pending, Z in progress

## Output format

Use clear status indicators:
- ✓ for completed
- → for in_progress  
- ○ for pending

Example output:
```
Total 5 tasks:

  ✓ T-001 [Completed] 建立 docs 骨架
  ○ T-002 [Pending] 完善 README
  ○ T-003 [Pending] 完善认知档案
  → T-004 [In Progress] 实现登录功能
  ○ T-005 [Pending] 添加测试

Summary: 1 completed, 3 pending, 1 in progress
```
