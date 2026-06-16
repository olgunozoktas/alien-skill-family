---
name: alien-accelerate
version: 1.0.0
description: |
  Step 4 of the alien algorithm — ACCELERATE cycle time: make the build→test→feedback
  loop fast, once the thing is already right and lean. Works in ANY codebase, any
  language. This is step 4, after questioning, deleting, and simplifying, because speed is
  a MULTIPLIER — doing the wrong thing faster just reaches the wrong place sooner, so you
  only accelerate a process you've already established is correct. Tighten the iteration
  loop: fast tests, fast local dev/HMR, fast deploys, cheap reversible experiments, and
  intentional cheap failures that teach (each failure is data). Use this when the
  feedback loop is slow — slow test suites, slow CI, slow local startup, painful manual
  verification, long lead time from change to confidence — or to make iterating on a
  proven design faster. Triggers: "/alien-accelerate", "the tests are too slow", "speed
  up CI", "tighten the feedback loop", "faster iteration", "the dev loop is painful",
  "reduce cycle time".
---

# alien-accelerate — accelerate cycle time

Speed comes fourth, and the reason is a multiplication fact: speed multiplies whatever
direction you're already going. If the thing is wrong, going faster gets you to the wrong
place sooner. So you accelerate only *after* `/alien-question`, `/alien-delete`, and
`/alien-simplify` have made the thing correct, lean, and clear. Accelerating before that
is how teams get very efficient at building the wrong system.

Musk's obsession is cycle time — how fast you go from idea → execution → feedback. SpaceX
builds and tests faster than anyone thought possible and blows prototypes up *on purpose*:
each explosion is data, each failure teaches, and the *speed of iteration is the
competitive advantage*. Outsiders saw failure; he saw learning at a higher clock rate.

The goal of this step: shrink the time between "I made a change" and "I know whether it
worked" — for you, and for everyone who works in this codebase after you.

## Where to find cycle time (engineering)

- **Test speed.** The test loop is the heartbeat of iteration. Make the common case fast:
  run the relevant subset, parallelize where the suite allows, kill slow shared fixtures,
  push slow integration tests to a separate tier so the fast feedback stays fast. A suite
  that's slow to run is a suite that gets run less — which slows everything downstream.
- **Local dev loop.** Fast startup, hot-reload/HMR, fast incremental builds, seed data so
  every page/feature renders in seconds instead of after a 30-step manual clickflow. The
  faster a developer can *see* a change, the more changes they'll try.
- **Build & CI.** Cache aggressively, parallelize jobs, fail fast on the cheapest gate
  first (lint before a 10-minute browser suite). Order checks so the common failure shows
  up first.
- **Deploy & verify.** Short, safe, reversible path to production or staging. The cheaper
  and more reversible a deploy, the faster you can learn from real behavior.
- **Make failure cheap and informative.** Good error messages, fast reproductions,
  feature flags / quick rollback, throwaway experiments. When failure is cheap you can
  iterate boldly on the *right* thing instead of agonizing over each step.

## Accelerate the loop, not just the runtime

This step is about the *feedback loop*, which is a different thing from runtime
performance (that was `/alien-simplify`'s job, with a measurement). Here you're
optimizing the developer's and the system's *learning rate* — how quickly a change
becomes knowledge. A 2-second test run that you invoke fifty times a day saves more than
a micro-optimized function you touch once a quarter.

## Don't accelerate waste

Before speeding any process up, give it one more glance from steps 1–2: a slow step you
can *delete* beats a slow step you make fast. The fastest test is the redundant one you
removed; the fastest build step is the one that no longer runs. Question, then accelerate.

## Keep it honest

Faster must not mean flakier or less safe. A fast test suite that's nondeterministic, or
a quick deploy with no rollback, trades real confidence for the appearance of speed —
that's negative progress. Verify the accelerated loop still gives *trustworthy* signal.

## Output

```
## alien-accelerate — <target>
- Loop before → after: <e.g. test suite 240s → 38s; cold dev start 90s → 12s>
- Changes: <what made it faster — subsetting, parallelism, caching, seeds, flags>
- Deleted instead of sped up: <slow steps removed outright>
- Safety check: <still deterministic / reversible / trustworthy signal>
```

Give the before/after numbers. "Feels snappier" is not an acceleration result.

---

**Next:** `/alien-automate` — automate the now-fast, proven-stable steps, last. Or return
to `/alien` for the full loop.
