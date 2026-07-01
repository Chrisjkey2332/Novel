# Editions — Changelog

Milestone snapshots of *A Walk in the Valley of Shadows*, newest first. Each edition is built from `manuscript/` by `scripts/export-edition.ps1`. Editions hold deliverables (`.docx`) only; the exact source for each is frozen in git at the export commit noted below. See `NOVEL-PROCESS.md > Editions`.

## 1.3 — 2026-05-21

- **Driven by:** the trial-arc restructure (`logs/trial-expansion-2026-05-19.md`) and a reader-feedback round.
- **Changes since 1.2:**
  - Trial expanded from a single chapter into a multi-day proceeding — chapter count 30 → 33 (`492e499`). Trial-arc word count grew ~6,200 → ~17,100.
  - Added a vampire-duration ("memory") beat to Ch. 11 (`2d62663`).
  - Four of seven documented loose ends absorbed into trial testimony.
- **Build:** all 33 chapters exported to `.docx` (`4369b65`).
- **Source commit:** `4369b65`.

## 1.2 — 2026-05-18

- **Driven by:** the pre-edition-1.2 read-through review — continuity, quality, and pacing (`bc41f00`; reports archived under `reports/Archive/continuity-quality-2026-05-18.md`, `pacing-2026-05-18.md`).
- **Changes since 1.1:**
  - Read-through fixes applied across the manuscript.
  - All chapters promoted to finalized; project `status` → `revision` (`8255b1e`).
  - Export tooling hardened: paragraph-break preprocessing (`e57b1e7`), visible/centered `* * *` scene breaks via pandoc lua filter (`cc8204f`, `6f87bdd`), reference-doc styling (`d38f0d8`, `3a1306d`).
- **Source commit:** `cc1481d` (with subsequent re-exports `d38f0d8`, `3a1306d`).

## 1.1 — 2026-02-17

- **Driven by:** the comprehensive evaluation and the uncertainty/opportunities pass (`reports/Archive/comprehensive-evaluation-2026-02-13.md`, `uncertainty-opportunities-2026-02-17.md`).
- **Changes since 1.0:**
  - 650+ targeted edits across all 30 chapters (`f53f3da`).
  - 88 uncertainty/ambiguity edits across all chapters (`d0a23d8`).
  - Read-through fixes and a trial restructure for Ch. 30; Archbishop reintroduced as a delayed reveal (`081a7e1`, `3b837d2`, `96e6ae7`).
- **Build:** edition 1.1 `.docx` added (`1c9ec8b`).
- **Source commit:** `1c9ec8b`.

## 1.0 — 2026-02-16

- **First published edition.** Initial editorial revision pass over the 30-chapter draft (`0ca9e0b`).
- **Source commit:** `0ca9e0b`.
