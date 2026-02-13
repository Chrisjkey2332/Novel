# Novel Workshop Process

This document defines the collaborative workflow for brainstorming, developing, and drafting novels.

## Directory Structure

```
Novel/
├── _ideas/                          # Raw brainstorm notes, not yet a full project
│   └── {idea-name}.md
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
│   └── reports/                     # Quality analyses, reviews
│
└── NOVEL-PROCESS.md                 # This file
```

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

1. Choose a working title (can change later)
2. Create the project folder with full directory structure
3. Fill in `metadata.json` with basic info
4. Proceed through the pipeline stages in order (but revisiting is fine)

### Quality analysis

Use `{novel}/reports/quality-analysis.md` as a prioritized checklist:
- Priority 1: Plot holes and continuity errors
- Priority 2: Character consistency
- Priority 3: Repetitive prose and overused patterns
- Priority 4: Mechanical issues (grammar, formatting)
- Priority 5: Structural and pacing concerns
- Priority 6: Thematic and tonal polish
