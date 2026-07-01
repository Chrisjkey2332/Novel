# CLAUDE.md — Novel Workshop

This repository is a **novel-writing workshop**, not a software project. It holds one or more novel projects and the process that governs how they are developed.

## Read this first

**`NOVEL-PROCESS.md`** is the authoritative guide to everything here: the directory layout, reference-file formats (metadata, characters, world, beat sheet, plot docs), the pipeline stages (Brainstorm → Concept → Characters → World → Outline → Chapter Plans → Draft → Revision), the review cadence, the change-history and annotations conventions, and the editions/export policy. When a question about *how the workshop works* comes up, that file is the source of truth — keep it in sync with reality when practice changes.

## Layout

```
_ideas/                 Raw brainstorm notes not yet promoted to a project
valley-of-shadows/      Active novel project (see its manuscript/metadata.json)
NOVEL-PROCESS.md        The workshop process (read this)
```

Each `{novel-name}/` folder is self-contained (its own manuscript, references, reports, editions). Nothing in one project references another.

## Active projects

- **valley-of-shadows** — *A Walk in the Valley of Shadows*, gothic fantasy, first-person present, 33 chapters, status `revision`, current edition 1.3.

## Working conventions

- **Prose lives in `manuscript/chapter-XX.md`** and is first-person **present tense**. Past-tense passages are deliberate flashbacks.
- **Continuity is checked against `references/`** — character, world, and plot JSON are canonical facts; keep prose consistent with them (and update them when the story intentionally changes).
- **Reviews** go in `{novel}/reports/` (unresolved at top level, resolved in `Archive/`); **change logs** go in `{novel}/logs/`; the two are different things.
- **Editions** in `{novel}/editions/{version}/` are built deliverables (`.docx`) only — source is frozen in git, not copied into the edition. Log every edition in `editions/CHANGELOG.md`.

## Tooling (`valley-of-shadows/scripts/`)

- `export-edition.ps1 -Edition <v> [-Combined]` — build an edition's `.docx` (per-chapter + optional combined manuscript with title page/TOC), plus a metadata snapshot and word-count manifest. Requires pandoc.
- `qa-report.ps1` — fast, pandoc-free lint: word counts vs target, leftover author markers, first-person past-tense (tense/POV) leaks, and character-reference coverage. Run before a human review pass.
