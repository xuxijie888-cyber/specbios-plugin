---
name: specbios-task-update
description: Update the status of a task in the SpecBIOS task board
---

# SpecBIOS Task Update

Update the status of an existing task.

## What this does

1. Reads the task board
2. Finds the specified task
3. Updates its status
4. Saves the changes

## Usage

```
/specbios-task-update T-001 completed
```

Or:
```
/specbios-task-update T-002 in_progress
```

## Valid status values

- `pending` - Task not started yet
- `in_progress` - Currently working on this task
- `completed` - Task finished

## Implementation

1. Check if `.specbios.json` exists (error if not)
2. Parse the task ID and new status from the command
3. Read `docs/05-live-task-board.md`
4. Find the task line matching the task ID
5. Validate the new status is valid
6. If setting to `in_progress`, check if another task is already in_progress (warn user)
7. Update the task status in the format: `- [new_status] T-XXX Description`
8. Save the updated task board
9. Confirm the update

## Important rules

- Only ONE task should be `in_progress` at a time
- If setting a task to `in_progress` while another is already in progress, warn the user and ask for confirmation
- Task IDs are case-sensitive (T-001, not t-001)

## Example

Before:
```
- [pending] T-005 Add user authentication
```

After running `/specbios-task-update T-005 in_progress`:
```
- [in_progress] T-005 Add user authentication
```
