# Worked examples — the full loop, end to end

Three realistic scenarios showing the whole algorithm in order. They're written
codebase-agnostic but concrete; the point is the *shape* of the reasoning and how each
step's output feeds the next — especially how Question + Delete shrink the work before
anyone optimizes or builds.

---

## Example A — "Add a notifications system" (new feature / should-we-build)

A PM files: *"Build a notification center — in-app inbox, plus email, SMS, and push,
with a pluggable channel system so we can add more later."* The instinct is to start
building the `NotificationChannel` abstraction. Run the loop instead.

**0. Understand.** Map shows the app already has an `EmailService` and an event bus that
already persists every domain event. Requirement inventory: in-app inbox, email, SMS,
push, "pluggable channels."

**1. Question.** Who asked for SMS and push? Trace it — nobody; they're "for
completeness." The only user demand in support tickets is *email digests*. "Pluggable
channel system" has no owner and no second use case. Verdicts: email **KEEP**; in-app
inbox **CHALLENGE** (ask the PM — is the inbox the goal, or just "users get told"?); SMS,
push, pluggable-abstraction → **KILL** for v1.

**2. Delete.** Drop the planned 4-driver `NotificationChannel` abstraction and its
registry. Drop the new `notifications` table — the event bus already stores the events;
a notification is a *view* of an event, not a new store.

**3. Simplify.** What's left is one `NotifyByEmail` listener on the existing event bus,
reusing `EmailService`. ~30 lines.

**4. Accelerate.** Add a seeded demo so the feature renders instantly, and a 2-second
feature test on the listener — no manual clickflow to verify.

**5. Automate.** The listener's test runs in CI. No cron, no queue worker yet — there's
nothing recurring to automate.

**Net:** shipped email notifications by writing one listener. A subsystem (4 drivers, a
registry, an abstraction, a table) was *never built* — so it never has to be tested,
maintained, or deleted later. The cheapest feature was the 80% we talked out of scope.

---

## Example B — "The dashboard is slow" (performance)

Ticket: *"Dashboard takes ~2s to load, make it fast."* The instinct is to jump to
caching or query-tuning (step 4/3). Don't start there.

**0. Understand.** Trace the load path: the dashboard renders 6 widgets, each firing its
own query on first paint.

**1. Question.** Do all 6 need to load on first paint? Two are below the fold; analytics
say they're viewed by <5% of sessions. The "recent activity" widget duplicates the main
feed. Owners: original designer, gone. Verdicts: below-fold widgets → **CHALLENGE** their
eager load; duplicate activity widget → **KILL**.

**2. Delete.** Remove the duplicate widget entirely. Make the two below-fold widgets load
on demand instead of on first paint. First paint now fires 3 queries, not 6.

**3. Simplify.** *Measure* the remaining 3. The team assumed the bottleneck was "too many
queries" — the profiler says it's an N+1 inside the revenue widget (one query per row).
Fix the actual bottleneck with eager loading. Re-measure to confirm.

**4. Accelerate.** Cache the expensive revenue aggregate for 60s; point the dashboard test
at seeded data so it runs fast and deterministically.

**5. Automate.** Nothing — it's fast enough now, and there's no recurring process to lock
in. Stop.

**Net:** P95 1.8s → 240ms — mostly by *deleting* two widgets and fixing the *real*
bottleneck, not the imagined one. Had we started at step 3, we'd have optimized six
queries including the two we deleted and the one that wasn't the problem.

---

## Example C — Over-engineered module (refactor / cleanup)

You inherit a `PaymentProviderFactory`: a plugin registry, a `PaymentProvider` interface,
driver-discovery, and three config flags — supporting exactly one provider (Stripe), for
two years.

**0. Understand.** Trace it: every call path resolves the factory, looks up "stripe" in
the registry, and calls the one implementation. No second provider exists anywhere.

**1. Question.** Requirement: "support multiple payment providers." Owner? `git blame` →
an engineer who left; the second provider was never added and isn't on the roadmap.
Verdict: **KILL** the multi-provider requirement (confirm with the human first — "no
second provider planned, removing the abstraction, OK?").

**2. Delete.** Remove the factory, the registry, the discovery, the single-impl interface,
and the three dormant flags. Replace call sites with direct `StripeClient` calls. Run the
suite: green. Add back nothing — there was no hidden dependency.

**3. Simplify.** Inline and rename: `resolveProvider().charge()` → `stripe.charge()`. The
call sites read like what they do.

**4 & 5.** Loop already at diminishing returns — the remaining code is direct and clear,
the test loop is fine, nothing new to automate. Stop.

**Net:** ~600 LOC → ~80; one indirection layer and three flags gone; the next person
reading a charge sees a charge, not a plugin system for a plugin that never came. This is
the falcon-wing door, removed: all that careful abstraction was optimizing something that
shouldn't have existed.

---

The throughline in all three: **the biggest wins came from steps 1–2, not 3–5.** The work
you question away and delete is work that never needs to be optimized, accelerated,
automated, tested, or maintained. That's why the order is the product.
