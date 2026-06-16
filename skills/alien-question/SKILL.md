---
name: alien-question
version: 1.0.0
description: |
  Step 1 of the alien algorithm — QUESTION EVERY REQUIREMENT before deleting, building,
  or designing anything. Works in ANY codebase or spec. For each requirement, constraint,
  field, flag, validation, "we must support X", or acceptance criterion, attach the NAME
  of the person who made it and the reason it exists — then kill the ones that survive
  only because they've always been there. Distrust requirements most when they come from
  a smart person or "a department," because those get questioned least. Produces a
  requirement ledger (owner, reason, still-valid?, verdict) that feeds /alien-delete. Use
  this whenever you're handed a spec, ticket, or set of constraints; whenever something is
  "required" but nobody can say why; before scoping or building a feature; for spec
  reviews and de-scoping. The cheapest feature is the one you talk the user out of needing.
  Triggers: "/alien-question", "question the requirements", "why do we need this", "who
  asked for this", "challenge the spec", "is this actually required", "de-scope".
---

# alien-question — question every requirement

This is where engineering gets uncomfortable, and where the leverage is highest. A
requirement you successfully kill costs zero to build, zero to test, zero to maintain,
and zero to delete later. No optimization in any later step beats not building the thing.

> "Each requirement should come with the name of the person who made it. Never accept
> that a requirement came from a department."

Departments don't defend requirements; people do. A requirement with no owner is a
fossil — it survives because removing it feels disrespectful or risky, not because it's
load-bearing. The classic case: a sensor on the Model 3 battery pack that had been there
since the start. Nobody knew who required it. The engineer who added it had left; the
problem it solved was gone. They removed it and nothing broke.

## Question hardest where you're tempted to trust most

The instinct is to wave through requirements that come from someone smart, senior, or
from "the spec" / "the standard" / "compliance" / "the platform team." Those are exactly
the ones to question, because everyone *else* waved them through too. Smart people are
less likely to be questioned — so their unexamined assumptions travel furthest. (This
includes requirements *you* generated a moment ago because they "seemed obviously
needed.")

This is not disrespect. It's the opposite: you take the requirement seriously enough to
ask what it's actually for.

## How to question a requirement

For each item in the requirement inventory (from `/alien-understand`), ask:

1. **Who required this?** A specific person/ticket/commit/decision — not "the system,"
   "the spec," or "the team." If you can `git blame` or trace it, do. No owner → prime
   suspect.
2. **What problem does it solve — today?** Not what it solved when it was added. Problems
   expire; requirements rarely get the memo.
3. **What actually breaks if it's gone?** Be concrete. "It might cause issues" is a
   fossil's defense. Name the failure, or admit there isn't one you can name.
4. **Is it confirmable cheaply?** Sometimes a quick test, a grep for usages, an analytics
   number, or one question to the user resolves "is this real" in seconds. Ask the human
   when the answer is theirs to give — the owner is often one message away.
5. **Is the requirement load-bearing, or is it a proxy?** "Must use radar" was a proxy
   for "must perceive the road." Question the proxy; the real requirement may have a far
   simpler solution (cameras).

## Verdicts

Give every requirement one of:

- **KEEP** — owner + live reason + real breakage if removed. Load-bearing. Move on.
- **CHALLENGE** — plausibly stale or a proxy; needs one cheap check or a question to the
  human before you commit. Raise it; don't silently assume.
- **KILL** — no owner, no live reason, nothing breaks. Mark it for `/alien-delete`.

When you'd KILL or CHALLENGE something that affects scope or behavior, **surface it to
the human before acting** — phrased as a question, not a fait accompli. "This validation
seems to guard a case that can't occur anymore — owner unknown, removing it. Objection?"
You're often right, and the human can kill a fossil you'd have been too cautious to touch.

## Output — the requirement ledger

```
## alien-question — <target>
| Requirement | Owner / source | Reason today | Breaks if gone? | Verdict |
| ...         | ...            | ...          | ...             | KEEP/CHALLENGE/KILL |

- To confirm with human: <CHALLENGE items needing a decision>
- Headed to delete: <KILL items>
```

Be honest about confidence. A KILL you're 60% sure of is a CHALLENGE — say so.

## Example

**Input:** A spec says *"Every API response MUST include `correlation_id`, `trace_id`,
AND `request_id`."* Three IDs on every payload feels like a requirement from "the platform."

- **`correlation_id`** — owner: platform team, for stitching logs across services. Live
  reason, real breakage if gone (tracing dashboards key on it). → **KEEP**.
- **`trace_id`** — `git blame` → copied from an example gateway config two years ago; no
  owner. Inspection shows it always carries the *same value* as `correlation_id`. → **KILL**.
- **`request_id`** — same story; duplicates `correlation_id` for the single-service case.
  Nothing reads it. → **KILL**.

**Output (surfaced to the human):** "Three IDs, one real one — `trace_id`/`request_id`
mirror `correlation_id` and have no consumer. Dropping both unless you know a client that
reads them?" Two of three 'required' fields removed from every response, forever.

---

**Next:** `/alien-delete` — remove the KILLed requirements and every part/process they
were propping up, plus everything else you can. Or return to `/alien` for the full loop.
