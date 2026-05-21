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
  "genre": "Genre",
  "pov": "First Person / Third Limited / etc.",
  "tense": "Past / Present",
  "tone": "Description of tone",
  "audience": "adult / young adult",
  "targetWordsPerChapter": 3500,
  "status": "brainstorm / planning / initialDraft / revision / complete",
  "createdUtc": "ISO date",
  "updatedUtc": "ISO date"
}
```

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

Detailed scene-level planning before drafting.

Each chapter file (`{novel}/manuscript/chapter-XX.md`) starts with a plan section:

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

Each review type has a clear scope. Mix them as needed, but do not bundle them into one document; separate scopes get separate reports.

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

Examples: `continuity-2026-05-18.md`, `quality-ch12-15-2026-05-18.md`, `read-through-2026-02-17.md`.

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
