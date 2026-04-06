---
description: Initialize a new SpecBIOS project with documentation structure
argument-hint: [project-name]
allowed-tools: [Read, Write, Bash]
---

# /specbios-init

Initialize a new SpecBIOS project in the current directory.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

When this command is invoked:

1. If `.specbios.json` already exists, tell the user the project is already initialized and stop.
2. Determine the project name:
   - If `$ARGUMENTS` is non-empty, use it as project name.
   - Otherwise infer a reasonable name from the current directory.
3. Create `.specbios.json` in the current directory with this structure:

```json
{
  "projectName": "<project name>",
  "template": "personal-default",
  "executor": "claude-code",
  "docsDir": "docs",
  "autoProceed": true,
  "taskGranularity": "fine"
}
```

4. Create `docs/` directory files with minimal starter content:
   - `docs/00-project-dossier.md`
   - `docs/01-architecture.md`
   - `docs/02-data-model-and-apis.md`
   - `docs/03-scope-and-mvp.md`
   - `docs/04-roadmap-and-progress.md`
   - `docs/05-live-task-board.md`
5. In `docs/05-live-task-board.md`, create an initial machine-parseable section with:
   - `T-001 建立 docs 骨架` marked completed
   - `T-002 完善 README` marked pending
   - `T-003 完善完整认知档案` marked pending
   - `T-004 完善架构文档` marked pending
   - `T-005 完善数据与 API 文档` marked pending
   - `T-006 完善 MVP 范围文档` marked pending
6. Keep file contents simple and valid markdown.
7. After creating files, briefly tell the user:
   - initialization completed
   - edit docs first
   - then use `/specbios-task-add` and `/specbios-dispatch`

Do not add extra features or extra files beyond this initialization set.
