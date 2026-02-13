# Novel Workshop Process

This document defines the collaborative workflow for brainstorming, developing, and drafting novels.

## Directory Structure

```
Novel/
├── _ideas/                    # Raw brainstorm notes, not yet a full project
│   └── {idea-name}.md
│
├── {novel-name}/              # One folder per novel project
│   ├── concept.md             # Premise, themes, tone, genre, pitch
│   ├── characters.md          # Character profiles, arcs, relationships
│   ├── world.md               # Setting, world-building, rules
│   ├── outline.md             # Act/chapter-level story structure
│   ├── chapters/
│   │   ├── 01-chapter-name.md # Chapter plan + draft prose
│   │   ├── 02-chapter-name.md
│   │   └── ...
│   ├── notes.md               # Running research, references, decisions
│   └── revision-log.md        # Track revision passes and feedback
│
└── NOVEL-PROCESS.md           # This file
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
- Output: `{novel}/concept.md`

### 3. Characters

Build the cast who will carry the story.

For each major character:
- **Name & Role**: Who are they in the story?
- **Background**: Relevant history, formative experiences
- **Motivation**: What do they want? What do they need (if different)?
- **Flaw/Conflict**: What internal obstacle do they face?
- **Arc**: How do they change from beginning to end?
- **Voice**: How do they speak, think, see the world?

Also document:
- **Relationships**: How characters connect to and affect each other
- **Supporting Cast**: Brief notes on secondary characters
- Output: `{novel}/characters.md`

### 4. World

Define the stage where the story plays out.

- **Setting**: Time, place, scope
- **Rules**: What's different from our world (if anything)?
- **Atmosphere**: What does this world feel/look/sound like?
- **History**: Relevant backstory that shapes the present
- **Society & Culture**: Power structures, norms, tensions
- Only build what the story needs - avoid world-building for its own sake
- Output: `{novel}/world.md`

### 5. Outline

Structure the full story arc.

- **Three-Act Structure** (or whatever structure fits):
  - Act 1: Setup, inciting incident, first turning point
  - Act 2: Rising action, midpoint shift, complications, crisis
  - Act 3: Climax, resolution, denouement
- **Chapter Beats**: One-line summary of each chapter's purpose
- **Subplot Threads**: Track B-plots and where they intersect the main arc
- **Pacing Notes**: Where to accelerate, where to breathe
- Output: `{novel}/outline.md`

### 6. Chapter Plans

Detailed scene-level planning before drafting.

Each chapter file (`{novel}/chapters/XX-chapter-name.md`) starts with a plan section:

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
- Update the outline if the story diverges from the plan

### 8. Revision

Improve what's been written.

- **Pass 1 - Structure**: Does the story work? Pacing, arcs, plot holes
- **Pass 2 - Scenes**: Does each scene earn its place? Tension, clarity
- **Pass 3 - Prose**: Language, dialogue, voice, rhythm
- **Pass 4 - Polish**: Continuity, typos, formatting
- Track each pass in `{novel}/revision-log.md`

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
2. Create the project folder: `{novel-name}/`
3. Move/expand the idea into `concept.md`
4. Proceed through the pipeline stages in order (but revisiting is fine)

### Notes and research

Use `{novel}/notes.md` as a catch-all for:
- Research findings
- Style references and inspiration
- Decisions made and why
- Questions to resolve later
