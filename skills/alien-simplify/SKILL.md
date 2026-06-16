---
name: alien-simplify
version: 1.0.0
description: |
  Step 3 of the alien algorithm — SIMPLIFY and OPTIMIZE what survived questioning and
  deletion, and ONLY what survived. Works in ANY codebase, any language. This is step 3,
  not step 1, on purpose: the most common error is optimizing something that should not
  exist, so you simplify after you've questioned (/alien-question) and deleted
  (/alien-delete), never before. Make what remains clear, cohesive, and correct — good
  names, one responsibility per unit, low coupling, the obvious structure. For
  performance, MEASURE FIRST and fix the real bottleneck, not the imagined one. Use this
  to refactor for clarity, consolidate duplication into one good home, untangle coupling,
  improve naming, or optimize a hot path — but only once the surface is already minimal.
  Triggers: "/alien-simplify", "simplify this", "refactor for clarity", "clean this up",
  "make this readable", "optimize the hot path", "reduce coupling", "this is too complex".
---

# alien-simplify — simplify & optimize what's left

Third, not first — and the ordering is the entire point.

> "It's very common, possibly the most common error, to optimize something that should
> not exist."

The Model X falcon-wing doors were superbly optimized — sensors, motors, hinges, months
of work to make them work better. They were also a mistake: they shouldn't have existed.
All that optimization was productive in exactly the wrong direction. That is what
simplifying *before* questioning and deleting produces. So this skill assumes you've
already run `/alien-question` and `/alien-delete`; if you haven't, stop and do that
first, or you risk polishing a falcon-wing door.

Now that the surface is minimal, your job is to make it *good*.

## Simplify for clarity (do this first)

The best optimization is usually comprehension. Code that's obvious is correct more
often, changed more safely, and deleted more easily next time.

- **Name things truthfully.** A variable, function, or module named for what it actually
  is removes more confusion than any comment. Rename ruthlessly.
- **One responsibility per unit.** A function/class/component that does one thing is
  testable, reusable, and movable. Split the ones that do several. (Watch file-size caps
  and the codebase's own structure conventions — split *with* the grain.)
- **Reduce coupling.** Fewer parameters, fewer reach-throughs, clearer boundaries.
  Depend on interfaces and data, not on the insides of other modules.
- **Collapse duplication into one good home.** If Delete found N copies, this is where
  the single version lives — and it should reuse existing primitives, not invent a new one.
- **Make the structure match the domain.** The shape of the code should mirror the shape
  of the problem, so the next reader's intuition is correct by default.

Simplicity has a floor: don't compress until it's clever-but-opaque. The target is
*obvious*, not *short*. If a "simplification" makes a teammate slower to understand it,
it failed.

## Optimize for performance (only with a measurement)

Once it's clear and correct, and only if there's a real performance requirement that
survived `/alien-question`:

1. **Measure.** Profile, benchmark, time it, read the query plan. Find the *actual*
   bottleneck. Intuition about hot paths is wrong often enough that guessing is its own
   smart-engineer error.
2. **Fix the dominant cost.** Algorithmic complexity, N+1 queries, redundant work in a
   loop, a missing index, needless allocation, work that could be done once. Go after the
   thing the measurement points at — not the thing that's fun to optimize.
3. **Re-measure.** Confirm the win is real and the behavior is unchanged. An optimization
   you can't measure is a complexity cost you can't justify.
4. **Stop at "fast enough."** Optimizing past the requirement re-introduces the
   complexity you spent steps 1–2 removing. Diminishing returns is the signal to stop.

## Keep it green

Every refactor and optimization must leave the project's tests, types, and build green.
Behavior-preserving is the contract of this step — you're changing *form*, not *function*.
If you don't have a test that pins the behavior you're about to refactor, write it first,
then refactor under it.

## Output

```
## alien-simplify — <target>
- Clarified: <renames, splits, decoupling, duplication collapsed>
- Optimized: <what + the before/after measurement + why it was the real bottleneck>
- Verified: <tests/types/build green; behavior unchanged>
- Left alone: <things deliberately not touched — "fast enough" / "clear enough">
```

Report measurements, not vibes, for any performance claim. "Feels faster" isn't a result.

## Example

**Input:** Pricing logic is a 5-level-deep nested `if/else` over tier × region × coupon —
hard to follow, and `/alien-delete` already pruned the dead branches.

- **Pin behavior first:** write a test that exercises the surviving tier/region/coupon
  combinations, so the refactor is provably behavior-preserving.
- **Clarify:** replace the nesting with a lookup table keyed on `(tier, region)`, and pull
  the coupon adjustment into a named `applyCoupon()` function. The shape now matches the
  domain: "price = base[tier][region], then coupon."
- **Measure before optimizing:** profile — pricing is called once per checkout, well under
  budget. No performance requirement survived `/alien-question`, so this is **clarity-only**;
  optimizing it further would re-add complexity for nothing.
- **Output:** same results, a third of the lines, readable top to bottom; tests green.

Note what *didn't* happen: no caching, no micro-optimization. Simplify is allowed to stop
at "obvious and correct" when there's no measured reason to go faster.

---

**Next:** `/alien-accelerate` — now that the thing is right and lean, make the
build→test→feedback loop around it fast. Or return to `/alien` for the full loop.
