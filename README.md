# alien — the engineering mindset, as a skill family

A global Claude Code skill family that installs a senior-engineer / eng-manager /
system-architect operating system, built on Musk's 5-step algorithm:

> **Question every requirement → Delete any part or process → Simplify & optimize →
> Accelerate cycle time → Automate.** Strictly in that order. Start by understanding.

The steps are ordinary. **The order is the whole product.** Most engineers — and most
AI agents — start at "optimize / accelerate / automate" because building feels like
progress. But:

> *"The most common error of a smart engineer is to optimize a thing that should not
> exist."*

This family is a forcing function against that error. It makes you (and Claude) spend
the first, highest-leverage moves **questioning and deleting** — before a line is built.

## Why "alien"

An alien owes nothing to how it has always been done. It asks the rude, obvious
question — *why does this exist?* — that everyone else is too polite, too busy, or too
invested to ask. Judge every requirement, dependency, and line on whether it earns its
place *now*, not on its history.

## The family

| Command | Step | What it does |
| --- | --- | --- |
| `/alien` | the loop | Orchestrator + the mindset. Runs the whole loop, checkpoints with you at the seams, and chains the steps. |
| `/alien-understand` | 0 | Map the project, then deep-dive the target. Builds the requirement inventory the loop runs on. |
| `/alien-question` | 1 | Question every requirement; attach an owner + a live reason; kill the fossils. |
| `/alien-delete` | 2 | Delete every part/dep/layer/flag/step you can; run the gate to see what breaks; add back ~10%. |
| `/alien-simplify` | 3 | Clarify and optimize *only what survived*. Measure before optimizing. |
| `/alien-accelerate` | 4 | Shorten the build→test→feedback loop. Fast tests, fast dev, cheap failure. |
| `/alien-automate` | 5 | Automate the proven-stable, repetitive steps — last, because automation locks things in. |

Call any step on its own (`/alien-delete` to prune dead code; `/alien-question` to
challenge a spec), or run `/alien` to drive the full loop. Each step ends by pointing at
the next, so the family **chains itself** — and loops onto the next subsystem until it
converges (you stop when you'd add back more than ~10–15% of what you cut, or the
remaining changes are cosmetic).

## Install

The skills live here and are symlinked into `~/.claude/skills/`, so they're available in
**every project** with no per-project setup. Edit the files here; changes are live
immediately.

```bash
./setup.sh           # symlink all alien-* skills into ~/.claude/skills
./setup.sh --check   # show what's linked
./setup.sh --remove  # unlink (this repo stays intact)
```

Then in any project: `/alien`, `/alien-understand`, `/alien-question`, …

## How it's meant to be used

- **Before a feature** ("should we build X?") → `/alien`, and take Question seriously.
  The cheapest feature is the one you talk the user out of needing.
- **A bloated / over-engineered codebase** → `/alien-understand` → `/alien-delete` →
  `/alien-simplify`.
- **"It's slow"** → understand → simplify (measure the *real* bottleneck) → accelerate.
  Resist jumping straight to speed.
- **A spec/requirements review** → `/alien-understand` → `/alien-question`, then stop.
- **Setting up CI / scripts** → still question + delete first; don't automate a process
  nobody has questioned.

## Layout

```
alien-skill-family/
├── README.md
├── setup.sh                       # symlink installer (idempotent)
└── skills/
    ├── alien/
    │   ├── SKILL.md               # orchestrator + the mindset + the loop
    │   └── references/algorithm.md# the deep why: stories, quotes, the order
    ├── alien-understand/SKILL.md  # step 0
    ├── alien-question/SKILL.md    # step 1
    ├── alien-delete/SKILL.md      # step 2
    ├── alien-simplify/SKILL.md    # step 3
    ├── alien-accelerate/SKILL.md  # step 4
    └── alien-automate/SKILL.md    # step 5
```

## Credit

The algorithm is Elon Musk's, as recounted in Walter Isaacson's biography (and widely
shared by Eric Jorgenson). This family translates it into everyday engineering practice
for any codebase.

Question. Delete. Simplify. Accelerate. Automate. In that order.
