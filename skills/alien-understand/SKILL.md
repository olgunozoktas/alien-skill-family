---
name: alien-understand
version: 1.0.0
description: |
  Step 0 of the alien algorithm — UNDERSTAND the project, then DEEP-DIVE the area you
  are about to touch, BEFORE questioning, deleting, building, or changing anything.
  Works in ANY codebase, any language. Two modes: a broad MAP (what is this, the stack,
  the architecture, entry points, conventions, where things live) and a focused
  DEEP-DIVE (trace one subsystem end-to-end). Produces a concise mental model and a
  requirement inventory that the rest of the loop runs on. Use this whenever you land in
  an unfamiliar repo, start a non-trivial task, are asked to "understand the codebase",
  "get up to speed", "map this project", "trace how X works", or before any audit,
  refactor, or feature. You cannot question a requirement you haven't found or delete a
  part you can't see — so understanding always comes first. Triggers: "/alien-understand",
  "understand this project", "deep dive", "how does X work", "map the codebase",
  "get oriented", "trace this feature".
---

# alien-understand — map, then deep-dive

You cannot question a requirement you haven't found, delete a part you can't see, or
simplify a flow you don't grasp. So the algorithm starts here. The goal is not a
exhaustive survey — it is the **smallest accurate mental model** that lets you make good
decisions in the next steps.

Spend effort proportional to the task. A one-line fix needs a glance; a subsystem
rewrite needs a real trace. Don't over-map — that's its own form of the smart-engineer
error (studying a thing you might be about to delete).

## Mode 1 — MAP (broad orientation)

Build the lay of the land. Lean on what's cheapest and highest-signal first:

1. **Read what the project tells you about itself.** `README`, `CLAUDE.md` / `AGENTS.md`
   / `GROK.md`, `DESIGN.md`, `docs/`, `CONTRIBUTING`. These encode requirements,
   conventions, and hard rules you must respect — and often the *why*.
2. **Identify the stack & shape.** Manifest files (`package.json`, `composer.json`,
   `Cargo.toml`, `go.mod`, `pyproject.toml`, `Gemfile`), framework, build tooling, test
   runner, how it runs locally, how it deploys.
3. **Find the entry points & structure.** Where execution starts (routes, `main`, CLI,
   handlers), the top-level directories and what each owns, the module boundaries.
4. **Learn the conventions.** Naming, layering, where shared code lives, the design
   system / token sources, lint/format/test gates. The next steps must move *with* the
   grain of the codebase, not against it.

For large or unfamiliar repos, fan this out: dispatch read-only explorer/research
agents in parallel (one per subsystem or question) and keep the conclusions, not the
file dumps. Prefer the project's own search/index tools where they exist.

**Output: a project map** — a few tight lines. What is this, what's the stack, how is it
organized, what are the load-bearing conventions, and where does the thing I care about
live.

## Mode 2 — DEEP-DIVE (trace the target)

Once oriented, go deep on exactly the area the task touches. Trace it end-to-end:

- **Follow the data/control flow.** From entry point → through the layers → to the
  store/effect and back. Name each hop and what it's responsible for.
- **Map the dependencies & blast radius.** What calls this, what this calls, what shares
  its data, what breaks if it changes. This is what makes step 2 (Delete) safe.
- **Find the prior art & the patterns.** How does this codebase already solve this shape
  of problem? Reuse beats reinvention — note the existing component/service/helper before
  anyone writes a new one.
- **Note the tests & invariants.** What proves this works today? Those tests are your
  "see what breaks" instrument in Delete.

## The requirement inventory (the handoff to step 1)

The single most valuable artifact you produce is a list of **every requirement the work
is being asked to satisfy** — explicit (the spec, the ticket, the user's ask) and
implicit (the constraint baked into existing code, the "we've always supported this").
For each, note where it came from if you can tell. You're not judging them yet — that's
`/alien-question`. You're surfacing them so they *can* be judged. A requirement nobody
wrote down is the one most likely to be a fossil.

## Output

```
## alien-understand — <target>
- What it is: <one-line model>
- Stack / conventions: <the load-bearing facts + hard rules to respect>
- The target traced: <entry → layers → store, blast radius, prior art>
- Requirement inventory: <each requirement → source/owner if known>
- Open questions: <what's still unclear>
```

State what you're confident about vs. inferring. An honest "I don't yet know how X
works" is worth more than a confident guess that misleads the next step.

---

**Next:** `/alien-question` — challenge every requirement in the inventory you just
built. Or return to `/alien` to run the full loop.
