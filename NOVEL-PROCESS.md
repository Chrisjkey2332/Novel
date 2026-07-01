# Novel Workshop Process

This document defines the collaborative workflow for brainstorming, developing, and drafting novels.

The workshop is designed to hold **any number of novel projects in parallel**. Each project lives in its own folder under `Novel/` and follows the same internal layout, so multiple manuscripts can be drafted, revised, and reviewed simultaneously without crossing wires. Regular quality and continuity reviews run on a defined cadence (see [Regular Reviews](#regular-reviews)) to keep each manuscript consistent with itself and entertaining to read.

## Directory Structure

```
Novel/
├── _ideas/                          # Raw brainstorm notes, not yet a full project
│   ├── {idea-name}.md
│   └── ...
│
├── {novel-name}/                    # One folder per novel project
│   ├── manuscript/
│   │   ├── metadata.json            # Title, genre, POV, tense, tone, status
│   │   ├── chapter-01.md            # Chapter prose
│   │   ├── chapter-02.md
│   │   └── ...
│   ├── references/
│   │   ├── characters/              # One JSON file per character
│   │   │   ├── {character-name}.json
│   │   │   └── ...
│   │   ├── plot/
│   │   │   ├── beat-sheet.json      # Major story beats with premise
│   │   │   └── (additional plot docs)
│   │   └── world/
│   │       ├── {topic}.json         # One JSON file per world concept
│   │       └── ...
│   ├── annotations/                 # Inline notes, editorial marks
│   ├── logs/                        # Pipeline and process logs
│   ├── reports/                     # Quality and continuity reviews (latest at top level, resolved ones in Archive/)
│   └── editions/                    # Milestone snapshots (1.0/, 1.1/, ...) of the manuscript for export
│
├── {another-novel}/                 # Additional projects use the same layout
│   └── ...
│
└── NOVEL-PROCESS.md                 # This file
```

**Project independence.** Each `{novel-name}/` folder is self-contained: its own metadata, characters, world, beat sheet, and reports. Nothing inside one project should reference another project's files. This keeps parallel work safe — a revision pass on one manuscript cannot accidentally affect another.

## Reference File Formats

### metadata.json

```json
{
  "title": "Novel Title",
  "author": "Author Name",
  "subtitle": "Optional back-cover subtitle / tagline",
  "genre": "Genre",
  "pov": "First Person (Name) / Third Limited / etc.",
  "tense": "Past / Present",
  "tone": "Description of tone",
  "audience": "adult / young adult",
  "targetWordsPerChapter": 4000,
  "chapterCount": 33,
  "parts": [
    { "name": "Part One: The Valley", "chapters": "1-8" },
    { "name": "Part Two: The Road", "chapters": "9-22" }
  ],
  "status": "brainstorm / planning / initialDraft / revision / complete / shelved",
  "finalizedChapters": "1-33",
  "currentEdition": "1.3",
  "createdUtc": "ISO date",
  "updatedUtc": "ISO date"
}
```

Required fields: `title`, `genre`, `pov`, `tense`, `tone`, `audience`, `status`, `createdUtc`, `updatedUtc`. The rest are optional and appear once the project has them: `author` and `subtitle` (from Concept), `targetWordsPerChapter` (from Chapter Plans), `chapterCount` / `parts` (once structure is set), and `finalizedChapters` / `currentEdition` (once drafting and editions begin). `status` is `complete` or `shelved` for inactive projects; anything else marks the project active (see [Regular Reviews](#regular-reviews)).

### Character JSON

```json
{
  "name": "Character Name",
  "role": "Protagonist / Antagonist / Supporting",
  "description": "Physical and personality summary",
  "backstory": "Relevant history",
  "motivation": "What they want and why",
  "arc": "How they change across the story",
  "traits": ["trait1", "trait2"],
  "relationships": {
    "Other Character": "Nature of relationship"
  }
}
```

### World JSON

```json
{
  "topic": "World Element Name",
  "description": "What this element is",
  "rules": "How it works, constraints",
  "details": {
    "Key": "Value pairs for specific details"
  }
}
```

### Beat Sheet JSON

```json
{
  "premise": "Full story premise in one paragraph",
  "beats": [
    {
      "order": 1,
      "title": "Beat Title",
      "description": "What happens in this story beat",
      "characters": ["Character1", "Character2"],
      "tension": "What drives this beat forward"
    }
  ]
}
```

### Supplementary Plot Docs (optional)

Beyond the beat sheet, a project may keep focused plot docs under `references/plot/` when a particular arc or motif is load-bearing enough to track on its own. These are optional and free-form, but two patterns have proven useful:

**Arc-tracker JSON** — tracks a single recurring dramatic device across chapters (e.g. a character's escalating persuasion attempts). Because execution drifts from the outline, include an `outlineDriftNote` recording where the manuscript diverged and an explicit statement of which is canonical.

```json
{
  "topic": "The Five Attempts",
  "description": "What this arc is and how it functions",
  "attempts": [
    {
      "number": 1,
      "chapter": 9,
      "type": "Short label",
      "form": "How it is rendered in prose",
      "subtext": "What it really reveals"
    }
  ],
  "thematicFunction": "What the arc accomplishes overall",
  "outlineDriftNote": "Where the manuscript diverges from the original plan; the manuscript is canonical."
}
```

**Thematic-throughlines JSON** — names the themes and tracks how each is expressed across the book, so setups and payoffs can be checked during read-through review.

```json
{
  "topic": "Thematic Throughlines",
  "themes": [
    {
      "name": "Theme name",
      "description": "The question the theme explores",
      "examples": ["Where and how it surfaces in the manuscript"],
      "resolution": "How (or whether) the story resolves it"
    }
  ]
}
```

## Pipeline Stages

### 1. Brainstorm

Free-form exploration. No commitment, no wrong answers.

- What-if scenarios, genre mashups, themes worth exploring
- Output: `_ideas/{idea-name}.md`
- An idea file can be as short as a paragraph or as long as needed
- When an idea has enough momentum, promote it to a full project folder

### 2. Concept

Lock down what this novel IS before building it out.

- **Premise**: The core situation/conflict in one or two sentences
- **Genre & Tone**: What shelf does this live on? What does it feel like to read?
- **Themes**: What deeper questions does this story explore?
- **Hook**: What makes this compelling? Why this story?
- **Elevator Pitch**: 2-3 paragraph summary you'd put on the back cover
- Output: `{novel}/manuscript/metadata.json`

### 3. Characters

Build the cast who will carry the story. One JSON file per character.

For each major character:
- **Name & Role**: Who are they in the story?
- **Description**: Physical appearance, personality summary
- **Backstory**: Relevant history, formative experiences
- **Motivation**: What do they want? What do they need (if different)?
- **Arc**: How do they change from beginning to end?
- **Traits**: List of defining characteristics
- **Relationships**: How they connect to other characters

Output: `{novel}/references/characters/{name}.json`

### 4. World

Define the stage where the story plays out. One JSON file per concept.

- **Settings**: Major locations with atmosphere and rules
- **Systems**: Magic, politics, economy, social structures
- **History**: Relevant backstory that shapes the present
- **Symbolism**: Recurring motifs, environmental themes
- Only build what the story needs - avoid world-building for its own sake
- Output: `{novel}/references/world/{topic}.json`

### 5. Outline (Beat Sheet)

Structure the full story arc as major beats.

- Each beat covers one or more chapters
- Beats are higher-level story movements, not chapter summaries
- Include characters present and the tension driving each beat
- A full premise paragraph anchors the beat sheet
- Output: `{novel}/references/plot/beat-sheet.json`

### 6. Chapter Plans

Scene-level planning before drafting. Plans keep a chapter honest to the beat sheet before a word of prose is written.

**Where the plan lives is a project choice.** Two conventions are both valid:

- **External plan (default for this workshop).** The chapter's plan is held in `references/plot/` — the beat sheet's per-beat `chapters`/`description` fields plus any [supplementary plot docs](#supplementary-plot-docs-optional) — and the manuscript file contains prose only. This keeps the finished `chapter-XX.md` clean for export and is how *A Walk in the Valley of Shadows* is structured (chapter files open directly on the title and prose).
- **Inline plan.** The chapter file opens with a `## Plan` section above a `## Draft` section, and the plan is stripped or ignored at export time.

If using the inline form, this is the shape:

```markdown
# Chapter X: Title

## Plan
- **POV**: Whose perspective
- **Goal**: What this chapter accomplishes for the story
- **Scenes**:
  1. Scene description, location, characters present
  2. ...
- **Ends with**: The hook or transition into next chapter

---

## Draft

(Prose goes here)
```

Whichever form is used, every drafted chapter must be traceable to a beat: if a chapter has no home in `beat-sheet.json`, update the beat sheet (see Stage 7).

### 7. Draft

Write the actual prose.

- Work from the chapter plan but let the writing breathe
- First drafts prioritize momentum over polish
- Flag issues inline with `[TODO: ...]` rather than stopping to fix
- It's okay for chapters to grow or split during drafting
- Update the beat sheet if the story diverges from the plan

### 8. Revision

Improve what's been written.

- **Pass 1 - Structure**: Does the story work? Pacing, arcs, plot holes
- **Pass 2 - Scenes**: Does each scene earn its place? Tension, clarity
- **Pass 3 - Prose**: Language, dialogue, voice, rhythm
- **Pass 4 - Polish**: Continuity, typos, formatting
- Track findings in `{novel}/reports/quality-analysis.md`

## Working Together

### Starting a conversation

- **Brainstorm**: "Let's brainstorm [genre/theme] ideas"
- **Develop**: "Let's work on [novel-name] - I want to develop the characters"
- **Draft**: "Draft chapter X of [novel-name] based on the plan"
- **Review**: "This scene feels [flat/rushed/confusing] - help me fix it"
- **Explore**: "What if [character] actually [alternative]?"

### Promoting an idea to a project

When a brainstorm idea is ready to become a real project:

1. Choose a working title (can change later) — kebab-case for the folder name
2. Create the project folder with full directory structure
3. Fill in `metadata.json` with basic info
4. Proceed through the pipeline stages in order (but revisiting is fine)

Projects do not compete for shared resources — characters, beats, and world docs are scoped to a single project — so a new manuscript can be started at any time without disturbing existing work in progress. Pick the project to work on by naming it: "let's work on `{novel-name}`".

## Regular Reviews

Reviews are how the manuscript stays consistent (no contradictions) and entertaining (no flat passages, no overused phrasings). They are not one-shot events at the end of the draft — they run on a cadence as the manuscript grows.

### Review types

There are three **core** review types (below) plus **focused** reports that zoom in on a single concern. Keep scopes separate by default — a continuity review and a quality review are easier to act on and archive independently. But a combined report is acceptable when a single pass genuinely covers multiple scopes at once (e.g. a pre-edition read-through that examines continuity *and* prose health together); when combining, say so in the report header and name the file for the combined scope (e.g. `continuity-quality-2026-05-18.md`).

**Continuity review** — story-internal consistency.
- Timeline coherence (does elapsed time add up across chapters?)
- Character facts (age, gender, appearance, history — match the character JSON?)
- World rules (do magic/politics/physiology stay consistent with `references/world/`?)
- Object and location continuity (a confiscated cloak does not reappear without explanation)
- Name and title consistency (no character renamed mid-book without intent)

**Quality review** — prose-level craft.
- Tense and POV consistency
- Repeated words and phrasings within and across chapters
- Sentence rhythm, dialogue voice, narrator voice drift
- Tonal and lexical anachronisms

**Read-through review** — full-manuscript pass.
- Structural pacing (where does the reader stall?)
- Beat-sheet adherence (does the actual story still match `plot/beat-sheet.json`?)
- Thematic payoff (do setups close? do motifs recur as intended?)
- Engagement: is each chapter earning its place?

**Focused reports** — a narrower, named pass on one concern, drawn from the core scopes above. Use these when one dimension needs its own document. Established focused types in this workshop:
- `pacing` — structural/scene pacing only (a slice of read-through).
- `loose-ends` — open threads, unfired setups, unresolved promises awaiting closure.
- `comprehensive-evaluation` — a broad craft appraisal, typically early in a project's life.
- `uncertainty-opportunities` — places where ambiguity could be sharpened into a deliberate effect.

A focused report follows the same file/lifecycle rules as a core review. Note that **change logs are not reviews** — a record of a completed creative restructure belongs in `logs/`, not `reports/` (see [Change history](#change-history)).

### Cadence

| Trigger | Review type | Scope |
|---|---|---|
| Chapter drafted | Continuity (light) | The new chapter against the beat sheet and character/world refs |
| Part completed | Continuity + Quality | All chapters in the part, focused on internal consistency and prose health |
| Before edition snapshot (1.0, 1.1, ...) | Full read-through | Entire manuscript end-to-end |
| Quarterly (active projects) | Full read-through | Catches drift across long drafting periods |
| Pre-query / pre-submission | Full read-through | Final pass with publication in view |

A project is "active" if its `metadata.json` `status` is anything other than `complete` or `shelved`. Inactive projects skip the quarterly cadence until reactivated.

### Report format

One review = one Markdown file in `{novel}/reports/`:

```
{novel}/reports/{review-type}-{YYYY-MM-DD}.md
```

Examples: `continuity-2026-05-18.md`, `quality-ch12-15-2026-05-18.md`, `read-through-2026-02-17.md`, `pacing-2026-05-18.md`, `loose-ends-2026-05-19.md`. `{review-type}` is a core type, a combined scope, or a focused type from the list above.

Each report opens with: review type, date, scope (chapters covered), and context (what edits or events preceded it). Findings are grouped by priority:

- **Priority 1** — Plot holes and continuity errors
- **Priority 2** — Character consistency
- **Priority 3** — Repetitive prose and overused patterns
- **Priority 4** — Mechanical issues (grammar, formatting)
- **Priority 5** — Structural and pacing concerns
- **Priority 6** — Thematic and tonal polish
- **Priority 7** — Tonal / phrasing
- **Priority 8** — Pacing (advisory)
- **Needs Author Decision** — items requiring a choice, not a fix

Each finding is one row in a table with: chapter, line (approx.), the problematic text, and the suggested fix.

### Lifecycle

- The most recent unresolved review of each type sits at the top level of `{novel}/reports/`.
- When a review's findings have been addressed (verified in the manuscript and, ideally, in git), move the file to `{novel}/reports/Archive/`. Do not delete — old reviews are the record of how the manuscript evolved.
- A review is never amended in place. If new issues are found during the same scope, create a new dated report.

## Change History

Two directories in each project capture the *narrative of the work itself*, distinct from reviews (which capture the state of the manuscript).

### logs/ — change history

`logs/` records completed creative changes and pipeline events — the "what did we do and why" that git commit messages summarize but do not explain at length. This is where a **change log** belongs: a report of a finished restructure, an edition build, a large merge or split. These are records of decisions already made and executed, not open findings awaiting action — which is exactly what separates them from `reports/`.

- One Markdown file per significant change: `logs/{change-slug}-{YYYY-MM-DD}.md`.
- Because these describe completed work, they are not subject to the review lifecycle (they are never "resolved" or archived).

### annotations/ — inline editorial notes

`annotations/` holds notes tied to specific passages that are not full reviews — an author's margin note, a flagged phrase to revisit, a "check this against the map" reminder. One file per chapter or topic (`annotations/chapter-XX.md`) keeps the manuscript prose clean while preserving the marginalia. Leave the directory empty (with a `.gitkeep`) if unused.

## Editions

An **edition** is a frozen, milestone snapshot of the manuscript prepared for export/distribution. Editions are numbered `{major}.{minor}` and live in `editions/{version}/`.

**Contents — deliverables only.** An edition folder holds the *built output*, not the source:
- `chapter-XX.docx` — one per chapter (built by `scripts/export-edition.ps1`).
- `manuscript.docx` — optional single combined file with title page and TOC, for query/submission.
- `metadata.json` — a snapshot of `manuscript/metadata.json` at build time, so the edition records its own title/status/edition tag.

The Markdown source is **not** copied into the edition folder — it would duplicate `manuscript/` (100k+ words) and drift. The exact source for any edition is frozen in git at the export commit; tag it (`git tag edition-1.3`) if you want a durable pointer.

**Every edition gets a changelog entry.** `editions/CHANGELOG.md` records, per edition: the date, a summary of what changed since the previous edition, and which reviews/reports (or restructures in `logs/`) drove it. This is what lets you answer "how does 1.2 differ from 1.1?" without diffing binaries.

**Before snapshotting**, run a full read-through review (see [Cadence](#cadence)).
