# SpecBIOS Recovery Protocol

This project uses SpecBIOS.

When recovering context:
1. Trust disk state over stale chat memory.
2. Read `.claude/specbios-session.local.md` first when it exists.
3. Treat `docs/05-live-task-board.md` machine-parseable section as the only task truth source.
4. Then read roadmap, scope, architecture, dossier, and data/API docs as needed.
