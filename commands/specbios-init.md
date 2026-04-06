---
description: Initialize a new SpecBIOS project with recovery-oriented documentation structure
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
   - If `$ARGUMENTS` is non-empty after trimming, use it.
   - Otherwise infer a reasonable name from the current directory.
   - If that still produces an empty name, use `New Project`.
3. Before writing files, check whether `docs/`, `CLAUDE.md`, `.claude/`, or any target SpecBIOS docs already exist.
   - If SpecBIOS-style files already exist but `.specbios.json` does not, tell the user the directory looks partially initialized and ask before overwriting those files.
4. Create `.specbios.json` in the current directory with this structure:

```json
{
  "schemaVersion": 2,
  "projectName": "<project name>",
  "executor": "claude-code",
  "docsDir": "docs",
  "taskBoardFile": "docs/05-live-task-board.md",
  "handoffFile": ".claude/specbios-session.local.md",
  "recoveryReadOrder": [
    ".claude/specbios-session.local.md",
    "docs/05-live-task-board.md",
    "docs/04-roadmap-and-progress.md",
    "docs/03-scope-and-mvp.md",
    "docs/01-architecture.md",
    "docs/00-project-dossier.md",
    "docs/02-data-model-and-apis.md"
  ]
}
```

5. Create `docs/` if it does not already exist.
6. Create `.claude/` if it does not already exist.
7. Create these files with simple starter content:
   - `CLAUDE.md`
   - `.claude/specbios-session.local.md`
   - `docs/00-project-dossier.md`
   - `docs/01-architecture.md`
   - `docs/02-data-model-and-apis.md`
   - `docs/03-scope-and-mvp.md`
   - `docs/04-roadmap-and-progress.md`
   - `docs/05-live-task-board.md`
8. Use this `CLAUDE.md` starter intent:

```md
# SpecBIOS Recovery Protocol

This project uses SpecBIOS.

When recovering context:
1. Trust disk state over stale chat memory.
2. Read `.claude/specbios-session.local.md` first when it exists.
3. Treat `docs/05-live-task-board.md` machine-parseable section as the only task truth source.
4. Then read roadmap, scope, architecture, dossier, and data/API docs as needed.
```

9. Use this `.claude/specbios-session.local.md` starter template:

```md
# SpecBIOS Session Handoff

## Current task
No active task recorded yet.

## Last checkpoint
No checkpoint recorded yet.

## Next atomic step
Run `/specbios-dispatch` after updating the core docs.

## Blockers
None recorded.

## Touched files
- None yet.

## Open questions
- None.
```

10. Create `docs/05-live-task-board.md` using an exact starter shape with these requirements:
   - the section header must be `## 机器可解析任务区（权威任务源）`
   - each task line must use the format `- [pending] T-001 ...` or `- [completed] T-001 ...`
   - include at least these starter tasks:
     - `- [completed] T-001 建立 docs 骨架`
     - `- [pending] T-002 完善 README`
     - `- [pending] T-003 完善完整认知档案`
     - `- [pending] T-004 完善架构文档`
     - `- [pending] T-005 完善数据与 API 文档`
     - `- [pending] T-006 完善 MVP 范围文档`
   - keep `---` as the section terminator so later commands can parse it reliably
11. Keep file contents simple and valid markdown.
12. After creating files, briefly tell the user:
   - initialization completed
   - the recovery protocol is ready
   - edit docs first
   - then use `/specbios-task-add` and `/specbios-dispatch`

Do not overwrite unrelated files.
Do not add extra features beyond this recovery-oriented initialization set.
