#!/usr/bin/env bash

set -euo pipefail

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
config_path="$project_dir/.specbios.json"

if [ ! -f "$config_path" ]; then
  exit 0
fi

CLAUDE_PROJECT_DIR="$project_dir" python - <<'PY'
import json
import os
import re
from pathlib import Path

project_dir = Path(os.environ["CLAUDE_PROJECT_DIR"])
config_path = project_dir / ".specbios.json"

with config_path.open("r", encoding="utf-8") as f:
    config = json.load(f)

project_name = config.get("projectName") or project_dir.name or "Unnamed SpecBIOS Project"
task_board_rel = config.get("taskBoardFile") or "docs/05-live-task-board.md"
handoff_rel = config.get("handoffFile") or ".claude/specbios-session.local.md"
recovery_order = config.get("recoveryReadOrder") or [
    ".claude/specbios-session.local.md",
    "docs/05-live-task-board.md",
    "docs/04-roadmap-and-progress.md",
    "docs/03-scope-and-mvp.md",
    "docs/01-architecture.md",
    "docs/00-project-dossier.md",
    "docs/02-data-model-and-apis.md",
]

task_board_path = project_dir / task_board_rel
handoff_path = project_dir / handoff_rel


def read_section(path: Path, header: str) -> str:
    if not path.exists():
        return ""
    target = header.strip().lower()
    capture = False
    collected = []
    with path.open("r", encoding="utf-8") as f:
        for raw in f:
            line = raw.rstrip("\n")
            stripped = line.strip()
            if stripped.startswith("## "):
                current = stripped[3:].strip().lower()
                if capture and current != target:
                    break
                capture = current == target
                continue
            if capture:
                collected.append(line)
    return "\n".join(collected).strip()


def read_current_task_from_board(path: Path) -> str:
    if not path.exists():
        return ""
    pattern = re.compile(r"^- \[(pending|in_progress|completed)\]\s+(T-\d{3})\s+(.+)$")
    in_section = False
    first_pending = ""
    with path.open("r", encoding="utf-8") as f:
        for raw in f:
            line = raw.rstrip("\n")
            stripped = line.strip()
            if stripped == "## 机器可解析任务区（权威任务源）":
                in_section = True
                continue
            if in_section and stripped == "---":
                break
            if not in_section:
                continue
            match = pattern.match(stripped)
            if not match:
                continue
            status, task_id, title = match.groups()
            rendered = f"{task_id} {title}"
            if status == "in_progress":
                return rendered
            if status == "pending" and not first_pending:
                first_pending = rendered
    return first_pending


current_task = read_section(handoff_path, "Current task")
last_checkpoint = read_section(handoff_path, "Last checkpoint")
next_step = read_section(handoff_path, "Next atomic step")
blockers = read_section(handoff_path, "Blockers")
summary_source = "handoff"

if not any([current_task, last_checkpoint, next_step, blockers]):
    summary_source = "task board"
    current_task = read_current_task_from_board(task_board_path)

if not current_task:
    current_task = "No active task found."
if not last_checkpoint:
    last_checkpoint = "No checkpoint recorded yet."
if not next_step:
    next_step = "Run /specbios-dispatch to refresh the working context."
if not blockers:
    blockers = "None recorded."

recovery_lines = "\n".join(f"- {item}" for item in recovery_order)
context = (
    f"SpecBIOS project detected: {project_name}\n\n"
    f"Recovery summary (source: {summary_source}):\n"
    f"- Current task: {current_task}\n"
    f"- Last checkpoint: {last_checkpoint}\n"
    f"- Next step: {next_step}\n"
    f"- Blockers: {blockers}\n\n"
    f"Recovery order:\n{recovery_lines}\n\n"
    f"When continuing work, trust disk state over stale chat memory and treat the machine-parseable task section in {task_board_rel} as the only task truth source."
)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": context,
    }
}))
PY
