---
name: specbios-init
description: Initialize a new SpecBIOS project with documentation structure
---

# SpecBIOS Init

Initialize a new SpecBIOS project in the current directory.

## What this does

Creates the SpecBIOS project structure:
- `.specbios.json` - Project configuration
- `docs/` directory with documentation templates:
  - `01-architecture.md` - System architecture and design
  - `02-data-and-api.md` - Data structures and API definitions
  - `03-scope-and-mvp.md` - Project scope and MVP definition
  - `04-cognitive-profile.md` - Project context and background
  - `05-live-task-board.md` - Active task tracking board
  - `README.md` - Project overview

## Usage

```
/specbios-init
```

Or with a project name:

```
/specbios-init my-project
```

## Implementation

1. Check if `.specbios.json` already exists (warn if it does)
2. Create `.specbios.json` with default configuration:
   ```json
   {
     "projectName": "New Project",
     "template": "personal-default",
     "executor": "claude-code",
     "docsDir": "docs",
     "executors": {
       "claude-code": {
         "command": "claude",
         "args": []
       }
     },
     "autoProceed": true,
     "taskGranularity": "fine"
   }
   ```
3. Create `docs/` directory
4. Create all documentation template files with basic structure
5. Confirm initialization complete and suggest next steps

## Next steps after init

Tell the user:
1. Edit documentation files in `docs/` to define the project
2. Use `/specbios-task-add` to add tasks
3. Use `/specbios-dispatch` to start working
