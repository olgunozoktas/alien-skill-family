---
name: alien-automate
version: 1.0.0
description: |
  Step 5 — the LAST step — of the alien algorithm: AUTOMATE the proven-stable, repetitive,
  low-judgment steps, only after they've been questioned, deleted, simplified, and
  accelerated. Works in ANY codebase, any language. Automation comes last on purpose:
  it LOCKS THINGS IN and makes them invisible, so automating a process you haven't
  questioned freezes the waste and hides it from the next person who might have deleted
  it. And don't over-automate — "humans are underrated"; keep judgment-heavy, high-variance,
  low-frequency work with people. Use this to add CI checks, scripts, codegen, scheduled
  jobs, git hooks, or bots around a process that is already correct, lean, and stable —
  never to paper over a process that should have been removed. Triggers: "/alien-automate",
  "automate this", "add CI for X", "write a script for this", "set up a cron/hook",
  "codegen this", "make this run automatically".
---

# alien-automate — automate last

Automation is step five, and putting it anywhere earlier is the mistake the whole
algorithm is built to prevent.

> "Excessive automation at Tesla was a mistake. Humans are underrated."

During Model 3 production Tesla automated nearly everything — a lights-out factory of
robots. It was a disaster: the automation was too complex, it broke constantly, and much
of it automated processes that shouldn't have existed. They tore it out and brought
humans back for many tasks. Step five had been run before steps one through four.

Two reasons automation comes last:

1. **It locks things in.** Once a process is automated it's harder to change and it goes
   *invisible* — it stops being questioned, because it "just runs." If you automate a
   process you haven't questioned and deleted, you've made the waste permanent and hidden
   it from the next person who'd have removed it. Automate only what survived steps 1–4.
2. **It's only worth it when stable.** Automating a process that's still churning means
   maintaining the automation *and* the churn. Accelerate first (`/alien-accelerate`);
   automate the version that has stopped changing shape.

## What's a good automation candidate

Automate where the work is **repetitive, well-understood, low-variance, and high-frequency**,
and where a machine is genuinely more reliable than a human:

- **The quality gate** — lint, format, type-check, tests run on every push/PR so
  regressions are caught without anyone remembering to look.
- **Codegen & scaffolding** — generated routes/types/clients, boilerplate a template can
  produce deterministically, repetitive file creation.
- **Scheduled / triggered jobs** — recurring maintenance, syncs, report generation,
  dependency-audit runs — things that should happen on a clock, not on a human's memory.
- **Guardrails** — preflight checks, hooks, and CI assertions that make an unsafe state
  *fail loudly* (the doc says it, the gate enforces it).
- **Toil removal** — the manual, error-prone ritual a developer repeats by hand. Script
  the steps a machine does better.

## What to leave to humans (don't over-automate)

Keep people on judgment-heavy, high-variance, low-frequency, or irreversible work:
architecture decisions, ambiguous tradeoffs, anything where being wrong is expensive and
a human's context beats a rule. A brittle automation that needs constant babysitting is
worse than the manual step it replaced — it adds a maintenance burden *and* a false sense
of safety. If automating something costs more than the toil it removes, don't.

## Build automation that fails safe and stays visible

- **Fail loud, not silent.** The worst automation is one that breaks quietly — a dead
  cron, a check that started passing-by-doing-nothing. Make failures alarm.
- **Keep it the source of truth, mirrored by docs.** When a guardrail enforces a rule,
  the doc explains *why* — the two must agree, so a future maintainer can understand what
  the automation guards without reverse-engineering it.
- **Respect the project's conventions.** Use the repo's existing CI, hook, and script
  patterns; don't introduce a parallel automation stack.
- **Make it reversible & legible.** Someone should be able to read what runs, when, and
  why — and turn it off. Automation that can't be questioned has become the fossil from
  step 1.

## Output

```
## alien-automate — <target>
- Automated: <the gates/jobs/codegen/hooks added, and what each prevents or produces>
- Left to humans: <what was deliberately NOT automated, and why>
- Fails safe: <how a failure surfaces — alarms, not silence>
- Stable enough: <evidence the process had stopped changing before you froze it>
```

Name what you chose *not* to automate as deliberately as what you did. Restraint here is
the senior move.

---

**Loop:** that's the algorithm — Question, Delete, Simplify, Accelerate, Automate, in
order. To go again on the next subsystem, return to `/alien-understand`, or to `/alien`
to drive the full loop. Stop when you'd add back more than ~10–15% of what you cut, or
the remaining changes are cosmetic — converge, don't spin.
