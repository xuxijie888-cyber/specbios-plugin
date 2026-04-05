---
name: specbios-dispatch
description: Dispatch and execute the current task from the SpecBIOS task board
---

# SpecBIOS Dispatch

Automatically read the current task from the task board and begin working on it.

## What this does

This is the core workflow command that:
1. Reads the task board to find the current `in_progress` task
2. Loads all relevant context documents
3. Understands the task requirements
4. Executes the task
5. Updates the task status when complete

## Usage

```
/specbios-dispatch
```

Or to dispatch a specific task:
```
/specbios-dispatch T-005
```

## Implementation

### Step 1: Load project context

1. Check if `.specbios.json` exists (error if not)
2. Read `.specbios.json` to understand project configuration
3. Read `docs/05-live-task-board.md`

### Step 2: Identify the task

- If no task ID specified: find the task marked `[in_progress]`
- If no `in_progress` task exists: find the first `[pending]` task and mark it as `in_progress`
- If task ID specified: find that specific task and mark it as `in_progress`

### Step 3: Load context documents

Read the following documents in order:
1. `docs/04-cognitive-profile.md` - Project background and context
2. `docs/01-architecture.md` - Architecture and design principles
3. `docs/03-scope-and-mvp.md` - Scope boundaries and MVP definition
4. `docs/02-data-and-api.md` - Data structures and APIs (if relevant)

### Step 4: Execute the task

- Understand the task description
- Follow the architecture and scope constraints
- Write code, create files, or make changes as needed
- Test the implementation if applicable
- **Do not add features beyond the task description**
- **Stay within the MVP scope defined in the docs**

### Step 5: Complete the task

1. Update the task status from `[in_progress]` to `[completed]` in the task board
2. Update the "当前已完成" section with a brief summary
3. Inform the user the task is complete
4. Suggest running `/specbios-dispatch` again for the next task

## Important principles

- **Documentation-driven**: Always respect the constraints in the architecture and scope docs
- **Focused execution**: Only do what the task asks, no extra features
- **Automatic updates**: Update the task board automatically when done
- **Context preservation**: All work is guided by the persistent documentation
