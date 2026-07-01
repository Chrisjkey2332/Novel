# Trial Expansion Report

**Valley of Shadows — Structural Restructure**
**Date:** May 19, 2026
**Scope:** Ch. 30 → Ch. 30, 31, 32, 33
**Context:** The author elected to expand the trial from a single chapter into a multi-day proceeding to (1) allow ongoing degradation of Elijah during the trial proper (not just leading up to it), (2) develop a new character affect — *restrained interior fury* — beneath Elijah's discipline, and (3) naturally absorb four loose ends previously documented in `Archive/loose-ends-2026-05-19.md`.

This is the single largest creative restructure since drafting. Chapter count moves from 30 to 33. Total trial-arc word count grows from ~6,200 to ~17,100 (a +10,900 expansion).

---

## What Changed

### New Chapters

| Chapter | Title | Words | Function |
|---|---:|---:|---|
| Ch. 30 | The First Day | 4,880 | Cordelia's opening statement. Archbishop reveal. Elijah removed mid-arc for records-office summons. Cordelia recognizes the trial is not one day. |
| Ch. 31 | The Witness | 4,704 | Elijah testifies. Names the trappers, garrison commander, writ-signer. Metal fragment placed on table. Church refuses to receive evidence. Night-cell visit where the affect-beneath is recognized between them without being spoken. |
| Ch. 32 | The Clarification | 4,061 | Procedural humiliation via Marcellus's contestation. Archbishop speaks to Elijah directly for the first time — the offer to retract dressed as compassion. Elijah's softest refusal. Seraine's Section 12 petition placed on the record; Cordelia declines and describes the regulations on the record. |
| Ch. 33 | The Verdict | 3,449 | Compact delegates state concurrences with notations exceeding the verdict's scope. Marcellus's edited summary omits everything Elijah and Cordelia placed in the record. Archbishop delivers verdict (not shown). Closing image preserved verbatim: rook, Archbishop's awareness, "still hands and what remains." |

### Loose Ends Absorbed

Four of seven loose ends from `Archive/loose-ends-2026-05-19.md` are now closed in the manuscript via trial testimony rather than via single-sentence patches:

| # | Loose end | Where it lands now |
|---|---|---|
| **#1** | Garrison commander Sera named | Ch. 31, Elijah's testimony: *"A garrison commander. Captain Brennan of the Queen's Fourth, stationed at the river fort east of the Compact line."* |
| **#3** | The trappers' "names I will never know" vow | Ch. 31, Elijah's testimony: *"Two trappers in the Ashwood Vale. Names I do not know, and no one in this chamber will inquire after them."* |
| **#5** | The writ-signer's office above the garrison commander | Ch. 31, Elijah's testimony: *"…an office, I believe, above the garrison commander's…I include the absence of the proof as record."* |
| **#6** | The "policies" being formalized at Ch. 1 council | Ch. 32, Cordelia's response to Seraine's Section 12 petition: *"The regulations governed feeding. They specified the permitted quantities, the permitted intervals, the permitted populations…"* |

### Loose Ends Still Open

| # | Loose end | Status |
|---|---|---|
| #2 | James / Samuel / Peter individual closure | Not absorbed. Could fit in Ch. 33's "Everything" catalogue or Ch. 23 staying-choice. |
| #4 | Cordelia's biological family beyond Seraine | Not absorbed. Reference-doc closure recommended. |
| #7 | Compact Section 9 vs 12 collision | Partially mitigated by Ch. 32's explicit invocation. Reference-doc closure recommended. |

---

## New Affect: "Restrained Interior Fury"

Elijah's anger is held *beneath* the discipline, never breaking it. The composure still holds; its foundation shifts from faith-in-process to moral certainty. Visible only in:

- **Precision of diction** — Elijah's voice becomes more *clipped at its edges*, more exact.
- **The repetition tactic** — Elijah repeats his own testimony verbatim when the records office tries to make him soften it.
- **The eyes as indicator** — surface (jaw, posture, cadence) unchanged; eyes carry the new freight, visible at close lamp-light distance.
- **The softness of refusals** — Elijah's refusal to the Archbishop is *softer* than the Archbishop's offer. Softness as fury's most refined form.
- **The "door/room" metaphor** — Cordelia and Elijah develop a shared vocabulary: *the door holds the room*. The affect remains nameable only by its shape.

The words *anger*, *fury*, *rage* are never spoken between them or by the narrator.

---

## Reference Files Updated

- `manuscript/metadata.json`: chapterCount 30 → 33, Part Three "23-33", finalizedChapters "1-33", currentEdition "1.3", updatedUtc 2026-05-19
- `references/plot/beat-sheet.json`: Beat 10 chapters "29-33", description rewritten to cover the multi-day arc
- `references/characters/the archbishop.json`: rewritten with expanded screenTime and arc
- `references/characters/cardinal marcellus.json`: **new file** — Marcellus's expanded antagonist role

## Edition 1.3 Exported

All 33 chapters re-exported via `scripts/export-edition.ps1 -Edition 1.3`. Reference doc: `editions/1.2/chapter-01.docx`. Total size ~1.2 MB.

---

## Verification Performed

- **Timeline:** Cell-stay references updated — Ch. 31 "Nineteen days now", Ch. 32 "twenty days", Ch. 33 "twenty days of grey" / "twenty days" in the Cordelia-instrument reflection.
- **Loose-end keywords verified** in Ch. 31-32: Brennan, trappers, writ, regulations all present at the chapters claimed.
- **Closing image:** Ch. 33 ends verbatim with *"I hold the face as I hold everything: with still hands, and with what remains."*
- **Quote normalization:** All four new chapters converted to curly quotes; counts balanced.
- **Edition 1.3 export:** All 33 chapters compiled successfully via the script.

## Open Questions Deferred

- **Ch. 29 anticipation language.** Elijah's description in Ch. 29 of the upcoming trial expects a routine single-day proceeding. The Archbishop's choice to preside disrupts this on Day 1 — which is the structural point. **No Ch. 29 edits made.** If the author wants foreknowledge of a multi-day shape, one or two sentences could be added; otherwise the surprise is intentional.
- **Loose end #2.** Still un-addressed in the manuscript. Author decision.

## Post-Expansion Edits

- **2026-05-21: Ch. 11 vampire-duration memory.** Reader-feedback round closed with a three-sentence interior memory inserted between the spoken parallel-corruption arc (Ch. 11 line 53) and Elijah's stop (line 54). Concretizes the "humans were temporary" ideological line into a specific vignette — an elder at the long table who could no longer recall which of three generations of servants had been the grandfather, and Cordelia's complicity in laughing. Line 59's general confession ("I laughed at those jokes too, for longer than I want to admit") left intact; the new vignette gives it a specific anchor without restating its weight. Edition 1.3 re-exported.

---

## Recommended Next Steps

1. **Read Ch. 30→33 as a single arc** — confirm rhythm, voice continuity, affect consistency.
2. **Read Ch. 29→30 transition** — verify "I wait for morning" → "The morning bell" flows cleanly.
3. **Decide on Ch. 29 anticipation edit** — leave as-is, or signal the multi-day shape.
4. **Open Ch. 30-33 in `editions/1.3/`** in Word — confirm typography, paragraphs, section breaks render correctly.
