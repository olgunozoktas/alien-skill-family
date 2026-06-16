---
name: alien-delete
version: 1.0.0
description: |
  Step 2 of the alien algorithm — DELETE every part, dependency, layer, flag, file,
  abstraction, and process you can, then add back ONLY what's proven necessary. Works in
  ANY codebase, any language. The rule is not "delete the obviously dead stuff" — it's
  delete aggressively, run the tests/types/build to see what actually breaks, and expect
  to add back about 10% (if you add back nothing you didn't cut hard enough; if you add
  back half you cut blind). The simplest, fastest, cleanest code is the code that's gone.
  Use this whenever a codebase feels bloated or over-engineered; to remove dead code,
  unused dependencies, redundant layers, speculative generality, dormant config flags, or
  whole unused features; after /alien-question kills requirements; before simplifying or
  optimizing (you never optimize code you're about to delete). Triggers: "/alien-delete",
  "what can we remove", "delete dead code", "remove this dependency", "this is
  over-engineered", "strip it down", "prune", "de-bloat".
---

# alien-delete — delete everything you can

Musk's favorite step, and the one that most separates this algorithm from ordinary
"cleanup." Ordinary cleanup removes what's *obviously* unnecessary. This removes
everything you *can*, on purpose, to discover what's actually necessary.

> "If you're not adding back at least 10% of the things you deleted, you haven't deleted
> enough."

The add-back rule is what makes aggressive deletion safe and disciplined rather than
reckless. You pre-commit to restoring the ~10% you were wrong about, which frees you to
cut hard. Add back nothing → you were timid, cut more. Add back half → you cut blind, you
didn't understand the blast radius (go back to `/alien-understand`).

> "If you don't delete things that seem necessary, you never find out what's actually
> necessary."

Radar was deleted from Autopilot — an industry "requirement" — precisely to find out
what cameras alone could do. The Raptor engine shed part after part, combining functions
and eliminating whole systems, ending simpler, cheaper, and more reliable.

## What to delete (in code)

Hunt these, roughly highest-leverage first:

- **Whatever `/alien-question` KILLed** — the requirements with no owner and no live
  reason, plus the code, tests, config, and docs that exist only to serve them.
- **Dead & unreachable code** — unused functions, exports, components, endpoints,
  branches, feature flags that are never flipped, commented-out blocks.
- **Unused dependencies** — packages imported once for something the stdlib does, or not
  imported at all. Each dependency is attack surface, build time, and lock-in.
- **Speculative generality** — the configurable/generic/pluggable version of something
  with exactly one caller. The abstraction "we might need." This is the single most
  rewarding thing to delete; it almost never gets used and always costs.
- **Redundant layers & indirection** — wrappers that only forward, adapters with one
  implementation, a service that just calls another, needless inheritance.
- **Duplicated logic** — collapse N copies into one (and if there's no good home for the
  one, that's a finding for `/alien-simplify`, not a reason to keep N).
- **Process & steps** — build steps, scripts, manual ceremony, review gates, generated
  artifacts nobody reads. Deleting a *process* is as valuable as deleting a *part*.

## How to delete safely — "see what breaks"

Your compiler, type-checker, and test suite are Musk's "see what breaks." Use them as
the instrument:

1. **Delete the candidate** (or comment it out as a fast first pass).
2. **Run the gate** — the project's tests, type-check, lint, and build. Whatever the repo
   uses; respect its toolchain and conventions.
3. **Read the breakage.** Green → the deletion holds. Red → either restore it (it's part
   of your 10%) or trace *why* it's needed (sometimes the failing test is itself fossil
   that should also go).
4. **Grep for dynamic uses** the type system can't see — string references, reflection,
   route names, DI bindings, config keys, serialized names. Deleting these blind is how
   "see what breaks" becomes "break it in production." When in doubt, search before you cut.
5. **Cut in reviewable slices** and keep the gate green between them, so any regression is
   bisectable and the human can follow what's leaving.

## Checkpoint before large or risky cuts

Deleting a function is routine; deleting a subsystem, a public API, a dependency others
rely on, or anything you can't fully prove is dead — surface it first, with *why you
believe it's safe* and what you checked. You're usually right; give the human the chance
to catch the case your grep missed. Don't imply certainty you don't have.

## Output

```
## alien-delete — <target>
- Deleted: <parts/deps/layers/flags/steps removed — be specific>
- Added back (~10%): <what you restored and the concrete reason>
- Verified by: <tests/types/build green; greps run for dynamic refs>
- Net removed: <files / deps / LOC / steps>
- Held for checkpoint: <risky cuts awaiting human OK>
```

If you added back nothing, say so and consider cutting deeper. If you couldn't prove a
deletion safe, name the risk — don't ship false confidence.

---

**Next:** `/alien-simplify` — now make what *survived* clear, cohesive, and correct.
Don't skip back to optimizing what you just deleted. Or return to `/alien`.
