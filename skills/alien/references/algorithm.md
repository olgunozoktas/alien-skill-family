# The algorithm — the why behind the order

This is the deep reasoning for the `alien` family. Read it when you need the *why*
behind a step, or when you (or a human) need convincing that deleting the "obviously
necessary" thing is discipline, not recklessness.

## The origin story

At the Tesla factory there was an elaborate system for putting fiberglass mats on
battery packs — complex machinery, multiple steps, carefully designed and optimized
over time. Musk asked one question: *why do we need the fiberglass mats?* The answer
was "fire safety — it's a requirement, everyone knows you need them." But when they
actually tested it, the mats didn't do much for fire safety. They were a requirement
nobody had questioned. So he deleted the entire process.

The thing that had been carefully automated **shouldn't have existed in the first
place.** Every hour spent optimizing that machinery, every clever fix, was effort spent
in the wrong direction. That is the lesson the whole algorithm protects against.

## The five steps, and why each precedes the next

> One. Question every requirement.
> Two. Delete any part or process you can.
> Three. Simplify and optimize.
> Four. Accelerate cycle time.
> Five. Automate.

Most people start at five (automate), or four (speed up), or three (optimize). It feels
like progress. But:

> **"The most common error of a smart engineer is to optimize a thing that should not exist."**

If you haven't done one and two, you're optimizing and automating things that shouldn't
exist — and worse, you're making them permanent.

### 1. Question every requirement

Question every requirement, *especially if it comes from a smart person* — because
smart people are less likely to be questioned. We assume they've thought it through.

> "Each requirement should come with the name of the person who made it. Never accept
> that a requirement came from a department."

Departments don't defend requirements; people do. On the Model 3 line there was a
sensor on the battery pack that had been there since the beginning. Nobody knew who
required it. The original engineer had left years earlier; the problem it solved no
longer existed. They removed it and nothing broke.

**Engineering translation:** every constraint you're coding against — a field, a
validation, a config flag, an API contract, a "we must support X" — has an owner and a
reason, or it's cargo. Find the owner. Find the reason. If the reason is "it's always
been there," that's not a reason, it's a fossil.

### 2. Delete

Musk's favorite step. The rule is not "delete what's obviously unnecessary." It's:
delete every part or process you can, see what breaks, and add back only what's truly
needed.

> "If you're not adding back at least 10% of the things you deleted, you haven't
> deleted enough."

The add-back rule is the genius of it. It gives you permission to cut aggressively
because you've pre-committed to restoring the ~10% you were wrong about. If you add
back nothing, you were too timid. If you add back half, you cut blind.

At SpaceX the Raptor engine had part after part removed, functions combined, whole
systems eliminated — ending with dramatically fewer components than comparable engines:
simpler, cheaper, more reliable. Tesla deleted radar from Autopilot entirely — an
industry-wide "requirement" — to find out what cameras alone could actually do. "If you
don't delete things that seem necessary, you never find out what's actually necessary."

**Engineering translation:** dead code, unused dependencies, redundant layers,
speculative "we might need it" generality, config flags nobody flips, build steps,
indirection, whole features with no users. Delete, then run the tests/types/build to
see what actually breaks. The compiler and the test suite are your "see what breaks."

### 3. Simplify and optimize

Third, not first. *After* you've questioned and deleted.

> "It's very common, possibly the most common error, to optimize something that should
> not exist."

The Model X falcon-wing doors were a masterpiece of optimization — sensors, motors,
hinges, months of engineering to make them work better. Musk later called them a
mistake: they shouldn't have existed. All that optimization was productive in the wrong
direction.

**Engineering translation:** now that the surface is minimal, make what remains clear,
cohesive, and correct — good names, low coupling, one responsibility per unit. For
performance, *measure first*: optimize the real bottleneck, not the one you imagined.
Optimizing code you should have deleted in step 2 is the falcon-wing door.

### 4. Accelerate cycle time

Only now do you speed things up. Musk is obsessed with cycle time: how fast can you go
from idea to execution to feedback? SpaceX builds and tests faster than anyone thought
possible, blowing prototypes up *intentionally* — each explosion is data, each failure
teaches. Outsiders saw failure; he saw rapid learning.

But it's step four for a reason. You don't speed up a bad process. Speed is a
multiplier: doing the wrong thing faster just gets you to the wrong place sooner.

**Engineering translation:** fast tests, fast local dev loop, fast deploy, cheap
reversible experiments, short feedback. Make failure cheap and informative so you can
iterate fast on the *right* thing — which you've already established in steps 1–3.

### 5. Automate

Last. Always last.

> "Excessive automation at Tesla was a mistake. Humans are underrated."

During Model 3 production Tesla automated everything — a lights-out factory, robots
doing all of it. It was a disaster: the automation was too complex, constantly broke,
and had automated processes that shouldn't have existed. They ripped out automation and
brought humans back for many tasks. Step five had been done before steps one through
four.

Automation locks things in. Once automated, a process is harder to change and becomes
invisible — it stops being questioned. So automate only what you've already questioned,
deleted down to essentials, simplified, and accelerated. And don't over-automate: keep
humans on the judgment-heavy, low-frequency, high-variance work.

**Engineering translation:** CI, scripts, codegen, scheduled jobs, hooks, bots —
applied to the stable, repetitive, well-understood steps. Automating a process you
haven't questioned freezes the waste and hides it from the next person who might have
deleted it.

## Why smart people get this backwards

Musk specifically warns about smart people. If you're smart, you can make almost
anything work better — find efficiencies in bad processes, polish bad ideas, make wrong
directions feel productive. Intelligence becomes a liability when it lets you avoid the
hard question of whether you're working on the right thing at all. The less-clever
engineer who *can't* make the bad process work is forced to ask whether the process
should exist — and sometimes that's the better instinct.

For an AI coding agent this is doubly true: you are fast and capable, so your default is
to *produce* — generate the file, add the abstraction, write the script. That fluency is
exactly the trap. The discipline is to spend your first moves questioning and deleting,
not building.

## The one question

Before optimizing, accelerating, or automating anything, ask:

> **Should this even exist?**

Have you questioned the requirement? Have you deleted everything you can? Most people
never get past step one. The advantage is in the steps nobody wants to do — questioning
and deleting — because they feel like going backwards. That's why they work.

Question. Delete. Simplify. Accelerate. Automate. In that order.
