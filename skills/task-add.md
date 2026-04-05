---
name: specbios-task-add
description: Add a new task to the SpecBIOS task board
---

# SpecBIOS Task Add

Add a new task to the project task board.

## What this does

1. Reads the current task board (`docs/05-live-task-board.md`)
2. Generates a new task ID (e.g., T-008)
3. Adds the task to the machine-parseable task section
4. Updates the task board file

## Usage

```
/specbios-task-add "Task description"
```

Example:
```
/specbios-task-add "Implement user authentication"
```

## Implementation

1. Check if `.specbios.json` exists (error if not - suggest `/specbios-init`)
2. Read `docs/05-live-task-board.md`
3. Parse existing tasks to find the highest task number
4. Create new task ID (increment by 1)
5. Add new task line in format: `- [pending] T-XXX Task description`
6. Insert into the "机器可解析任务区" section
7. Save the updated task board
8. Confirm task added with the new task ID

## Task format

Tasks follow this format in the task board:
```
- [pending] T-001 Task description
- [in_progress] T-002 Another task
- [completed] T-003 Finished task
```

Status values: `pending`, `in_progress`, `completed`
